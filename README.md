# Projeto DevOps: API Multi-Container com Python, Docker e Terraform na AWS

[![Python CI](https://github.com/vitorhgdev/projeto-devops-aws/actions/workflows/ci.yml/badge.svg)](https://github.com/vitorhgdev/projeto-devops-aws/actions/workflows/ci.yml)


🚀 Sobre o Projeto
Este projeto é uma demonstração completa (de ponta-a-ponta) de um fluxo de trabalho DevOps. O objetivo foi pegar uma aplicação web multi-container (API Python/Flask + Banco de Dados PostgreSQL) e automatizar todo o seu ciclo de vida.

O processo inclui desde o desenvolvimento local com Docker Compose, passando pela verificação automatizada de qualidade do código (CI/CD com GitHub Actions), até o provisionamento e deploy automatizados da infraestrutura completa na nuvem da AWS usando Terraform.

Este repositório serve como um case prático das minhas habilidades em Cloud, DevOps, Automação e Segurança.

O que este projeto demonstra:
Desenvolvimento: Uma API RESTful em Python (Flask) conectada a um banco de dados PostgreSQL.

Containerização: Uso do Docker para empacotar a aplicação e do Docker Compose para orquestração local.

Infraestrutura como Código (IaC): Provisionamento de toda a infraestrutura (Instância EC2, Security Groups) na AWS com Terraform.

Deploy Automatizado: Uso de user_data no Terraform para, na inicialização do servidor, instalar automaticamente o Docker e subir a aplicação com docker compose.

CI/CD (Integração Contínua): Um pipeline com GitHub Actions que roda automaticamente flake8 (linting) e pytest (testes) a cada push.

Segurança (DevSecOps):

Gerenciamento de segredos locais com .env (não enviado ao GitHub).

Uso de GitHub Secrets para prover senhas ao pipeline de CI.

Configuração de um Security Group (firewall) restritivo na AWS.

Uso de usuário não-root dentro do Dockerfile.

🛠️ Tecnologias Utilizadas
Cloud & Infraestrutura: AWS (EC2, S3, Security Groups), Terraform (IaC)

Aplicação & Containers: Python (Flask), PostgreSQL, Docker, Docker Compose

CI/CD & Testes: GitHub Actions, Pytest, Flake8

⚙️ Como Executar o Projeto
Existem duas formas de executar este projeto:

Opção 1: Deploy Automatizado na AWS (Recomendado)
Esta opção provisiona a infraestrutura completa na nuvem e faz o deploy da aplicação.

Pré-requisitos:

Conta na AWS (você pode usar o [AWS Academy Learner Lab]]).

Terraform instalado.

Git instalado.

Passos:

Clone o repositório:

Bash

git clone https://github.com/vitorhgdev/projeto-devops-aws.git
cd projeto-devops-aws
Configure suas credenciais da AWS no seu terminal (necessário se estiver usando o Learner Lab).

(Importante: Segurança) Edite o arquivo main.tf, na regra do aws_security_group da porta 22 (SSH), e troque "0.0.0.0/0" pelo seu IP público (descubra no Google "meu ip") seguido de /32.

Inicialize o Terraform:

Bash

terraform init
Aplique a infraestrutura (o deploy pode levar de 3 a 5 minutos):

Bash

terraform apply
(Digite yes para confirmar).

Ao final, o Terraform mostrará o IP público do servidor. Acesse no seu navegador: http://SEU_IP_PUBLICO:5001

Opção 2: Execução Local (Para Testes Rápidos)
Esta opção sobe a aplicação na sua própria máquina usando o Docker Compose.

Pré-requisitos:

Docker e Docker Compose instalados.

Git instalado.

Passos:

Clone o repositório e entre na pasta.

Crie um arquivo .env na raiz do projeto (este arquivo é ignorado pelo Git):

POSTGRES_USER=myuser
POSTGRES_PASSWORD=mypassword
POSTGRES_DB=mydb
Suba os containers:

Bash

docker compose up --build
Acesse no seu navegador: http://localhost:5001

✒️ Autor
Vítor Hugo Bica

LinkedIn: linkedin.com/in/hugoovitoor

GitHub: @vitorhgdev