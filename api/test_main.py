from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_current_Season():
    response = client.get("/")
    assert response.status_code == 200

