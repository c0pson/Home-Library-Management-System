import pytest

from app import create_app

def test_true():
    assert True

def test_config(app):
    assert app.testing

def test_root(client):
    response = client.get("/login")
    assert response.status_code == 200

