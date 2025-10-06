# Importa o cliente de teste do Flask
from app import app

# Garante que estamos usando um cliente de teste
app.config.update({
    "TESTING": True,
})
client = app.test_client()


def teste_home_route():
    """Testa se a rota principal ('/') está funcionando."""
    response = client.get('/')
    expected_message = "Olá! Minha API com banco de dados está no ar!"

    assert response.status_code == 200
    assert response.json['message'] == expected_message


def test_health_route_without_db():
    """
    Testa a rota de saúde.
    Nota: Este teste não verifica a conexão real com o DB,
    apenas se a rota responde corretamente.
    """
    response = client.get("/health")
    # 200 ou 500 se o DB não estiver de pé
    assert response.status_code == 200
    assert response.json['status'] == "UP"
