# 🔐 Sistema de Autenticación - README

## 📦 Implementación Completada

Se ha implementado exitosamente un **sistema de autenticación con email y contraseña** usando Supabase Auth para la aplicación OurCorner.

---

## 🚀 Inicio Rápido

### Para empezar inmediatamente:

1. **Lee:** [`docs/GUIA-RAPIDA-AUTH.md`](./GUIA-RAPIDA-AUTH.md) (10 minutos)
2. **Ejecuta:** Script SQL en Supabase Dashboard
3. **Configura:** URLs en Authentication Settings
4. **Prueba:** Registra un usuario y empieza a usar

---

## 📚 Documentación

| Archivo | Descripción | Para Quién |
|---------|-------------|-----------|
| **[GUIA-RAPIDA-AUTH.md](./GUIA-RAPIDA-AUTH.md)** | Guía rápida en español con pasos esenciales | Principiantes |
| **[AUTENTICACION.md](./AUTENTICACION.md)** | Documentación técnica completa | Desarrolladores |
| **[sql/auth-rls-setup.sql](./sql/auth-rls-setup.sql)** | Script SQL para configurar base de datos | DBA/Admins |

---

## ⚡ Resumen Ultra-Rápido

### ¿Qué hace?

- ✅ Login con email y contraseña
- ✅ Registro de nuevos usuarios
- ✅ Protege mensajes y reacciones (solo usuarios logueados)
- ✅ Sesión persistente
- ✅ Seguridad con Row Level Security (RLS)

### ¿Qué necesitas hacer?

```
1. Ejecutar SQL en Supabase      → 5 min
2. Configurar Authentication     → 3 min  
3. Configurar URLs               → 5 min
4. Probar                        → 5 min
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
   TOTAL                         → 18 min
```

### ¿Dónde está todo?

```
OurCorner/
├── views/
│   └── login.html                    ← Página de login/registro
├── assets/
│   ├── js/
│   │   ├── services/
│   │   │   └── authService.js        ← Lógica de autenticación
│   │   ├── controllers/
│   │   │   └── mensajesController.js ← MODIFICADO (protegido)
│   │   └── models/
│   │       └── reaccionesModel.js    ← MODIFICADO (protegido)
│   └── css/
│       └── boton-navidad.css         ← MODIFICADO (estilos auth)
├── docs/
│   ├── GUIA-RAPIDA-AUTH.md          ← ⭐ EMPIEZA AQUÍ
│   ├── AUTENTICACION.md             ← Documentación completa
│   └── sql/
│       └── auth-rls-setup.sql       ← ⚠️ DEBES EJECUTAR ESTO
└── index.html                        ← MODIFICADO (botón login)
```

---

## 🎯 Archivos Clave

### 1. Script SQL (Obligatorio)
📄 **`docs/sql/auth-rls-setup.sql`**
- Agrega columnas `user_id` a tablas
- Habilita Row Level Security
- Crea políticas de seguridad
- ⚠️ **Debes ejecutarlo en Supabase**

### 2. Servicio de Autenticación
📄 **`assets/js/services/authService.js`**
- Clase `AuthService` con métodos de login/registro
- Gestión de sesiones
- Listeners de cambios de estado
- ✅ Ya está integrado

### 3. Página de Login
📄 **`views/login.html`**
- Formularios de login y registro
- Validación de contraseñas
- Recuperación de contraseña
- ✅ Ya está lista

---

## 🔧 Configuración Requerida

### En Supabase Dashboard:

#### 1. SQL Editor
```sql
-- Ejecuta: docs/sql/auth-rls-setup.sql
-- Esto toma ~30 segundos
```

#### 2. Authentication → Settings

**Email Provider:**
```
☑️ Enable Email
```

**Site URL:**
```
https://TU-USUARIO.github.io/OurCorner
```

**Redirect URLs:**
```
https://TU-USUARIO.github.io/OurCorner
https://TU-USUARIO.github.io/OurCorner/views/login.html
http://localhost:5500
```

---

## 🎮 Uso

### Usuario Final:

1. **Registrarse:**
   - Clic en "🔐 Iniciar Sesión"
   - Tab "Registrarse"
   - Ingresar email y contraseña
   - Clic en "Crear Cuenta"

2. **Login:**
   - Clic en "🔐 Iniciar Sesión"
   - Tab "Iniciar Sesión"
   - Ingresar credenciales
   - Clic en "Iniciar Sesión"

3. **Logout:**
   - Clic en email (esquina superior derecha)
   - Clic en "Cerrar Sesión"

### Desarrollador:

```javascript
// Verificar si está autenticado
if (window.authService.isAuthenticated()) {
    const user = window.authService.getCurrentUser();
    console.log('Usuario:', user.email);
}

// Escuchar cambios
window.authService.onAuthStateChange((event, session) => {
    if (event === 'SIGNED_IN') {
        console.log('Logueado:', session.user.email);
    }
});
```

---

## 🔒 Seguridad

### Row Level Security (RLS)

**Mensajes:**
- 👀 Todos pueden leer
- ✍️ Solo autenticados pueden crear
- ✏️ Solo el autor puede editar
- 🗑️ Solo el autor puede eliminar

**Reacciones:**
- 👀 Todos pueden leer
- ❤️ Solo autenticados pueden reaccionar
- ✏️ Solo el usuario puede cambiar su reacción
- 🗑️ Solo el usuario puede eliminar su reacción

---

## ✅ Testing

### Checklist de Pruebas:

```
□ Registrar usuario nuevo
□ Confirmar email (si está activado)
□ Iniciar sesión
□ Ver que botón cambia a verde con email
□ Intentar crear mensaje (debe funcionar)
□ Intentar reaccionar (debe funcionar)
□ Cerrar sesión
□ Intentar crear mensaje (debe pedir login)
□ Recargar página con sesión activa (debe mantener)
```

### Script de Verificación:

```sql
-- En Supabase SQL Editor:

-- 1. Ver usuarios registrados
SELECT id, email, created_at 
FROM auth.users 
ORDER BY created_at DESC;

-- 2. Ver mensajes con usuario
SELECT id, texto, autor, user_id, created_at 
FROM mensajes 
ORDER BY created_at DESC 
LIMIT 10;

-- 3. Ver reacciones con usuario
SELECT r.id, r.emoji, r.user_id, m.texto 
FROM reacciones r
JOIN mensajes m ON r.mensaje_id = m.id
ORDER BY r.created_at DESC
LIMIT 10;

-- 4. Verificar RLS
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE tablename IN ('mensajes', 'reacciones');
```

---

## 🐛 Troubleshooting

| Problema | Causa | Solución |
|----------|-------|----------|
| "Error al guardar" | SQL no ejecutado | Ejecuta `auth-rls-setup.sql` |
| "Redirect not whitelisted" | URLs mal configuradas | Verifica URLs en Supabase |
| Email no llega | Confirmación activada | Desactiva o revisa spam |
| Sesión no persiste | Site URL incorrecto | Verifica Site URL |

---

## 📊 Cambios en Base de Datos

### Tabla: mensajes
```diff
  - id
  - categoria
  - emoji
  - texto
  - nota
  - autor
+ - user_id          ← NUEVO
  - created_at
```

### Tabla: reacciones
```diff
  - id
  - mensaje_id
  - emoji
- - session_id      ← ELIMINADO
+ - user_id         ← NUEVO
  - created_at
```

---

## 🌟 Características

### ✨ Funcionalidades:
- [x] Registro con email/password
- [x] Login con email/password
- [x] Logout
- [x] Recuperación de contraseña
- [x] Sesión persistente
- [x] Protección de mensajes
- [x] Protección de reacciones
- [x] Row Level Security (RLS)
- [x] UI responsive
- [x] Dropdown de usuario
- [x] Indicador de sesión activa
- [x] Validación de contraseñas
- [x] Mensajes de error claros

### 🎨 UI/UX:
- [x] Botón de login/logout
- [x] Página de login elegante
- [x] Pestañas login/registro
- [x] Indicador de fortaleza de contraseña
- [x] Modo oscuro compatible
- [x] Responsive mobile
- [x] Animaciones suaves
- [x] Feedback visual

---

## 📞 Soporte

### Recursos:

- 📖 **Guía Rápida:** [`GUIA-RAPIDA-AUTH.md`](./GUIA-RAPIDA-AUTH.md)
- 📖 **Documentación:** [`AUTENTICACION.md`](./AUTENTICACION.md)
- 🗄️ **SQL Script:** [`sql/auth-rls-setup.sql`](./sql/auth-rls-setup.sql)
- 🌐 **Supabase Docs:** https://supabase.com/docs/guides/auth

### Si necesitas ayuda:

1. Revisa la consola del navegador (F12)
2. Revisa los logs en Supabase Dashboard
3. Ejecuta queries de verificación del SQL
4. Revisa la documentación completa

---

## 🎯 Próximos Pasos

1. ✅ **Lee** [`GUIA-RAPIDA-AUTH.md`](./GUIA-RAPIDA-AUTH.md)
2. ⚙️ **Ejecuta** el script SQL
3. 🔧 **Configura** Supabase Auth
4. 🧪 **Prueba** el sistema
5. 🚀 **Despliega** a producción

---

## 📜 Licencia

Este código está incluido como parte del proyecto OurCorner.

---

## 🙏 Créditos

- **Framework de Auth:** Supabase Auth
- **Frontend:** Vanilla JavaScript
- **Hosting:** GitHub Pages
- **Base de Datos:** Supabase PostgreSQL

---

**¿Listo para empezar?** 👉 Lee [`GUIA-RAPIDA-AUTH.md`](./GUIA-RAPIDA-AUTH.md)

**¿Necesitas más detalles?** 👉 Lee [`AUTENTICACION.md`](./AUTENTICACION.md)

---

✨ **¡Tu aplicación ahora es segura!** 🔒
