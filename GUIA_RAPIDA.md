# 🚀 Guía Rápida de Inicio - Help Desk System

## ⚡ Pasos Rápidos para Ejecutar el Proyecto

### 1️⃣ Preparar el Entorno (5 minutos)

```bash
# Clonar o descargar el proyecto
cd helpdesk_app

# Crear entorno virtual
python -m venv venv

# Activar entorno virtual
# Windows:
venv\Scripts\activate
# macOS/Linux:
source venv/bin/activate

# Instalar dependencias
pip install -r requirements.txt
```

### 2️⃣ Configurar la Base de Datos (10 minutos)

```bash
# Iniciar MariaDB
mysql -u root -p
```

```sql
# En la consola de MariaDB, ejecutar:
source docs/database_schema.sql;

# O copiar y pegar el contenido del archivo database_schema.sql
```

### 3️⃣ Crear Usuario Administrador

```python
# En una terminal Python:
python
>>> from werkzeug.security import generate_password_hash
>>> print(generate_password_hash("admin123"))
# Copiar el hash generado
```

```sql
# En MariaDB:
USE helpdesk_db;
INSERT INTO users (name, email, password_hash, role)
VALUES ('Admin', 'admin@example.com', 'PEGAR_HASH_AQUI', 'ADMIN');
```

### 4️⃣ Configurar Variables de Entorno (2 minutos)

```bash
# Copiar el archivo de ejemplo
cp .env.example .env

# Editar .env con tus datos:
# - Cambiar SECRET_KEY por una clave segura
# - Actualizar DB_PASSWORD con tu contraseña de MySQL
```

### 5️⃣ Ejecutar la Aplicación (1 minuto)

```bash
python app.py
```

### 6️⃣ Acceder al Sistema

Abrir navegador en: **http://localhost:5000**

**Credenciales iniciales:**
- Email: admin@example.com
- Password: admin123

---

## 🔧 Solución de Problemas Comunes

### Error: "Can't connect to MySQL"
✅ Verificar que MariaDB esté corriendo
✅ Revisar credenciales en .env

### Error: "Module not found"
✅ Activar el entorno virtual
✅ Ejecutar: `pip install -r requirements.txt`

### La página no carga
✅ Verificar que Flask esté corriendo en puerto 5000
✅ Verificar firewall

---

## 📋 Checklist Rápido

- [ ] Python 3.8+ instalado
- [ ] MariaDB instalado y corriendo
- [ ] Entorno virtual creado y activado
- [ ] Dependencias instaladas
- [ ] Base de datos creada
- [ ] Usuario admin creado
- [ ] Archivo .env configurado
- [ ] Flask ejecutándose
- [ ] Acceso al login exitoso

---

## 🎯 Próximos Pasos

1. Cambiar contraseña del admin
2. Crear usuarios de prueba (AGENT y USER)
3. Crear tickets de prueba
4. Explorar el sistema
5. Leer la documentación completa en `docs/`

---

## 📚 Documentación Completa

- **Manual de Usuario:** `docs/manual_usuario.md`
- **Manual Técnico:** `docs/manual_tecnico.md`
- **README Principal:** `README.md`

---

¡Listo para empezar! 🎉
