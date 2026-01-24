# ⚡ Guía Rápida de Configuración - Sistema de Autenticación

## 🎯 Lo que se implementó

✅ Sistema completo de login con email y contraseña  
✅ Protección de mensajes y reacciones  
✅ Sesión persistente automática  
✅ Row Level Security (RLS) en Supabase  

## 🚨 PASOS OBLIGATORIOS (Debes hacerlos TÚ)

### 1️⃣ Ejecutar Script SQL en Supabase (5 minutos)

1. Ve a [Supabase Dashboard](https://supabase.com/dashboard)
2. Selecciona tu proyecto
3. Ve a **SQL Editor**
4. Crea una nueva query
5. Copia y pega TODO el contenido del archivo: `docs/sql/auth-rls-setup.sql`
6. Haz clic en **RUN** (o presiona Ctrl+Enter)
7. Espera a que termine (verás "Success" en verde)

### 2️⃣ Configurar Authentication (3 minutos)

1. En Supabase Dashboard, ve a **Authentication** → **Settings**
2. En **Authentication Providers**:
   - ✅ Asegúrate que **Email** esté habilitado (toggle verde)

3. En **Email Auth**:
   - ⚙️ **Enable email confirmations**: 
     - Para desarrollo: ❌ DESACTIVAR (más fácil de probar)
     - Para producción: ✅ ACTIVAR (más seguro)

### 3️⃣ Configurar URLs (IMPORTANTE - 5 minutos)

En **Authentication** → **URL Configuration**:

**Site URL:**
```
https://TU-USUARIO-GITHUB.github.io/OurCorner
```

**Redirect URLs** (agregar TODAS estas líneas):
```
https://TU-USUARIO-GITHUB.github.io/OurCorner
https://TU-USUARIO-GITHUB.github.io/OurCorner/views/login.html
https://TU-USUARIO-GITHUB.github.io/OurCorner/index.html
http://localhost:5500
http://127.0.0.1:5500
```

> 🔴 **MUY IMPORTANTE:** Reemplaza `TU-USUARIO-GITHUB` con tu nombre de usuario real de GitHub

Ejemplo: Si tu GitHub es `leopal123`, usa:
```
https://leopal123.github.io/OurCorner
```

### 4️⃣ Verificar que funcionó (2 minutos)

1. Ve a **SQL Editor** en Supabase
2. Ejecuta esta query:

```sql
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' 
AND tablename IN ('mensajes', 'reacciones');
```

3. Deberías ver que `rowsecurity` está en **true** ✅

## 🧪 Probar el Sistema

### Opción A: Localmente (con Live Server)

1. Abre el proyecto en VS Code
2. Instala extensión "Live Server" si no la tienes
3. Clic derecho en `index.html` → "Open with Live Server"
4. Haz clic en "🔐 Iniciar Sesión" (esquina superior derecha)
5. Regístrate con tu email real
6. ¡Ya puedes usar el sistema!

### Opción B: En GitHub Pages

1. Sube los cambios a GitHub:
```bash
git add .
git commit -m "Implementar sistema de autenticación"
git push origin main
```

2. Espera 2-3 minutos a que se despliegue
3. Ve a: `https://TU-USUARIO.github.io/OurCorner`
4. Haz clic en "🔐 Iniciar Sesión"
5. Regístrate con tu email

## 🎮 Cómo Usar el Sistema

### Registrar Usuario

1. Clic en **"🔐 Iniciar Sesión"** (esquina superior derecha)
2. Pestaña **"Registrarse"**
3. Ingresa:
   - **Nombre de usuario** (ejemplo: `leopal123` o `rocio456`)
     - 3-20 caracteres
     - Solo letras, números y guión bajo (_)
     - Sin espacios ni símbolos especiales
   - **Email** (ejemplo: `leo@gmail.com`)
     - Solo se usa para recuperar contraseña
     - No es necesario escribirlo al iniciar sesión
   - **Contraseña** (mínimo 6 caracteres)
   - **Confirmar contraseña**
4. Clic en **"Crear Cuenta"**

### Iniciar Sesión (Más Fácil Ahora!)

1. Clic en **"🔐 Iniciar Sesión"**
2. Pestaña **"Iniciar Sesión"**
3. Ingresa:
   - **Usuario**: `leopal123` (¡No necesitas el email!)
   - **Contraseña**: `********`
4. Clic en **"Iniciar Sesión"**
5. ¡Listo! 🚀

> 💡 **Ventaja:** Ya no tienes que escribir tu email completo cada vez. Solo tu username corto.

### Cerrar Sesión

1. Clic en tu username (botón verde, esquina superior derecha)
2. Clic en **"🚪 Cerrar Sesión"**

## 🔥 Qué Cambió

### ANTES (sin autenticación):
- ❌ Cualquiera podía publicar mensajes
- ❌ Cualquiera podía reaccionar sin límites
- ❌ No había control de usuarios

### AHORA (con autenticación):
- ✅ Solo usuarios registrados pueden publicar
- ✅ Solo usuarios registrados pueden reaccionar
- ✅ Cada mensaje/reacción tiene un dueño
- ✅ Solo el dueño puede editar/eliminar
- ✅ Sesión persiste al recargar página
- ✅ **Login con username corto (no email largo)** 🎉

## 🎨 Cambios Visuales

### Botón de Autenticación

**No logueado:**
```
┌─────────────────────┐
│ 🔐 Iniciar Sesión   │ (morado)
└─────────────────────┘
```

**Logueado:**
```
┌────leopal               │ (verde) ← Muestra tu username!
└──────────────────────────┘
      ↓ (al hacer clic)
┌──────────────────────────┐
│ @leopal           ───────┐
│ tu-email@gmail.com       │
├──────────────────────────┤
│ ✍️ Mis Mensajes          │
│ 🚪 Cerrar Sesión         │
└──────────────────────────┘
```

## 🐛 Problemas Comunes

### "Error al guardar mensaje"
**Causa:** No ejecutaste el script SQL  
**Solución:** Ve al paso 1️⃣ arriba

### "Redirect URL not whitelisted"
**Causa:** No configuraste las URLs correctamente  
**Solución:** Ve al paso 3️⃣ arriba y verifica que usaste TU usuario de GitHub

### No llega el email de confirmación
**Causa:** Email confirmations está activado  
**Solución:** 
- Opción 1: Revisa spam
- Opción 2: Desactiva "Email confirmations" en Supabase (paso 2️⃣)

### La sesión no se mantiene
**Causa:** URLs mal configuradas  
**Solución:** Verifica que Site URL coincida con tu dominio real

## 📝 Usuarios de Ejemplo para Pruebas

Puedes crear estos usuarios:

```
Usuario 1:
Username: leopal
Email: leopal123@gmail.com
Password: Rocio2024

Usuario 2:
Username: rocio
Email: rocio456@gmail.com
Password: Leo2024

Usuario 3:
Username: test_user
Email: test@example.com
Password: test123
```

> 💡 **Importante:** Para iniciar sesión solo necesitas el **username** y la contraseña. El email solo se usa para recuperación.

## ✅ Checklist Final

Antes de considerar terminado:

- [ ] Ejecuté el script SQL en Supabase
- [ ] Activé Email provider en Authentication
- [ ] Configuré Site URL con mi usuario de GitHub
- [ ] Agregué todas las Redirect URLs
- [ ] Verifiqué que RLS esté activo (query de verificación)
- [ ] Probé registrar un usuario nuevo
- [ ] Probé iniciar sesión
- [ ] Probé crear un mensaje (requiere login)
- [ ] Probé reaccionar (requiere login)
- [ ] Probé cerrar sesión
- [ ] Verifiqué que la sesión persiste al recargar

## 🎯 Archivo Importante

📄 **Documentación completa:** `docs/AUTENTICACION.md`  
📄 **Script SQL:** `docs/sql/auth-rls-setup.sql`

## 🆘 Si Algo No Funciona

1. Abre la consola del navegador (F12)
2. Ve a la pestaña "Console"
3. Busca mensajes de error en rojo
4. Copia el error y revisa la documentación

### Errores Comunes en Consola:

**"Supabase no inicializado"**
→ Verifica que `supabase.js` tenga las credenciales correctas

**"Auth state changed: SIGNED_OUT"**
→ Esto es normal cuando no hay sesión activa

**"Error verificando reacciones existentes"**
→ Ejecuta el script SQL (paso 1️⃣)

---

## 🎉 ¡Listo!

Si completaste los 4 pasos arriba, tu sistema de autenticación está **100% funcional**.

**Cualquier duda:** Revisa `docs/AUTENTICACION.md` para más detalles.

**¡Disfruta tu aplicación segura!** 🔒✨
