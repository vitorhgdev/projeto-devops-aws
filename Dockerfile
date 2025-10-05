# Usar uma imagem oficial do Python
FROM python:3.9-slim

# --- ADICIONE ESTA SEÇÃO PARA INSTALAR DEPENDÊNCIAS DO SISTEMA ---
# Atualiza o gerenciador de pacotes e instala as dependências necessárias para o psycopg2
RUN apt-get update && apt-get install -y gcc libpq-dev

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar o arquivo de dependências para dentro do container
COPY requirements.txt .

# Instalar as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Copiar o resto do código da aplicação para dentro do container
COPY . .

# Expor a porta em que a aplicação roda
EXPOSE 5000

# Definir o comando para iniciar a aplicação quando o container subir
CMD [ "python", "app.py" ]