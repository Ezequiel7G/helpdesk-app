import os
from dotenv import load_dotenv

load_dotenv()

class Config:
    """Configuration class for Flask application"""
    
    SECRET_KEY = os.getenv("SECRET_KEY", "dev-secret-key-change-this-in-production")
    DB_HOST = os.getenv("DB_HOST", "localhost")
    DB_USER = os.getenv("DB_USER", "root")
    DB_PASSWORD = os.getenv("DB_PASSWORD", "")
    DB_NAME = os.getenv("DB_NAME", "helpdesk_db")
    
    # Session configuration
    SESSION_COOKIE_SECURE = False  # Set to True in production with HTTPS
    SESSION_COOKIE_HTTPONLY = True
    SESSION_COOKIE_SAMESITE = 'Lax'
    
    # Development settings
    DEBUG = os.getenv("FLASK_ENV") != "production"
