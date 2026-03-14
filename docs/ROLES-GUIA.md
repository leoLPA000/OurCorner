# 🔐 Guía del Sistema de Roles y Permisos

## 📋 Descripción General

Sistema de 3 niveles de acceso para OurCorner:

| Rol | Icono | Permisos | Descripción |
|-----|-------|----------|-------------|
| **Super Admin** | 👑 | TODO | Gestión completa + administración de usuarios |
| **Admin** | ⚙️ | CRUD | Crear, editar, eliminar contenido (mensajes, fotos, canciones) |
| **Invitado** | 👤 | Solo lectura | Visualizar contenido únicamente |

---

## 🎯 Roles y Permisos Detallados

### 👑 Super Admin
**Email:** `leonardopenaanez@gmail.com`  
**Contraseña:** (la que ya tienes registrada)

**Permisos:**
- ✅ **Todo** lo que puede hacer un Admin
- ✅ **Panel de Administración** exclusivo
- ✅ **Cambiar roles** de otros usuarios
- ✅ **Ver estadísticas** de usuarios
- ✅ **Gestión completa** del sistema

**Acceso especial:**
- Menú desplegable muestra opción "👑 Panel Admin"
- Panel ubicado en `/views/admin-panel.html`

### ⚙️ Admin
**Cómo asignar:** Solo el super admin puede dar este rol

**Permisos:**
- ✅ **Crear** mensajes, fotos, canciones
- ✅ **Editar** contenido existente
- ✅ **Eliminar** contenido
- ✅ **Subir archivos** a Supabase Storage
- ✅ **Ver** todo el contenido
- ❌ **No puede** cambiar roles de usuarios
- ❌ **No puede** acceder al panel de administración

### 👤 Invitado
**Rol por defecto** al registrarse

**Permisos:**
- ✅ **Ver** mensajes, fotos, canciones, galería
- ✅ **Reproducir** música
- ✅ **Navegar** por todas las páginas públicas
- ❌ **No puede** agregar contenido nuevo
- ❌ **No puede** editar contenido
- ❌ **No puede** eliminar contenido

---

## 🚀 Instalación

### 1. Ejecutar SQL de Roles

Ejecuta en **Supabase SQL Editor**:

```sql
-- Ver archivo completo en: docs/sql/roles-setup.sql
```

Este SQL:
- ✅ Crea la tabla `user_roles`
- ✅ Configura políticas RLS
- ✅ Asigna rol `super_admin` a leonardopenaanez@gmail.com
- ✅ Configura trigger para nuevos usuarios
- ✅ Actualiza políticas de tablas existentes

### 2. Verificar Instalación

```sql
-- Ver todos los roles asignados
SELECT u.email, ur.role, ur.created_at
FROM public.user_roles ur
JOIN auth.users u ON u.id = ur.user_id
ORDER BY ur.created_at DESC;

-- Verificar super admin
SELECT email, role 
FROM public.user_roles 
WHERE role = 'super_admin';
```

### 3. Cargar Scripts en HTML

Ya están cargados en `index.html`:

```html
<script src="assets/js/services/rolesService.js"></script>
```

---

## 🎮 Uso del Sistema

### Para Super Admin

#### Acceder al Panel de Administración
1. Inicia sesión con tu cuenta
2. Haz clic en tu nombre de usuario (arriba a la derecha)
3. Selecciona "👑 Panel Admin"

#### Cambiar Rol de un Usuario
1. En el panel, verás una tabla con todos los usuarios
2. Selecciona el nuevo rol del dropdown
3. Haz clic en "💾 Guardar"
4. Se actualiza inmediatamente

#### Estadísticas
El panel muestra:
- Número de super admins
- Número de administradores
- Número de invitados

### Para Desarrolladores

#### Verificar Rol en JavaScript

```javascript
// Verificar si el usuario es super admin
const isSuperAdmin = await window.rolesService.isSuperAdmin();

// Verificar si es admin (o super admin)
const isAdmin = await window.rolesService.isAdmin();

// Verificar si puede modificar contenido
const canModify = await window.rolesService.canModify();

// Obtener rol actual
const role = await window.rolesService.getCurrentUserRole();
// Devuelve: 'super_admin', 'admin' o 'invitado'
```

#### Proteger Acciones

```javascript
// Ejemplo en un botón de agregar
btnAgregar.addEventListener('click', async () => {
    // Verificar autenticación
    if (!window.authService.isAuthenticated()) {
        alert('Debes iniciar sesión');
        return;
    }
    
    // Verificar permisos
    if (!await window.rolesService.canModify()) {
        window.rolesService.showNoPermissionMessage();
        return;
    }
    
    // Continuar con la acción...
});
```

#### Cambiar Rol (Solo Super Admin)

```javascript
// Cambiar rol de un usuario
const result = await window.rolesService.changeUserRole(userId, 'admin');

if (result.success) {
    console.log('Rol actualizado exitosamente');
} else {
    console.error('Error:', result.error);
}
```

---

## 🛡️ Seguridad Implementada

### Nivel de Base de Datos (RLS Policies)

```sql
-- Solo admins pueden insertar mensajes
CREATE POLICY "Solo admins pueden insertar mensajes"
ON public.mensajes FOR INSERT
TO authenticated
WITH CHECK (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    )
);
```

Políticas aplicadas a:
- ✅ `mensajes` (INSERT, UPDATE, DELETE)
- ✅ `canciones` (INSERT, UPDATE, DELETE)
- ✅ `fotos` (INSERT, UPDATE, DELETE)
- ✅ `user_roles` (solo super_admin puede UPDATE/DELETE)

### Nivel de Aplicación (JavaScript)

- ✅ Verificación en botones de agregar contenido
- ✅ Verificación antes de abrir formularios
- ✅ Mensajes de error descriptivos
- ✅ Redirección a login si no está autenticado

---

## 📊 Estructura de la Base de Datos

### Tabla `user_roles`

```sql
CREATE TABLE public.user_roles (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id),
    email TEXT NOT NULL,
    role TEXT NOT NULL DEFAULT 'invitado',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    updated_by UUID REFERENCES auth.users(id),
    UNIQUE(user_id),
    UNIQUE(email),
    CHECK (role IN ('super_admin', 'admin', 'invitado'))
);
```

---

## 🔄 Flujo de Registro de Nuevos Usuario

1. Usuario se registra en `/views/login.html`
2. **Trigger** automático crea registro en `user_roles`
3. Rol asignado por defecto: `invitado`
4. Usuario puede ver contenido pero no modificarlo
5. Super admin puede promoverlo a `admin` desde el panel

---

## 🧪 Testing

### Probar como Invitado
1. Registra una nueva cuenta
2. Verás que NO aparece el botón ➕ de agregar
3. Si intentas acciones protegidas, recibirás mensaje de error

### Probar como Admin
1. Inicia sesión como super admin
2. Ve al panel de administración
3. Cambia el rol de otro usuario a `admin`
4. Cierra sesión
5. Inicia sesión con esa cuenta
6. Ahora verás el botón ➕ y podrás agregar contenido

### Probar como Super Admin
1. Inicia sesión con leonardopenaanez@gmail.com
2. Verás la opción "👑 Panel Admin" en el menú
3. Accede al panel y gestiona usuarios

---

## 🐛 Solución de Problemas

### El rol no se actualiza inmediatamente
**Causa:** El frontend cachea el rol  
**Solución:** Recarga la página después de cambiar un rol

### No puedo acceder al panel de administración
**Causa:** No eres super admin  
**Solución:** Verifica tu rol en la base de datos:
```sql
SELECT email, role FROM user_roles WHERE email = 'tu@email.com';
```

### Los nuevos usuarios no reciben rol automáticamente
**Causa:** El trigger no está configurado  
**Solución:** Ejecuta nuevamente la sección 2 de `roles-setup.sql`

### Un invitado puede agregar contenido
**Causa:** Las políticas RLS no están aplicadas  
**Solución:** Ejecuta la sección 6 de `roles-setup.sql` para actualizar políticas

---

## 📝 Mantenimiento

### Cambiar el Super Admin

Si necesitas cambiar quién es el super admin:

```sql
-- Cambiar rol actual de leonardopenaanez@gmail.com a admin
UPDATE public.user_roles 
SET role = 'admin', updated_at = NOW()
WHERE email = 'leonardopenaanez@gmail.com';

-- Asignar nuevo super admin
UPDATE public.user_roles 
SET role = 'super_admin', updated_at = NOW()
WHERE email = 'nuevo-super-admin@ejemplo.com';
```

### Ver Log de Cambios de Roles

```sql
SELECT 
    ur.email,
    ur.role,
    ur.updated_at,
    u2.email as updated_by_email
FROM public.user_roles ur
LEFT JOIN auth.users u2 ON u2.id = ur.updated_by
WHERE ur.updated_at IS NOT NULL
ORDER BY ur.updated_at DESC;
```

---

## ✅ Checklist de Implementación

- [x] SQL de roles ejecutado
- [x] Super admin asignado a leonardopenaanez@gmail.com
- [x] rolesService.js cargado
- [x] Panel de administración creado
- [x] Menú actualizado con opción de Panel Admin
- [x] Verificación de permisos en musicaService
- [x] Verificación de permisos en galeriaController
- [x] Políticas RLS actualizadas
- [x] Trigger para nuevos usuarios configurado

---

## 📚 Archivos del Sistema

```
docs/sql/
  └── roles-setup.sql                    # SQL completo del sistema de roles

assets/js/services/
  └── rolesService.js                    # Servicio de gestión de roles

views/
  └── admin-panel.html                   # Panel de administración

assets/js/controllers/
  ├── galeriaController.js               # Con verificación de roles
  └── mensajesController.js              # Con verificación de roles

assets/js/services/
  └── musicaService.js                   # Con verificación de roles
```

---

## 🎉 ¡Listo!

El sistema de roles está completamente implementado. Ahora tienes:

- 👑 Control total como super admin
- ⚙️ Flexibilidad para dar permisos a otros
- 👤 Seguridad para usuarios invitados
- 🛡️ Protección a nivel de base de datos y aplicación
- 📊 Panel visual para gestión de usuarios

**¡Comienza a invitar usuarios y asigna roles según necesites!** 🚀
