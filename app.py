import os
from flask import Flask, jsonify, request
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import text
from sqlalchemy.exc import OperationalError

app = Flask(__name__)

# --- Configuração do Banco de Dados ---
# Docker Compose cria uma rede onde o hostname do serviço 'db' é 'db'.
# Usamos as variáveis de ambiente que definimos no docker-compose.yml.
db_user = os.environ.get('POSTGRES_USER')
db_password = os.environ.get('POSTGRES_PASSWORD')
db_name = os.environ.get('POSTGRES_DB')
# O nome do serviço do banco de dados no docker-compose
db_host = 'db'

app.config['SQLALCHEMY_DATABASE_URI'] = (
    f'postgresql://{db_user}:{db_password}@{db_host}/{db_name}'
)
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)


# --- Modelo da Tabela ---
# Uma classe que representa a nossa tabela 'tasks' no banco de dados.
class Task(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(80), nullable=False)
    description = db.Column(db.String(120))

    def to_json(self):
        return {
            'id': self.id,
            'title': self.title,
            'description': self.description
        }


# --- Rotas da API ---
@app.route('/')
def home():
    return jsonify(message="Olá! Minha API com banco de dados está no ar!")


@app.route('/health')
def health_check():
    # Vamos testar a conexão com o banco de dados nesta rota
    try:
        db.session.execute(text('SELECT 1'))
        return jsonify(status="UP", db_status="connected"), 200
    except OperationalError as e:
        return jsonify(
            status="UP",
            db_status="disconnected",
            error=str(e)
        ), 500


@app.route('/tasks', methods=['POST'])
def create_task():
    data = request.get_json()
    new_task = Task(
        title=data['title'],
        description=data.get('description', '')
    )
    db.session.add(new_task)
    db.session.commit()
    return jsonify(new_task.to_json()), 201


@app.route('/tasks', methods=['GET'])
def get_tasks():
    tasks = Task.query.all()
    return jsonify([task.to_json() for task in tasks])


# Cria a tabela no banco de dados se ela não existir
with app.app_context():
    db.create_all()

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
