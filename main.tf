terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configura o provedor da AWS
provider "aws" {
  region = "us-east-1"
}

# Cria um grupo de segurança (firewall)
resource "aws_security_group" "meu_firewall" {
  name = "meu-firewall-api"
  description = "Permite acesso a porta da API e SSH"

  # Permite acesso à porta 5001 (API) de qualquer IP
  ingress {
    from_port = 5001
    to_port = 5001
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Permite acesso SSH (porta 22) de qualquer IP (Ajuste se necessário por segurança)
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permite que o servidor acesse qualquer coisa na internet
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Descreve o recurso a ser criado
resource "aws_instance" "meu_servidor_web" {
  # Imagem ATUALIZADA do Ubuntu Server 22.04 LTS na região us-east-1
  ami           = "ami-0b72f4a84c39bcd30"

  # Tipo de máquina do plano gratuito (Free Tier) da AWS
  instance_type = "t2.micro"

  # Associa o servidor ao nosso firewall
  vpc_security_group_ids = [aws_security_group.meu_firewall.id]

  # Executa nosso script de instalação na inicialização
  user_data = file("install_docker.sh")

  tags = {
    Name = "Meu-Servidor-API-Completo"
  }
}

# Mostra o IP público do servidor no final
output "ip_publico_do_servidor" {
  value = aws_instance.meu_servidor_web.public_ip
}