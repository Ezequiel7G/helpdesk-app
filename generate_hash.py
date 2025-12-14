#!/usr/bin/env python3
"""
Script para generar hash de contraseñas para el sistema Help Desk
"""

from werkzeug.security import generate_password_hash

def main():
    print("=" * 50)
    print(" GENERADOR DE HASH DE CONTRASEÑAS")
    print(" Help Desk System")
    print("=" * 50)
    print()
    
    password = input("Ingrese la contraseña a hashear: ")
    
    if not password:
        print("❌ Error: La contraseña no puede estar vacía")
        return
    
    if len(password) < 6:
        print("⚠️  Advertencia: Se recomienda una contraseña de al menos 6 caracteres")
    
    hash_value = generate_password_hash(password)
    
    print()
    print("✅ Hash generado exitosamente:")
    print("-" * 50)
    print(hash_value)
    print("-" * 50)
    print()
    print("📝 Comando SQL para crear usuario:")
    print()
    print("INSERT INTO users (name, email, password_hash, role)")
    print(f"VALUES ('Admin', 'admin@example.com', '{hash_value}', 'ADMIN');")
    print()

if __name__ == "__main__":
    main()
