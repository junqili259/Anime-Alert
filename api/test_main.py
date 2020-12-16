from fastapi.testclient import TestClient
from main import app

client = TestClient(app)

def test_currentSeason():
    response = client.get("/")
    assert response.status_code == 200


def test_anySeason():
    response = client.get("/season?season=SUMMER&seasonYear=2020")
    assert response.status_code == 200