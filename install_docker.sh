#!/bin/bash
# O 'set -e' faz o script parar imediatamente se algum comando falhar
set -e 

# 1. Atualiza pacotes e instala pré-requisitos (incluindo git)
sudo apt-get update -y
sudo apt-get install -y ca-certificates curl git gnupg lsb-release

# 2. Adiciona a chave GPG oficial do Docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# 3. Adiciona o repositório do Docker às fontes do Apt
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

# 4. Instala o Docker Engine, CLI, Containerd e o Docker Compose Plugin
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 5. Adiciona o usuário 'ubuntu' ao grupo docker
sudo usermod -aG docker ubuntu || true

# 6. Clona o repositório do GitHub (agora o git existe)
git clone https://github.com/vitorhgdev/projeto-devops-aws.git /home/ubuntu/app

# 7. Define o usuário ubuntu como dono da pasta
sudo chown ubuntu:ubuntu /home/ubuntu/app -R

# 8. Navega para a pasta e sobe os containers como usuário ubuntu
cd /home/ubuntu/app
sudo -u ubuntu docker compose up -d