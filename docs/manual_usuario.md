# Manual de Usuario - Sistema Help Desk

## Índice
1. [Introducción](#introducción)
2. [Acceso al Sistema](#acceso-al-sistema)
3. [Roles y Permisos](#roles-y-permisos)
4. [Funcionalidades por Rol](#funcionalidades-por-rol)
5. [Preguntas Frecuentes](#preguntas-frecuentes)

---

## Introducción

El Sistema de Help Desk es una aplicación web diseñada para gestionar solicitudes de soporte técnico de manera eficiente. Permite a los usuarios reportar problemas, hacer seguimiento de sus tickets y comunicarse con el equipo de soporte.

### Características Principales
- ✅ Creación y gestión de tickets de soporte
- ✅ Sistema de comentarios en tiempo real
- ✅ Asignación de tickets a agentes
- ✅ Seguimiento de estado y prioridad
- ✅ Panel de control con estadísticas
- ✅ Administración de usuarios y roles

---

## Acceso al Sistema

### Inicio de Sesión

1. **Abrir la aplicación** en su navegador web (URL: `http://localhost:5000`)
2. **Ingresar credenciales:**
   - Email: su dirección de correo registrada
   - Password: su contraseña
3. **Hacer clic en "Login"**

### Credenciales de Prueba

Para propósitos de demostración:
- **Administrador:** admin@example.com / admin123

### Cierre de Sesión

Para cerrar sesión de forma segura:
1. Hacer clic en su nombre en la esquina superior derecha
2. Seleccionar "Logout" del menú desplegable

---

## Roles y Permisos

El sistema cuenta con tres roles principales:

### 👤 USER (Usuario)
**Permisos:**
- ✅ Crear tickets de soporte
- ✅ Ver sus propios tickets
- ✅ Agregar comentarios a sus tickets
- ✅ Ver el estado y progreso de sus solicitudes

**No puede:**
- ❌ Ver tickets de otros usuarios
- ❌ Modificar el estado de tickets
- ❌ Asignar tickets a agentes

### 🛠️ AGENT (Agente de Soporte)
**Permisos:**
- ✅ Todo lo que puede hacer un USER
- ✅ Ver tickets asignados a ellos
- ✅ Ver tickets sin asignar
- ✅ Cambiar el estado de tickets
- ✅ Asignar tickets a otros agentes
- ✅ Agregar comentarios a cualquier ticket asignado

**No puede:**
- ❌ Administrar usuarios
- ❌ Ver todos los tickets del sistema

### 👑 ADMIN (Administrador)
**Permisos:**
- ✅ Acceso completo al sistema
- ✅ Ver todos los tickets
- ✅ Modificar cualquier ticket
- ✅ Administrar usuarios
- ✅ Cambiar roles de usuarios
- ✅ Asignar tickets a cualquier agente

---

## Funcionalidades por Rol

### Para USUARIOS

#### 1. Crear un Nuevo Ticket

1. Desde el Dashboard, hacer clic en **"Create New Ticket"**
2. Completar el formulario:
   - **Título:** Resumen breve del problema (ej: "Error al iniciar sesión")
   - **Descripción:** Explicación detallada del problema
   - **Prioridad:** Seleccionar entre:
     - 🟢 LOW: Consulta general o problema menor
     - 🟡 MEDIUM: Importante pero no urgente
     - 🔴 HIGH: Problema urgente que afecta el trabajo
3. Hacer clic en **"Create Ticket"**

**Consejo:** Sea lo más específico posible en la descripción para recibir ayuda más rápida.

#### 2. Ver Mis Tickets

1. Ir a la sección **"Tickets"** en el menú superior
2. Ver la lista de todos sus tickets con:
   - Número de ticket
   - Título
   - Estado actual
   - Prioridad
   - Fecha de creación

#### 3. Ver Detalle de un Ticket

1. En la lista de tickets, hacer clic en el número o título del ticket
2. Ver información completa:
   - Descripción del problema
   - Estado y prioridad
   - Agente asignado
   - Historial de comentarios
   - Fechas de creación y actualización

#### 4. Agregar Comentarios

En la página de detalle del ticket:
1. Desplazarse a la sección **"Comments"**
2. Escribir su mensaje en el campo de texto
3. Hacer clic en **"Add Comment"**

**Uso recomendado:**
- Proporcionar información adicional
- Actualizar sobre el problema
- Hacer preguntas al agente asignado
- Confirmar si el problema fue resuelto

---

### Para AGENTES

Los agentes tienen todas las funcionalidades de los usuarios, más:

#### 1. Ver Tickets Asignados

- Los tickets aparecerán automáticamente en su lista de tickets
- Pueden ver tickets asignados a ellos y tickets sin asignar

#### 2. Actualizar Estado de Tickets

En la página de detalle del ticket:
1. Localizar la sección **"Update Ticket"**
2. Cambiar el **Estado:**
   - **OPEN:** Ticket nuevo o sin atender
   - **IN_PROGRESS:** Trabajando activamente en el problema
   - **RESOLVED:** Problema solucionado
3. Opcionalmente, asignar a otro agente
4. Hacer clic en **"Update"**

#### 3. Comunicarse con Usuarios

- Usar la sección de comentarios para:
  - Solicitar información adicional
  - Informar sobre el progreso
  - Explicar la solución implementada

---

### Para ADMINISTRADORES

Los administradores tienen acceso completo, incluyendo:

#### 1. Gestión de Usuarios

1. Ir a **"Users"** en el menú superior
2. Ver lista completa de usuarios con:
   - ID, nombre y email
   - Rol actual
   - Fecha de creación

#### 2. Cambiar Roles de Usuarios

1. En la tabla de usuarios, localizar al usuario
2. Seleccionar el nuevo rol en el menú desplegable
3. Hacer clic en **"Save"**

**Importante:** Tenga cuidado al asignar el rol ADMIN, ya que otorga acceso completo al sistema.

#### 3. Ver Todos los Tickets

- El administrador puede ver y gestionar todos los tickets del sistema
- Útil para supervisión y auditoría

---

## Dashboard (Panel de Control)

El Dashboard muestra información resumida:

### Estadísticas Visibles
- **Total Tickets:** Número total de tickets en su alcance
- **OPEN:** Tickets nuevos sin atender
- **IN_PROGRESS:** Tickets en proceso de resolución
- **RESOLVED:** Tickets completados

### Acciones Rápidas
- Botón para crear nuevo ticket
- Enlace para ver todos los tickets
- Información sobre su rol y permisos

---

## Interpretación de Estados

### 🟡 OPEN (Abierto)
- El ticket fue creado pero aún no ha sido asignado o atendido
- Estado inicial de todos los tickets nuevos

### 🔵 IN_PROGRESS (En Progreso)
- Un agente está trabajando activamente en el problema
- Se espera una resolución pronto

### 🟢 RESOLVED (Resuelto)
- El problema ha sido solucionado
- El ticket está cerrado

---

## Interpretación de Prioridades

### 🔴 HIGH (Alta)
- Problema urgente que afecta significativamente el trabajo
- Requiere atención inmediata
- Ejemplo: sistema caído, pérdida de datos

### 🟡 MEDIUM (Media)
- Problema importante pero no crítico
- Se atenderá dentro del flujo normal de trabajo
- Ejemplo: funcionalidad no funciona correctamente

### 🟢 LOW (Baja)
- Consulta general o problema menor
- Se atenderá cuando los recursos estén disponibles
- Ejemplo: pregunta sobre cómo usar una función

---

## Preguntas Frecuentes

### ¿Puedo cambiar la prioridad de mi ticket después de crearlo?
No, solo los agentes y administradores pueden modificar la prioridad. Si cree que la prioridad debe cambiarse, agregue un comentario explicando por qué.

### ¿Cuánto tiempo tarda en responder un agente?
Los tiempos de respuesta varían según la prioridad:
- HIGH: 2-4 horas
- MEDIUM: 1 día hábil
- LOW: 2-3 días hábiles

### ¿Puedo ver tickets de otros usuarios?
No, por razones de privacidad, solo puede ver sus propios tickets. Los agentes ven tickets asignados a ellos, y los administradores tienen acceso completo.

### ¿Qué hago si mi problema sigue sin resolverse?
1. Agregue comentarios adicionales con más detalles
2. Si el ticket está marcado como RESOLVED pero el problema persiste, cree un nuevo ticket
3. Para problemas críticos, contacte directamente a un administrador

### ¿Puedo eliminar un ticket?
No, los tickets no se pueden eliminar para mantener un registro completo del historial de soporte. Si creó un ticket por error, agregue un comentario explicando la situación.

### ¿Cómo recibo notificaciones sobre mis tickets?
Actualmente, debe ingresar al sistema para verificar el estado de sus tickets. Las notificaciones automáticas pueden agregarse en futuras versiones.

---

## Consejos para Crear Buenos Tickets

1. **Sea específico en el título:** "Error 404 en página de reportes" es mejor que "Error en el sistema"

2. **Proporcione detalles en la descripción:**
   - ¿Qué estaba haciendo cuando ocurrió el problema?
   - ¿Qué esperaba que sucediera?
   - ¿Qué sucedió en realidad?
   - ¿Puede reproducir el problema?

3. **Seleccione la prioridad correcta:** Reserve HIGH solo para problemas verdaderamente urgentes

4. **Agregue comentarios con información adicional:** Si recuerda más detalles después de crear el ticket, agréguelos

5. **Responda a los agentes oportunamente:** Cuando un agente solicite más información, responda lo antes posible

---

## Soporte Adicional

Si tiene problemas técnicos con la aplicación o necesita ayuda adicional:
- Contacte al administrador del sistema
- Revise el Manual Técnico para detalles sobre la instalación y configuración

---

**Versión del Manual:** 1.0  
**Fecha:** Diciembre 2024  
**Sistema:** Help Desk v1.0
