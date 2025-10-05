terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

# Configura o provedor da AWS
provider "aws" {
    resource "aws_instance" "meu_servidor_web" {
      # Imagem do Ubuntu Server 22.04 LTS na região us-east-1
      ami = "ami-0c55b159cbfafe1f0"

      # Tipo de máquina do plano gratuito(Free Tier) da AWS
      instance_type = "t2.micro"

      tags = {
        Name = "Meu-Servidor-API"
      }
  }
}