# Usar uma imagem oficial do Python
FROM python:3.11-slim

# --- ADICIONE ESTA SEÇÃO PARA INSTALAR DEPENDÊNCIAS DO SISTEMA ---
# Atualiza o gerenciador de pacotes e instala as dependências necessárias para o psycopg2
RUN apt-get update && apt-get install -y gcc libpq-dev

# Cria um usuário e grupo não-root
RUN addgroup --system app && adduser --system --group app

# Definir o diretório de trabalho dentro do container
WORKDIR /app

# Copiar o arquivo de dependências para dentro do container
COPY requirements.txt .

# Instalar as dependências
RUN pip install --no-cache-dir -r requirements.txt

# Copiar o resto do código da aplicação para dentro do container
COPY . .

# Define o dono da pasta como o usuário 'app'
RUN command chown -R app:app /app

# Muda para o usuário não-root
USER app

# Expor a porta em que a aplicação roda
EXPOSE 5000

# Definir o comando para iniciar a aplicação quando o container subir
CMD [ "python", "app.py" ]