# 🔐 Guía de Implementación del Sistema de Autenticación

## 📋 Resumen

Se ha implementado un sistema completo de autenticación con **email y contraseña** usando Supabase Auth para la aplicación OurCorner en GitHub Pages.

## ✨ Características Implementadas

- ✅ Login y registro con email/contraseña
- ✅ Gestión automática de sesiones
- ✅ Persistencia de sesión al recargar página
- ✅ Protección de funcionalidades (mensajes y reacciones)
- ✅ Row Level Security (RLS) en Supabase
- ✅ UI responsive con indicador de sesión activa
- ✅ Recuperación de contraseña

## 📁 Archivos Creados/Modificados

### Nuevos Archivos:
1. **`assets/js/services/authService.js`** - Servicio de autenticación
2. **`views/login.html`** - Página de login/registro
3. **`docs/sql/auth-rls-setup.sql`** - Script SQL para configurar RLS

### Archivos Modificados:
1. **`index.html`** - Agregado botón de autenticación y scripts
2. **`views/mensajes.html`** - Agregado authService
3. **`assets/js/controllers/mensajesController.js`** - Protección de guardado de mensajes
4. **`assets/js/models/reaccionesModel.js`** - Protección de reacciones
5. **`assets/css/boton-navidad.css`** - Estilos para botón de autenticación

## 🚀 Pasos de Configuración en Supabase

### 1. Ejecutar Script SQL

Ve a **SQL Editor** en Supabase Dashboard y ejecuta el archivo `docs/sql/auth-rls-setup.sql`:

```bash
# El script realizará automáticamente:
- Agregar columna user_id a tablas mensajes y reacciones
- Habilitar Row Level Security (RLS)
- Crear políticas de seguridad
- Crear índices para mejor rendimiento
```

### 2. Configurar Authentication

#### En Supabase Dashboard > Authentication > Settings:

**Email Auth:**
- ✅ Habilitar "Email" provider
- Configurar "Enable email confirmations" (recomendado: deshabilitado para desarrollo)
- Template de email personalizable (opcional)

**Site URL y Redirect URLs:**
```
Site URL: https://TU-USUARIO.github.io/OurCorner
```

**Redirect URLs (agregar todas):**
```
https://TU-USUARIO.github.io/OurCorner
https://TU-USUARIO.github.io/OurCorner/views/login.html
https://TU-USUARIO.github.io/OurCorner/index.html
```

**Para desarrollo local también agregar:**
```
http://localhost:5500
http://127.0.0.1:5500
http://localhost:5500/views/login.html
```

> 💡 **Importante:** Reemplaza `TU-USUARIO` con tu nombre de usuario de GitHub

### 3. Verificar Configuración

Ejecuta estas queries en SQL Editor para verificar:

```sql
-- Verificar que RLS está habilitado
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' 
AND tablename IN ('mensajes', 'reacciones');

-- Ver políticas creadas
SELECT schemaname, tablename, policyname, permissive, roles, cmd
FROM pg_policies
WHERE tablename IN ('mensajes', 'reacciones')
ORDER BY tablename, policyname;
```

## 🧪 Pruebas del Sistema

### 1. Registro de Usuario

1. Abre la aplicación en tu navegador
2. Haz clic en "🔐 Iniciar Sesión" (esquina superior derecha)
3. Ve a la pestaña "Registrarse"
4. Ingresa:
   - Email: `tu-email@gmail.com`
   - Contraseña: Mínimo 6 caracteres
   - Confirmar contraseña
5. Haz clic en "Crear Cuenta"

### 2. Iniciar Sesión

1. Ve a la página de login
2. Ingresa tus credenciales
3. Haz clic en "Iniciar Sesión"
4. Deberías ser redirigido al inicio

### 3. Probar Funcionalidades Protegidas

**Sin autenticación:**
- ✅ Puedes ver mensajes
- ✅ Puedes leer contenido
- ❌ NO puedes crear mensajes
- ❌ NO puedes reaccionar

**Con autenticación:**
- ✅ Puedes ver mensajes
- ✅ Puedes crear nuevos mensajes
- ✅ Puedes reaccionar
- ✅ Solo puedes editar/eliminar TUS mensajes

### 4. Verificar Sesión Persistente

1. Inicia sesión
2. Recarga la página (F5)
3. La sesión debe mantenerse activa
4. El botón debe mostrar tu email

## 📱 Uso del Sistema

### Para Usuarios

**Registro:**
```
1. Clic en "🔐 Iniciar Sesión"
2. Pestaña "Registrarse"
3. Ingresar email y contraseña
4. Clic en "Crear Cuenta"
```

**Login:**
```
1. Clic en "🔐 Iniciar Sesión"
2. Ingresar credenciales
3. Clic en "Iniciar Sesión"
```

**Logout:**
```
1. Clic en tu email (esquina superior derecha)
2. Clic en "Cerrar Sesión"
```

### Para Desarrolladores

**Verificar autenticación en código:**
```javascript
// Verificar si hay usuario autenticado
if (window.authService && window.authService.isAuthenticated()) {
    const user = window.authService.getCurrentUser();
    console.log('Usuario:', user.email);
}
```

**Proteger una función:**
```javascript
async function miFuncionProtegida() {
    // Verificar autenticación
    if (!window.authService || !window.authService.isAuthenticated()) {
        alert('Debes iniciar sesión');
        window.location.href = '/views/login.html';
        return;
    }
    
    // Tu código aquí...
}
```

**Escuchar cambios de autenticación:**
```javascript
window.authService.onAuthStateChange((event, session) => {
    if (event === 'SIGNED_IN') {
        console.log('Usuario logueado:', session.user.email);
    } else if (event === 'SIGNED_OUT') {
        console.log('Usuario deslogueado');
    }
});
```

## 🔒 Seguridad Implementada

### Row Level Security (RLS)

**Mensajes:**
- Todos pueden leer (público)
- Solo autenticados pueden crear
- Solo el autor puede editar/eliminar

**Reacciones:**
- Todos pueden leer (público)
- Solo autenticados pueden reaccionar
- Solo el usuario puede cambiar/eliminar su reacción

### Políticas de Seguridad

```sql
-- Ejemplo de política implementada
CREATE POLICY "Usuarios autenticados pueden crear mensajes"
ON mensajes FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id);
```

## 🐛 Solución de Problemas

### Error: "Usuario no autenticado"

**Solución:**
1. Verificar que estés logueado
2. Revisar consola del navegador para errores
3. Verificar que authService.js esté cargado

### Error al crear mensaje/reacción

**Solución:**
1. Verificar que ejecutaste el script SQL completo
2. Verificar que RLS esté habilitado
3. Verificar que las políticas existan

### Sesión no persiste

**Solución:**
1. Verificar que Site URL esté configurado correctamente
2. Verificar que no haya errores en consola
3. Limpiar cookies y volver a iniciar sesión

### Email de confirmación no llega

**Solución:**
1. Verificar carpeta de spam
2. En desarrollo, deshabilitar "Email confirmations" en Supabase
3. Verificar configuración de SMTP si usas custom

## 📊 Estructura de Base de Datos

### Tabla: mensajes
```
- id (uuid, primary key)
- categoria (text)
- emoji (text)
- texto (text)
- nota (text)
- autor (text)
- user_id (uuid) ← NUEVO - referencia a auth.users
- created_at (timestamp)
```

### Tabla: reacciones
```
- id (uuid, primary key)
- mensaje_id (uuid)
- emoji (text)
- user_id (uuid) ← NUEVO - reemplaza session_id
- created_at (timestamp)
```

## 🎨 UI/UX

### Botón de Autenticación

**Estado: No autenticado**
```
🔐 Iniciar Sesión (púrpura)
```

**Estado: Autenticado**
```
👤 tu-email@gmail.com (verde)
└─ Dropdown:
   ├─ ✍️ Mis Mensajes
   └─ 🚪 Cerrar Sesión
```

### Página de Login

- Pestañas: Login / Registro
- Validación en tiempo real
- Indicador de fortaleza de contraseña
- Mensajes de error claros
- Responsive para móviles

## 📚 Recursos Adicionales

- [Supabase Auth Docs](https://supabase.com/docs/guides/auth)
- [RLS Documentation](https://supabase.com/docs/guides/auth/row-level-security)
- [Auth Helpers](https://supabase.com/docs/guides/auth/auth-helpers)

## ✅ Checklist de Implementación

- [x] Crear authService.js
- [x] Crear página de login
- [x] Proteger mensajesController
- [x] Proteger reaccionesModel
- [x] Crear script SQL con RLS
- [x] Agregar UI de autenticación en index
- [x] Agregar estilos CSS
- [ ] **Ejecutar script SQL en Supabase** ← TÚ DEBES HACER ESTO
- [ ] **Configurar Auth Settings en Supabase** ← TÚ DEBES HACER ESTO
- [ ] **Actualizar URLs en Supabase** ← TÚ DEBES HACER ESTO
- [ ] Probar registro de usuario
- [ ] Probar login/logout
- [ ] Probar creación de mensajes
- [ ] Probar reacciones
- [ ] Verificar RLS funciona
- [ ] Desplegar a GitHub Pages

## 🎯 Próximos Pasos

1. **Ejecutar el script SQL** en Supabase Dashboard
2. **Configurar Authentication** en Supabase Settings
3. **Actualizar URLs** con tu usuario de GitHub
4. **Probar localmente** antes de desplegar
5. **Desplegar a GitHub Pages**
6. **Crear usuarios de prueba**
7. **Verificar que todo funciona**

## 💡 Notas Importantes

1. **Nunca expongas** la `service_role` key en el frontend
2. Solo usa la `anon` key (ya configurada)
3. RLS protege tus datos automáticamente
4. Las sesiones expiran después de 1 hora por defecto
5. Puedes personalizar templates de email en Supabase

---

## 🆘 Soporte

Si encuentras problemas:
1. Revisa la consola del navegador (F12)
2. Verifica que Supabase esté configurado correctamente
3. Revisa los logs en Supabase Dashboard > Logs
4. Verifica que las políticas RLS estén activas

**¡El sistema está listo para usar!** Solo falta configurar Supabase Dashboard. 🚀
