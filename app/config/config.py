import os

class Config:
    DB_HOST     = os.getenv("DB_HOST", "localhost")
    DB_PORT     = int(os.getenv("DB_PORT", "5432"))
    DB_NAME     = os.getenv("DB_NAME", "library")
    DB_USER     = os.getenv("DB_USER", "library_user")
    DB_PASSWORD = os.getenv("DB_PASSWORD", "library_password")
    SECRET_KEY  = os.getenv("SECRET_KEY", "dev-secret-key-change-in-production")
