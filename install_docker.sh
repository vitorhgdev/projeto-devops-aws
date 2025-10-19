#!/bin/bash

# Atualiza os pacotes do servidor
sudo apt-get update -y

# Instala Git
sudo apt-get install -y git

# Instala o Docker Engine (pacote docker.io ainda funciona no Ubuntu 24.04)
sudo apt-get install -y docker.io

# Instala o Docker Compose Plugin
sudo apt-get install -y docker-compose-plugin

# Adiciona o usuário 'ubuntu' ao grupo do docker (AGORA DEVE FUNCIONAR)
# Usamos 'newgrp docker' temporariamente para aplicar a mudança de grupo sem reiniciar
# e adicionamos '|| true' para não falhar se o usuário já estiver no grupo
sudo usermod -aG docker ubuntu || true 
# newgrp docker # Este comando pode não funcionar bem em scripts não interativos, removeremos

# Clona o seu repositório do GitHub
git clone https://github.com/vitorhgdev/projeto-devops-aws.git /home/ubuntu/app

# Navega para a pasta do projeto e sobe os containers em background
cd /home/ubuntu/app
# Garante que o usuário ubuntu tenha permissão antes de rodar o compose
sudo chown ubuntu:ubuntu /home/ubuntu/app -R 
# Executa o compose como usuário ubuntu (usando sudo -u)
sudo -u ubuntu docker compose up -d