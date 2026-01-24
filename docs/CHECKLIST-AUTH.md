# ✅ Checklist de Implementación - Sistema de Autenticación

## 📋 Guía Paso a Paso

Sigue esta lista en orden para implementar correctamente el sistema de autenticación.

---

## 🎯 FASE 1: Configuración de Supabase (15 minutos)

### ✅ 1.1 Ejecutar Script SQL

- [ ] Abrir [Supabase Dashboard](https://supabase.com/dashboard)
- [ ] Ir a **SQL Editor**
- [ ] Crear nueva query
- [ ] Copiar contenido de `docs/sql/auth-rls-setup.sql`
- [ ] Pegar en el editor
- [ ] Hacer clic en **RUN** (Ctrl+Enter)
- [ ] Verificar mensaje "Success" en verde
- [ ] Revisar que no haya errores

**Resultado esperado:**
```
✅ Tables updated successfully
✅ RLS enabled
✅ Policies created
```

---

### ✅ 1.2 Configurar Email Provider

- [ ] Ir a **Authentication** → **Providers**
- [ ] Buscar **Email**
- [ ] Verificar que el toggle esté en verde ✅
- [ ] Si está apagado, hacer clic para activar

---

### ✅ 1.3 Configurar Email Confirmations

**Para Desarrollo (Recomendado):**
- [ ] Ir a **Authentication** → **Settings**
- [ ] Buscar "Enable email confirmations"
- [ ] ❌ DESACTIVAR (para pruebas más rápidas)

**Para Producción:**
- [ ] ✅ ACTIVAR (más seguro)
- [ ] Personalizar template de email (opcional)

---

### ✅ 1.4 Configurar URLs

**Paso 1: Obtener tu URL de GitHub Pages**
- [ ] Ir a tu repositorio en GitHub
- [ ] Settings → Pages
- [ ] Copiar la URL (ejemplo: `https://usuario.github.io/OurCorner`)

**Paso 2: Configurar Site URL**
- [ ] Ir a **Authentication** → **URL Configuration**
- [ ] En **Site URL**, pegar tu URL completa:
  ```
  https://TU-USUARIO.github.io/OurCorner
  ```
- [ ] Guardar

**Paso 3: Configurar Redirect URLs**
- [ ] En **Redirect URLs**, agregar línea por línea:
  ```
  https://TU-USUARIO.github.io/OurCorner
  https://TU-USUARIO.github.io/OurCorner/views/login.html
  https://TU-USUARIO.github.io/OurCorner/index.html
  http://localhost:5500
  http://127.0.0.1:5500
  http://localhost:5500/views/login.html
  ```
- [ ] Guardar cada URL

> ⚠️ **Importante:** Reemplaza `TU-USUARIO` con tu usuario real de GitHub

---

## 🧪 FASE 2: Verificación (10 minutos)

### ✅ 2.1 Verificar RLS

- [ ] Ir a **SQL Editor**
- [ ] Ejecutar esta query:
  ```sql
  SELECT tablename, rowsecurity 
  FROM pg_tables 
  WHERE schemaname = 'public' 
  AND tablename IN ('mensajes', 'reacciones');
  ```
- [ ] Verificar que `rowsecurity` = **true** en ambas tablas

**Resultado esperado:**
```
tablename    | rowsecurity
-------------|------------
mensajes     | true
reacciones   | true
```

---

### ✅ 2.2 Verificar Políticas

- [ ] Ejecutar esta query:
  ```sql
  SELECT tablename, policyname, cmd
  FROM pg_policies
  WHERE tablename IN ('mensajes', 'reacciones')
  ORDER BY tablename, policyname;
  ```
- [ ] Verificar que existan políticas para:
  - SELECT (lectura)
  - INSERT (creación)
  - UPDATE (actualización)
  - DELETE (eliminación)

**Resultado esperado:**
```
Deberías ver al menos 8 políticas (4 para cada tabla)
```

---

### ✅ 2.3 Verificar Columnas

- [ ] Ejecutar esta query:
  ```sql
  SELECT column_name, data_type 
  FROM information_schema.columns 
  WHERE table_name = 'mensajes' 
  AND column_name = 'user_id';
  ```
- [ ] Verificar que existe la columna `user_id` tipo `uuid`

---

## 🚀 FASE 3: Despliegue (5 minutos)

### ✅ 3.1 Commit y Push

- [ ] Abrir terminal en el proyecto
- [ ] Ejecutar:
  ```bash
  git add .
  git commit -m "Implementar sistema de autenticación con Supabase Auth"
  git push origin main
  ```
- [ ] Esperar 2-3 minutos para que GitHub Pages se actualice

---

### ✅ 3.2 Verificar Despliegue

- [ ] Ir a GitHub → Settings → Pages
- [ ] Verificar que el deploy esté completo (punto verde)
- [ ] Hacer clic en "Visit site"

---

## 🧪 FASE 4: Pruebas (15 minutos)

### ✅ 4.1 Probar Registro

- [ ] Abrir la aplicación
- [ ] Hacer clic en "🔐 Iniciar Sesión"
- [ ] Ir a pestaña "Registrarse"
- [ ] Ingresar:
  - Email: tu-email@gmail.com
  - Contraseña: (mínimo 6 caracteres)
  - Confirmar contraseña
- [ ] Hacer clic en "Crear Cuenta"
- [ ] Verificar mensaje de éxito
- [ ] Si email confirmations está activado:
  - [ ] Revisar email
  - [ ] Hacer clic en enlace de confirmación

**Resultado esperado:**
```
✅ Cuenta creada exitosamente
✅ Redirigido a index.html
✅ Botón muestra tu email en verde
```

---

### ✅ 4.2 Probar Login

- [ ] Cerrar sesión (si estás logueado)
- [ ] Hacer clic en "🔐 Iniciar Sesión"
- [ ] Ingresar credenciales
- [ ] Hacer clic en "Iniciar Sesión"
- [ ] Verificar redirección exitosa
- [ ] Verificar que botón muestra tu email

**Resultado esperado:**
```
✅ Login exitoso
✅ Sesión activa
✅ Botón verde con email
```

---

### ✅ 4.3 Probar Creación de Mensaje (Requiere Auth)

**Sin estar logueado:**
- [ ] Cerrar sesión
- [ ] Ir a cualquier página de mensajes
- [ ] Hacer clic en "Agregar Mensaje"
- [ ] Intentar guardar mensaje
- [ ] Verificar que pide login

**Estando logueado:**
- [ ] Iniciar sesión
- [ ] Hacer clic en "Agregar Mensaje"
- [ ] Completar formulario
- [ ] Guardar mensaje
- [ ] Verificar que se guarda correctamente

**Resultado esperado:**
```
❌ Sin auth: Solicita login
✅ Con auth: Mensaje guardado
```

---

### ✅ 4.4 Probar Reacciones (Requiere Auth)

**Sin estar logueado:**
- [ ] Cerrar sesión
- [ ] Ver lista de mensajes
- [ ] Intentar hacer clic en un emoji
- [ ] Verificar que pide login

**Estando logueado:**
- [ ] Iniciar sesión
- [ ] Hacer clic en un emoji
- [ ] Verificar que la reacción se guarda

**Resultado esperado:**
```
❌ Sin auth: Solicita login
✅ Con auth: Reacción guardada
```

---

### ✅ 4.5 Probar Persistencia de Sesión

- [ ] Iniciar sesión
- [ ] Recargar la página (F5)
- [ ] Verificar que sigues logueado
- [ ] Verificar que botón sigue mostrando email
- [ ] Cerrar navegador
- [ ] Abrir navegador nuevamente
- [ ] Ir a la aplicación
- [ ] Verificar que sigues logueado

**Resultado esperado:**
```
✅ Sesión persiste al recargar
✅ Sesión persiste al cerrar/abrir navegador
```

---

### ✅ 4.6 Probar Logout

- [ ] Estando logueado, hacer clic en tu email
- [ ] Hacer clic en "Cerrar Sesión"
- [ ] Confirmar en el modal
- [ ] Verificar que botón cambia a "Iniciar Sesión"
- [ ] Intentar crear mensaje
- [ ] Verificar que pide login

**Resultado esperado:**
```
✅ Sesión cerrada
✅ Botón cambia a morado
✅ Funcionalidades protegidas bloqueadas
```

---

## 🔒 FASE 5: Verificación de Seguridad (10 minutos)

### ✅ 5.1 Verificar RLS en Acción

**Test 1: Intentar crear mensaje de otro usuario**
- [ ] Abrir DevTools (F12)
- [ ] Ir a Console
- [ ] Ejecutar:
  ```javascript
  supabaseClient.from('mensajes').insert([{
    texto: 'Hack',
    user_id: '00000000-0000-0000-0000-000000000000'
  }])
  ```
- [ ] Verificar error de RLS

**Resultado esperado:**
```
❌ Error: new row violates row-level security policy
```

---

### ✅ 5.2 Verificar JWT

- [ ] Estando logueado, abrir DevTools
- [ ] Ir a Application → Local Storage
- [ ] Buscar clave que contenga "supabase"
- [ ] Verificar que existe un token

---

### ✅ 5.3 Verificar que Lectura es Pública

- [ ] Cerrar sesión
- [ ] Ir a página de mensajes
- [ ] Verificar que puedes VER mensajes
- [ ] Verificar que NO puedes crear/reaccionar

**Resultado esperado:**
```
✅ Mensajes visibles
✅ Lectura pública funciona
❌ Escritura bloqueada
```

---

## 📱 FASE 6: Pruebas Responsive (5 minutos)

### ✅ 6.1 Probar en Móvil

- [ ] Abrir DevTools (F12)
- [ ] Hacer clic en icono de dispositivo móvil
- [ ] Seleccionar iPhone o Android
- [ ] Verificar que:
  - [ ] Botón de login se ve bien
  - [ ] Página de login es responsive
  - [ ] Formularios son usables
  - [ ] Dropdown de usuario funciona

---

## 📊 FASE 7: Verificación en Base de Datos (5 minutos)

### ✅ 7.1 Ver Usuarios Registrados

- [ ] Ir a Supabase Dashboard
- [ ] Authentication → Users
- [ ] Verificar que aparece tu usuario
- [ ] Verificar email y fecha de creación

---

### ✅ 7.2 Ver Mensajes con user_id

- [ ] Ir a SQL Editor
- [ ] Ejecutar:
  ```sql
  SELECT id, texto, autor, user_id, created_at 
  FROM mensajes 
  ORDER BY created_at DESC 
  LIMIT 5;
  ```
- [ ] Verificar que los mensajes tienen `user_id` asignado

---

### ✅ 7.3 Ver Reacciones con user_id

- [ ] Ejecutar:
  ```sql
  SELECT r.id, r.emoji, r.user_id, m.texto 
  FROM reacciones r
  JOIN mensajes m ON r.mensaje_id = m.id
  ORDER BY r.created_at DESC
  LIMIT 5;
  ```
- [ ] Verificar que las reacciones tienen `user_id`

---

## 🎉 FASE 8: Finalización

### ✅ 8.1 Documentación

- [ ] Leer [`GUIA-RAPIDA-AUTH.md`](./GUIA-RAPIDA-AUTH.md)
- [ ] Leer [`AUTENTICACION.md`](./AUTENTICACION.md)
- [ ] Guardar credenciales de prueba de forma segura

---

### ✅ 8.2 Limpiar Datos de Prueba (Opcional)

Si creaste mensajes/reacciones de prueba:
- [ ] Ir a SQL Editor
- [ ] Ejecutar:
  ```sql
  -- Ver tus mensajes
  SELECT * FROM mensajes WHERE autor = 'TEST';
  
  -- Eliminar si es necesario
  -- DELETE FROM mensajes WHERE id = 'id-del-mensaje';
  ```

---

### ✅ 8.3 Configurar para Producción

- [ ] Activar Email Confirmations en Supabase
- [ ] Personalizar templates de email
- [ ] Configurar política de contraseñas (min 8 caracteres)
- [ ] Configurar rate limiting si es necesario

---

## 📈 Métricas de Éxito

Al terminar, deberías tener:

- [x] ✅ Script SQL ejecutado sin errores
- [x] ✅ RLS habilitado en ambas tablas
- [x] ✅ 8+ políticas de seguridad activas
- [x] ✅ Email provider configurado
- [x] ✅ URLs configuradas correctamente
- [x] ✅ Usuario de prueba registrado
- [x] ✅ Login/logout funcionando
- [x] ✅ Creación de mensajes protegida
- [x] ✅ Reacciones protegidas
- [x] ✅ Sesión persistente funcionando
- [x] ✅ Responsive en móviles
- [x] ✅ RLS bloqueando intentos maliciosos

---

## 🆘 Si Algo Falla

### Error en SQL:
- Revisa el log de errores en Supabase
- Verifica que las tablas existan
- Ejecuta queries una por una

### Error "Redirect URL not whitelisted":
- Verifica que la URL esté EXACTAMENTE como aparece en el navegador
- No olvides agregar `/views/login.html`
- Verifica que no haya espacios

### No llega email de confirmación:
- Desactiva email confirmations para desarrollo
- Revisa spam
- Verifica configuración SMTP en Supabase

### Sesión no persiste:
- Verifica Site URL en Supabase
- Limpia cookies y vuelve a intentar
- Verifica que no haya errores en consola

---

## 🎯 Próximos Pasos

Después de completar este checklist:

1. [ ] Probar con otros usuarios
2. [ ] Monitorear logs en Supabase
3. [ ] Configurar alertas de seguridad
4. [ ] Implementar límites de rate (opcional)
5. [ ] Personalizar emails (opcional)
6. [ ] Agregar OAuth (Google, GitHub) (futuro)

---

## ✨ ¡Felicitaciones!

Si completaste todos los ítems, tu sistema de autenticación está **100% funcional y seguro**. 🎉🔒

**Tiempo estimado total:** 1 hora  
**Dificultad:** Media  
**Resultado:** Sistema de autenticación profesional ⭐⭐⭐⭐⭐

---

**¿Necesitas ayuda?** Revisa:
- [`GUIA-RAPIDA-AUTH.md`](./GUIA-RAPIDA-AUTH.md) - Guía rápida
- [`AUTENTICACION.md`](./AUTENTICACION.md) - Documentación completa
- [`DIAGRAMA-AUTH.md`](./DIAGRAMA-AUTH.md) - Diagramas visuales
