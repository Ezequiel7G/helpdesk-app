# Manual Técnico - Sistema Help Desk

## Índice

1. [Arquitectura del Sistema](#arquitectura-del-sistema)
2. [Tecnologías Utilizadas](#tecnologías-utilizadas)
3. [Modelo de Base de Datos](#modelo-de-base-de-datos)
4. [Instalación y Configuración](#instalación-y-configuración)
5. [Estructura del Proyecto](#estructura-del-proyecto)
6. [Endpoints y Rutas](#endpoints-y-rutas)
7. [Seguridad](#seguridad)
8. [Mejoras Futuras](#mejoras-futuras)

---

## Arquitectura del Sistema

El sistema sigue una arquitectura de tres capas:

```
┌─────────────────────────────────────────┐
│   CAPA DE PRESENTACIÓN                  │
│   (HTML + Bootstrap + jQuery)           │
│   - Templates Jinja2                    │
│   - CSS personalizado                   │
│   - JavaScript/jQuery                   │
└─────────────────────────────────────────┘
                  ↓ HTTP
┌─────────────────────────────────────────┐
│   CAPA DE APLICACIÓN                    │
│   (Flask - Python)                      │
│   - Rutas y controladores               │
│   - Lógica de negocio                   │
│   - Autenticación y autorización        │
│   - Validación de datos                 │
└─────────────────────────────────────────┘
                  ↓ SQL
┌─────────────────────────────────────────┐
│   CAPA DE DATOS                         │
│   (MariaDB)                             │
│   - Almacenamiento persistente          │
│   - Integridad referencial              │
│   - Transacciones                       │
└─────────────────────────────────────────┘
```

### Patrón de Diseño

- **MVC (Model-View-Controller)** adaptado a Flask
- **RESTful principles** para las rutas HTTP
- **Session-based authentication** para manejo de usuarios

---

## Tecnologías Utilizadas

### Backend

- **Flask 3.x** - Framework web de Python
- **PyMySQL** - Conector Python-MariaDB
- **Werkzeug** - Utilidades WSGI (hashing de contraseñas)
- **Python-dotenv** - Gestión de variables de entorno

### Frontend

- **Bootstrap 5.3.3** - Framework CSS responsivo
- **jQuery 3.7.1** - Biblioteca JavaScript
- **Jinja2** - Motor de templates (integrado en Flask)

### Base de Datos

- **MariaDB 10.x** - Sistema de gestión de bases de datos relacional

### Control de Versiones

- **Git** - Sistema de control de versiones
- **GitHub** - Plataforma de alojamiento de código

---

## Modelo de Base de Datos

### Diagrama Entidad-Relación

```
┌──────────────────┐         ┌──────────────────┐
│     users        │         │     tickets      │
├──────────────────┤         ├──────────────────┤
│ id (PK)          │────┐    │ id (PK)          │
│ name             │    │    │ title            │
│ email (UNIQUE)   │    │    │ description      │
│ password_hash    │    │    │ status           │
│ role             │    │    │ priority         │
│ created_at       │    │    │ created_at       │
└──────────────────┘    │    │ updated_at       │
                        ├───→│ created_by (FK)  │
                        │    │ assigned_to (FK) │
                        │    └──────────────────┘
                        │              │
                        │              │
                        │    ┌──────────────────────┐
                        │    │ ticket_comments      │
                        │    ├──────────────────────┤
                        │    │ id (PK)              │
                        └───→│ user_id (FK)         │
                             │ ticket_id (FK)       │
                             │ comment              │
                             │ created_at           │
                             └──────────────────────┘
```

### Descripción de Tablas

#### Tabla: `users`

Almacena información de usuarios del sistema.

| Campo         | Tipo         | Descripción                  |
| ------------- | ------------ | ---------------------------- |
| id            | INT (PK)     | Identificador único          |
| name          | VARCHAR(100) | Nombre del usuario           |
| email         | VARCHAR(150) | Email (único)                |
| password_hash | VARCHAR(255) | Contraseña hasheada (bcrypt) |
| role          | ENUM         | ADMIN, AGENT, USER           |
| created_at    | DATETIME     | Fecha de creación            |

**Índices:**

- PRIMARY KEY: id
- UNIQUE KEY: email

#### Tabla: `tickets`

Almacena los tickets de soporte.

| Campo       | Tipo         | Descripción                 |
| ----------- | ------------ | --------------------------- |
| id          | INT (PK)     | Identificador único         |
| title       | VARCHAR(200) | Título del ticket           |
| description | TEXT         | Descripción detallada       |
| status      | ENUM         | OPEN, IN_PROGRESS, RESOLVED |
| priority    | ENUM         | LOW, MEDIUM, HIGH           |
| created_at  | DATETIME     | Fecha de creación           |
| updated_at  | DATETIME     | Última actualización        |
| created_by  | INT (FK)     | Usuario que creó el ticket  |
| assigned_to | INT (FK)     | Agente asignado (nullable)  |

**Relaciones:**

- `created_by` → `users.id` (ON DELETE: restrict)
- `assigned_to` → `users.id` (ON DELETE: set null)

#### Tabla: `ticket_comments`

Almacena comentarios en los tickets.

| Campo      | Tipo     | Descripción              |
| ---------- | -------- | ------------------------ |
| id         | INT (PK) | Identificador único      |
| ticket_id  | INT (FK) | Ticket asociado          |
| user_id    | INT (FK) | Usuario que comentó      |
| comment    | TEXT     | Contenido del comentario |
| created_at | DATETIME | Fecha de creación        |

**Relaciones:**

- `ticket_id` → `tickets.id` (ON DELETE: cascade)
- `user_id` → `users.id` (ON DELETE: cascade)

---

## Instalación y Configuración

### Requisitos Previos

- Python 3.8 o superior
- MariaDB 10.3 o superior
- Git

### Paso 1: Clonar el Repositorio

```bash
git clone https://github.com/Ezequiel7G/helpdesk-app.git
cd helpdesk-app
```

### Paso 2: Crear Entorno Virtual

```bash
# Crear entorno virtual
python -m venv venv

# Activar entorno virtual
# En Windows:
venv\Scripts\activate
# En macOS/Linux:
source venv/bin/activate
```

### Paso 3: Instalar Dependencias

```bash
pip install -r requirements.txt
```

**Contenido de `requirements.txt`:**

```
Flask
pymysql
python-dotenv
Werkzeug
```

### Paso 4: Configurar Base de Datos

1. **Acceder a MariaDB:**

```bash
mysql -u root -p
```

2. **Ejecutar el script SQL:**

```sql
CREATE DATABASE helpdesk_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE helpdesk_db;

-- Copiar y ejecutar todo el contenido del script SQL
-- (Ver sección Modelo de Base de Datos)
```

3. **Crear usuario administrador inicial:**

```python
# Generar hash de contraseña
from werkzeug.security import generate_password_hash
print(generate_password_hash("admin123"))
```

```sql
INSERT INTO users (name, email, password_hash, role)
VALUES ('Admin', 'admin@example.com', 'HASH_GENERADO', 'ADMIN');
```

### Paso 5: Configurar Variables de Entorno

Crear archivo `.env` en la raíz del proyecto:

```env
SECRET_KEY=tu_clave_secreta_muy_larga_y_compleja_cambiala
DB_HOST=localhost
DB_USER=root
DB_PASSWORD=tu_password_mysql
DB_NAME=helpdesk_db
```

**Importante:** Nunca subir el archivo `.env` a GitHub. Agregar a `.gitignore`:

```
venv/
__pycache__/
*.pyc
.env
*.db
```

### Paso 6: Ejecutar la Aplicación

```bash
python app.py
```

La aplicación estará disponible en: `http://localhost:5000`

### Paso 7: Acceso Inicial

- **URL:** http://localhost:5000
- **Usuario:** admin@example.com
- **Contraseña:** admin123

---

## Estructura del Proyecto

```
helpdesk_app/
├── app.py                    # Aplicación principal Flask
├── config.py                 # Configuración de la aplicación
├── requirements.txt          # Dependencias Python
├── .env                      # Variables de entorno (no incluir en Git)
├── .gitignore               # Archivos ignorados por Git
├── README.md                # Documentación principal
│
├── templates/               # Templates Jinja2
│   ├── base.html           # Template base
│   ├── login.html          # Página de login
│   ├── dashboard.html      # Dashboard principal
│   ├── tickets_list.html   # Lista de tickets
│   ├── ticket_detail.html  # Detalle de ticket
│   ├── ticket_new.html     # Crear ticket
│   └── users_list.html     # Lista de usuarios (admin)
│
├── static/                  # Archivos estáticos
│   ├── css/
│   │   └── custom.css      # Estilos personalizados
│   └── js/
│       └── main.js         # JavaScript/jQuery
│
└── docs/                    # Documentación
    ├── manual_usuario.md   # Manual de usuario
    ├── manual_tecnico.md   # Manual técnico (este archivo)
    ├── er_diagram.png      # Diagrama ER
    └── screenshots/        # Capturas de pantalla
        ├── login.png
        ├── dashboard.png
        ├── tickets_list.png
        ├── ticket_detail.png
        └── users_list.png
```

---

## Endpoints y Rutas

### Rutas Públicas

| Método | Ruta      | Descripción     | Template   |
| ------ | --------- | --------------- | ---------- |
| GET    | `/`       | Redirección     | -          |
| GET    | `/login`  | Página de login | login.html |
| POST   | `/login`  | Procesar login  | -          |
| GET    | `/logout` | Cerrar sesión   | -          |

### Rutas Protegidas (Requieren Login)

| Método | Ruta                     | Descripción             | Roles        | Template           |
| ------ | ------------------------ | ----------------------- | ------------ | ------------------ |
| GET    | `/dashboard`             | Panel principal         | Todos        | dashboard.html     |
| GET    | `/tickets`               | Lista de tickets        | Todos        | tickets_list.html  |
| GET    | `/tickets/new`           | Formulario nuevo ticket | Todos        | ticket_new.html    |
| POST   | `/tickets/new`           | Crear ticket            | Todos        | -                  |
| GET    | `/tickets/<id>`          | Detalle de ticket       | Todos        | ticket_detail.html |
| POST   | `/tickets/<id>/update`   | Actualizar ticket       | ADMIN, AGENT | -                  |
| POST   | `/tickets/<id>/comments` | Agregar comentario      | Todos        | -                  |
| GET    | `/users`                 | Lista de usuarios       | ADMIN        | users_list.html    |
| POST   | `/users/<id>/role`       | Cambiar rol             | ADMIN        | -                  |

### Lógica de Filtrado de Tickets

```python
# ADMIN: Ve todos los tickets
SELECT * FROM tickets ORDER BY created_at DESC

# AGENT: Ve tickets asignados o sin asignar
SELECT * FROM tickets
WHERE assigned_to = <user_id> OR assigned_to IS NULL
ORDER BY created_at DESC

# USER: Ve solo sus tickets
SELECT * FROM tickets
WHERE created_by = <user_id>
ORDER BY created_at DESC
```

---

## Seguridad

### 1. Autenticación

**Implementación:**

- Contraseñas hasheadas con `Werkzeug.security` (bcrypt)
- Session-based authentication con Flask sessions
- `SECRET_KEY` fuerte para firmar cookies de sesión

**Código relevante:**

```python
from werkzeug.security import generate_password_hash, check_password_hash

# Al crear usuario
password_hash = generate_password_hash("password")

# Al verificar login
if check_password_hash(user["password_hash"], password):
    # Login exitoso
```

### 2. Autorización

**Decoradores personalizados:**

```python
@login_required
def protected_route():
    # Solo usuarios autenticados

@role_required("ADMIN", "AGENT")
def admin_agent_only():
    # Solo admin y agentes
```

### 3. Prevención de SQL Injection

**Uso de consultas parametrizadas:**

```python
# ✅ CORRECTO
cursor.execute("SELECT * FROM users WHERE email = %s", (email,))

# ❌ INCORRECTO - Vulnerable a SQL injection
cursor.execute(f"SELECT * FROM users WHERE email = '{email}'")
```

### 4. Protección CSRF

**Recomendación:** Implementar Flask-WTF para protección CSRF en producción.

```python
# Instalación futura
pip install Flask-WTF

# Uso en formularios
from flask_wtf import FlaskForm
```

### 5. Variables de Entorno

- Uso de `.env` para credenciales sensibles
- `.env` incluido en `.gitignore`
- Nunca hardcodear passwords en el código

### 6. Modo Debug

**IMPORTANTE:** Desactivar en producción

```python
if __name__ == "__main__":
    app.run(debug=False)  # False en producción
```

### 7. Sesiones Seguras

```python
app.config['SESSION_COOKIE_SECURE'] = True      # Solo HTTPS
app.config['SESSION_COOKIE_HTTPONLY'] = True    # No accesible por JS
app.config['SESSION_COOKIE_SAMESITE'] = 'Lax'   # Protección CSRF
```

---

## Configuración de Producción

### Usar un Servidor WSGI

**Gunicorn (recomendado):**

```bash
pip install gunicorn
gunicorn -w 4 -b 0.0.0.0:8000 app:app
```

**uWSGI:**

```bash
pip install uwsgi
uwsgi --http 0.0.0.0:8000 --wsgi-file app.py --callable app
```

### Configurar Nginx como Reverse Proxy

```nginx
server {
    listen 80;
    server_name helpdesk.tudominio.com;

    location / {
        proxy_pass http://localhost:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }
}
```

### Variables de Entorno en Producción

```env
FLASK_ENV=production
SECRET_KEY=clave_extremadamente_segura_y_larga
DB_HOST=servidor_bd_produccion
DB_USER=usuario_bd_produccion
DB_PASSWORD=password_seguro
DB_NAME=helpdesk_db
```

---

## Mejoras Futuras

### Corto Plazo

1. **Sistema de notificaciones por email**

   - Notificar cuando se asigna un ticket
   - Notificar cuando se agrega un comentario
   - Usar Flask-Mail o SMTP

2. **Búsqueda y filtros avanzados**

   - Buscar por palabra clave
   - Filtrar por estado, prioridad, fecha
   - Ordenamiento personalizado

3. **Paginación de tickets**

   - Limitar resultados por página
   - Mejorar rendimiento con muchos tickets

4. **Exportar reportes**
   - Generar PDF de tickets
   - Exportar a Excel/CSV
   - Estadísticas detalladas

### Mediano Plazo

5. **Sistema de archivos adjuntos**

   - Permitir subir imágenes/documentos
   - Almacenar en servidor o cloud (AWS S3)

6. **Chat en tiempo real**

   - Implementar WebSockets (Flask-SocketIO)
   - Chat instantáneo en tickets

7. **API RESTful**

   - Endpoints JSON para integración
   - Autenticación con JWT tokens
   - Documentación con Swagger

8. **Dashboard con gráficos**
   - Gráficos de tickets por estado
   - Tendencias temporales
   - Usar Chart.js o Plotly

### Largo Plazo

9. **Autenticación de dos factores (2FA)**

   - Mayor seguridad para admin
   - Usar Google Authenticator

10. **Sistema de SLA (Service Level Agreement)**

    - Tiempos de respuesta por prioridad
    - Alertas de tickets vencidos

11. **Base de conocimientos**

    - Wiki con soluciones comunes
    - Búsqueda de artículos de ayuda

12. **Integración con herramientas externas**
    - Slack/Teams para notificaciones
    - Jira para sincronización
    - GitHub para issues

---

## Resolución de Problemas

### Error: "Can't connect to MySQL server"

**Solución:**

1. Verificar que MariaDB esté ejecutándose:

```bash
# Windows
net start MySQL

# Linux/Mac
sudo systemctl start mariadb
```

2. Verificar credenciales en `.env`

3. Verificar firewall/permisos

### Error: "ImportError: No module named 'flask'"

**Solución:**

```bash
# Verificar que el entorno virtual esté activado
source venv/bin/activate  # Mac/Linux
venv\Scripts\activate     # Windows

# Reinstalar dependencias
pip install -r requirements.txt
```

### Error: "werkzeug.routing.BuildError"

**Solución:**

- Verificar que el nombre de la ruta coincida con `url_for('nombre_ruta')`
- Verificar que todos los templates existan

### La sesión no persiste entre peticiones

**Solución:**

- Verificar que `SECRET_KEY` esté configurado
- Verificar que las cookies estén habilitadas en el navegador

---

## Testing

### Tests Básicos Recomendados

```python
# test_app.py
import unittest
from app import app

class TestHelpDesk(unittest.TestCase):

    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_login_page(self):
        response = self.app.get('/login')
        self.assertEqual(response.status_code, 200)

    def test_dashboard_redirect_when_not_logged_in(self):
        response = self.app.get('/dashboard')
        self.assertEqual(response.status_code, 302)  # Redirect

if __name__ == '__main__':
    unittest.main()
```

**Ejecutar tests:**

```bash
python -m unittest test_app.py
```

---

## Contribución

### Flujo de Trabajo Git

```bash
# Crear nueva rama para feature
git checkout -b feature/nueva-funcionalidad

# Hacer commits descriptivos
git commit -m "feat: agregar búsqueda de tickets"

# Hacer push
git push origin feature/nueva-funcionalidad

# Crear Pull Request en GitHub
```

### Convenciones de Código

- Seguir **PEP 8** para Python
- Usar nombres descriptivos para variables y funciones
- Comentar código complejo
- Mantener funciones pequeñas y enfocadas

---

## Contacto y Soporte

- **Repositorio GitHub:** https://github.com/tu-usuario/helpdesk-app
- **Documentación:** Ver carpeta `docs/`
- **Issues:** Reportar en GitHub Issues

---

**Versión del Sistema:** 1.0  
**Fecha de Última Actualización:** Diciembre 2024  
**Autor:** [Tu Nombre]  
**Licencia:** MIT
