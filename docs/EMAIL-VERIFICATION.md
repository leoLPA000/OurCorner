# 📧 Guía Completa: Sistema de Verificación de Email con Supabase

## 🎯 ¿Cómo funciona?

### ✅ **NO necesitas PHP ni servidor backend**
Supabase maneja TODO automáticamente desde la nube:
- ✉️ Envío de emails de verificación
- 🔐 Confirmación de cuentas
- 🌐 Compatible con GitHub Pages
- 🎨 Plantillas de email profesionales

---

## 📋 Pasos de Configuración

### 1️⃣ **Configurar Email en Supabase Dashboard**

1. Ve a tu proyecto en [Supabase Dashboard](https://app.supabase.com)
2. Navega a **Authentication** > **Email Templates**
3. Encontrarás estas plantillas:
   - **Confirm signup** - Email de verificación
   - **Magic Link** - Login sin contraseña
   - **Change Email Address** - Cambio de email
   - **Reset Password** - Recuperar contraseña

4. **Personaliza el email de confirmación:**
   ```html
   <h2>Confirma tu cuenta de OurCorner</h2>
   <p>Hola,</p>
   <p>Gracias por registrarte en OurCorner. Haz clic en el enlace para verificar tu email:</p>
   <p><a href="{{ .ConfirmationURL }}">Confirmar mi cuenta</a></p>
   ```

### 2️⃣ **Configurar URL de Redirección**

En **Authentication** > **URL Configuration**:

- **Site URL**: `https://tu-usuario.github.io/OurCorner/`
- **Redirect URLs**: Agregar:
  ```
  https://tu-usuario.github.io/OurCorner/views/email-confirmed.html
  http://localhost:*/views/email-confirmed.html
  ```

### 3️⃣ **Habilitar Email Confirmation**

En **Authentication** > **Providers** > **Email**:

- ✅ **Enable email confirmations** - ACTIVAR
- ✅ **Secure email change** - ACTIVAR (recomendado)

### 4️⃣ **Ejecutar Script SQL para Políticas RLS**

En **SQL Editor** > **New query**, ejecuta:

```sql
-- Archivo: docs/sql/fix-user-profiles-rls.sql
```

Copia y pega el contenido del archivo y ejecuta.

---

## 🔄 Flujo del Usuario

### **Registro:**
1. Usuario llena el formulario con username, email y contraseña
2. Sistema crea cuenta en Supabase ⚙️
3. **Supabase envía email automáticamente** 📧
4. Usuario ve mensaje: *"Revisa tu correo para verificar"*
5. Usuario NO puede iniciar sesión hasta verificar

### **Verificación:**
1. Usuario revisa su bandeja de Gmail
2. Hace clic en el enlace del email
3. Redirige a `/views/email-confirmed.html`
4. Cuenta activada ✅

### **Login:**
1. Usuario ingresa username y contraseña
2. Si NO verificó email → Error amigable
3. Si SÍ verificó → Acceso completo

---

## 🧪 Probar Localmente

### **Opción 1: Con Live Server (Recomendado)**
```bash
# Instalar extensión Live Server en VS Code
# Clic derecho en index.html > Open with Live Server
```

### **Opción 2: Con Python**
```bash
cd c:\laragon\www\OurCorner
python -m http.server 8000
# Abrir: http://localhost:8000
```

### **Opción 3: Con Node.js**
```bash
npx serve .
```

---

## 🚀 Desplegar en GitHub Pages

1. **Subir a GitHub:**
   ```bash
   git add .
   git commit -m "Sistema de verificación de email implementado"
   git push origin main
   ```

2. **Activar GitHub Pages:**
   - Settings > Pages
   - Source: Deploy from branch
   - Branch: main / (root)
   - Save

3. **Actualizar URLs en Supabase:**
   - Cambia `localhost` por tu URL de GitHub Pages
   - Ejemplo: `https://tu-usuario.github.io/OurCorner/`

---

## 🐛 Solución de Errores Comunes

### **Error 406 (Not Acceptable)**
**Causa:** Políticas RLS muy restrictivas

**Solución:**
```bash
# Ejecutar: docs/sql/fix-user-profiles-rls.sql
```

### **"Email not confirmed"**
**Causa:** Usuario intenta login sin verificar email

**Solución:** Ya está manejado - muestra mensaje amigable

### **No llega el email**
**Causas posibles:**
1. Email en spam/promociones
2. Límite de emails de Supabase gratuito (4/hora en desarrollo)
3. Email mal escrito

**Solución:**
- Revisar carpeta Spam
- Esperar 15 minutos y reintentar
- Usar un email válido

### **Error al crear perfil**
**Causa:** Tabla `user_profiles` no existe o faltan permisos

**Solución:**
```sql
-- Ejecutar en SQL Editor de Supabase
-- Ver: docs/sql/auth-rls-setup.sql
```

---

## 📊 Verificar que Todo Funciona

### **Checklist de Testing:**

- [ ] 1. Registrar usuario nuevo
- [ ] 2. Ver mensaje "Revisa tu email"
- [ ] 3. Recibir email en Gmail
- [ ] 4. Click en enlace de confirmación
- [ ] 5. Ver página "Email Verificado"
- [ ] 6. Iniciar sesión exitosamente
- [ ] 7. Intentar login sin verificar → Ver error
- [ ] 8. Probar recuperar contraseña

---

## 🎨 Archivos Modificados

### **Nuevos:**
- ✅ `/views/email-confirmed.html` - Página de confirmación
- ✅ `/docs/sql/fix-user-profiles-rls.sql` - Script de políticas

### **Actualizados:**
- ✅ `/assets/js/services/authService.js` - Manejo de verificación
- ✅ `/views/login.html` - Botones de mostrar/ocultar contraseña

---

## 💡 Preguntas Frecuentes

### **¿Necesito servidor para enviar emails?**
❌ NO. Supabase lo hace por ti desde la nube.

### **¿Funciona en GitHub Pages?**
✅ SÍ. Es 100% frontend (JavaScript + Supabase).

### **¿Puedo personalizar los emails?**
✅ SÍ. Edita las plantillas en Supabase Dashboard.

### **¿Cuántos emails puedo enviar?**
- **Plan gratuito:** Limitado (4/hora en desarrollo)
- **Plan Pro:** Ilimitado con tu propio SMTP

### **¿Los emails son seguros?**
✅ SÍ. Supabase usa tokens seguros con expiración.

---

## 📞 Soporte

Si tienes problemas:
1. Revisa los logs en la consola del navegador (F12)
2. Verifica las políticas RLS en Supabase
3. Comprueba que las URLs estén configuradas
4. Revisa la carpeta Spam

---

## 🎉 ¡Listo!

Ahora tienes un sistema profesional de autenticación con verificación de email, sin necesidad de servidor backend.

**Pruébalo:** [views/login.html](../views/login.html)
