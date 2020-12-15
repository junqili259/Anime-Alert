from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_current_Season():
    response = client.get("/")
    assert response.status_code == 200


def test_any_Season():
    
    response = client.get("/season?season=SUMMER&seasonYear=2020")
    assert response.status_code == 200
    