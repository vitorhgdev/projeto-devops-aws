# Projeto DevOps: API Multi-Container com Python, Docker e Terraform na AWS

[![Python CI](https://github.com/vitorhgdev/projeto-devops-aws/actions/workflows/ci.yml/badge.svg)](https://github.com/vitorhgdev/projeto-devops-aws/actions/workflows/ci.yml)

## 🚀 Sobre o Projeto

Este projeto demonstra um fluxo de trabalho completo de desenvolvimento e infraestrutura, simulando um ambiente de produção real. O objetivo é fazer o deploy de uma aplicação web multi-container, composta por uma API em Python (Flask) que se conecta a um banco de dados PostgreSQL.

A aplicação é totalmente gerenciada localmente pelo Docker Compose, e o plano final é que toda a infraestrutura na nuvem da AWS seja provisionada e gerenciada via Infraestrutura como Código (IaC) com Terraform.

Este repositório serve como um case prático dos meus conhecimentos em tecnologias de Cloud & DevOps.

---

## 🛠️ Tecnologias Utilizadas

| Categoria | Tecnologia |
| --- | --- |
| **Cloud Provider** | ![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white) |
| **IaC** | ![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white) |
| **Containerização** | ![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white) |
| **Orquestração Local**| ![Docker Compose](https://img.shields.io/badge/Docker_Compose-3B74A7?style=for-the-badge&logo=docker&logoColor=white) |
| **Linguagem** | ![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white) |
| **Framework Web**| ![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white) |
| **Banco de Dados** | ![PostgreSQL](https://img.shields.io/badge/PostgreSQL-4169E1?style=for-the-badge&logo=postgresql&logoColor=white) |

---

## ⚙️ Como Executar o Projeto (Localmente com Docker Compose)

Para executar este projeto em sua máquina, você precisará ter o Git, Docker e Docker Compose instalados.

1.  **Clone o repositório:**
    ```bash
    git clone [https://github.com/vitorhgdev/projeto-devops-aws.git](https://github.com/vitorhgdev/projeto-devops-aws.git)
    cd projeto-devops-aws
    ```

2.  **Suba os containers:**
    * Este comando irá construir a imagem da API, baixar a imagem do PostgreSQL e iniciar os dois serviços em uma rede compartilhada.
    ```bash
    docker-compose up --build
    ```
    Aguarde até que os logs se estabilizem e mostrem que tanto o banco de dados quanto a API estão rodando.

3.  **Teste os Endpoints:**
    * **Verificar a saúde da aplicação e a conexão com o banco:**
      * Abra o navegador em `http://localhost:5001/health`. A resposta deve ser `{"db_status": "connected", "status": "UP"}`.

    * **Adicionar uma nova tarefa via terminal (usando `curl`):**
      ```bash
      curl -X POST -H "Content-Type: application/json" -d "{\"title\": \"Finalizar o README\", \"description\": \"Deixar o portfólio incrível\"}" http://localhost:5001/tasks
      ```

    * **Listar todas as tarefas no navegador:**
      * Acesse `http://localhost:5001/tasks` para ver a tarefa que você acabou de criar.

4.  **Para desligar a aplicação:**
    * No terminal onde o `docker-compose` está rodando, pressione `Ctrl+C`.

---

## ✒️ Autor

**Vítor Hugo Bica**

* **LinkedIn:** [linkedin.com/in/hugoovito-r](https://www.linkedin.com/in/hugoovitoor/)
* **GitHub:** [@vitorhgdev](https://github.com/vitorhgdev)