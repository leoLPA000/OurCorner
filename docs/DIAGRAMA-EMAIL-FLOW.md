# 🔄 DIAGRAMA DE FLUJO - Verificación de Email

```
┌─────────────────────────────────────────────────────────────────┐
│                    👤 REGISTRO DE USUARIO                        │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │ Formulario Login │
                    │  - Username      │
                    │  - Email         │
                    │  - Contraseña    │
                    └──────────────────┘
                              │
                              ▼
                    ┌──────────────────┐
                    │ Click "Registrar"│
                    └──────────────────┘
                              │
                              ▼
        ┌──────────────────────────────────────────┐
        │  authService.signUpWithUsername()        │
        │  - Validar username                      │
        │  - Crear usuario en Supabase Auth        │
        │  - Crear perfil en user_profiles         │
        └──────────────────────────────────────────┘
                              │
                              ▼
        ┌──────────────────────────────────────────┐
        │  🤖 SUPABASE (Automático)                │
        │  - Genera token de verificación          │
        │  - Envía email a Gmail del usuario       │
        └──────────────────────────────────────────┘
                              │
                              ▼
        ┌──────────────────────────────────────────┐
        │  📧 Email en Gmail del Usuario           │
        │  Asunto: "Confirma tu cuenta OurCorner"  │
        │  Contenido:                              │
        │    "Haz click aquí para verificar"       │
        │    [Botón: Confirmar mi cuenta]          │
        └──────────────────────────────────────────┘
                              │
                              ▼
        ┌──────────────────────────────────────────┐
        │  💬 Mensaje en Pantalla                  │
        │  "📧 Revisa tu correo!"                  │
        │  "Enviamos mensaje a tu email"           │
        └──────────────────────────────────────────┘
                              │
              ┌───────────────┴────────────────┐
              │                                │
              ▼                                ▼
    ┌─────────────────┐            ┌──────────────────┐
    │ Usuario NO hace │            │ Usuario SÍ hace  │
    │ click en email  │            │ click en email   │
    └─────────────────┘            └──────────────────┘
              │                                │
              ▼                                ▼
    ┌─────────────────┐            ┌──────────────────┐
    │ Intenta Login   │            │ Redirige a:      │
    │                 │            │ email-confirmed  │
    └─────────────────┘            │     .html        │
              │                    └──────────────────┘
              ▼                                │
    ┌─────────────────┐                      ▼
    │ ❌ ERROR        │            ┌──────────────────┐
    │ "Debes verificar│            │ ✅ Página bonita │
    │  tu email antes"│            │ "Email Verificado│
    └─────────────────┘            │     🎉"          │
              │                    └──────────────────┘
              │                                │
              │                                ▼
              │                    ┌──────────────────┐
              │                    │ Cuenta ACTIVADA  │
              │                    │ en Supabase      │
              │                    └──────────────────┘
              │                                │
              │                                ▼
              │                    ┌──────────────────┐
              └───────────────────>│ Puede hacer LOGIN│
                                   │     ✅           │
                                   └──────────────────┘
                                               │
                                               ▼
                                   ┌──────────────────┐
                                   │ Acceso Completo  │
                                   │ a OurCorner 🎉   │
                                   └──────────────────┘
```

---

## 📝 ESTADOS DEL USUARIO

### 🟡 **PENDIENTE** (Recién registrado)
```javascript
{
  email_confirmed_at: null,
  confirmed_at: null
}
```
- ❌ NO puede iniciar sesión
- 📧 Debe verificar email

---

### 🟢 **VERIFICADO** (Email confirmado)
```javascript
{
  email_confirmed_at: "2026-01-24T10:30:00.000Z",
  confirmed_at: "2026-01-24T10:30:00.000Z"
}
```
- ✅ SÍ puede iniciar sesión
- 🎉 Acceso completo

---

## 🔐 COMPONENTES DEL SISTEMA

### **Frontend (Tu código)**
```
views/login.html
  ↓
assets/js/services/authService.js
  ↓
assets/js/config/supabase.js
  ↓
Supabase SDK (CDN)
```

### **Backend (Supabase - Nube)**
```
Supabase Auth
  ↓
Envío de Emails
  ↓
Gmail del Usuario
```

### **Base de Datos**
```
auth.users (tabla de Supabase)
  ├── id
  ├── email
  ├── password (encriptado)
  └── email_confirmed_at ← 🔑 CLAVE

user_profiles (tu tabla)
  ├── user_id (FK → auth.users)
  ├── username
  └── email
```

---

## 🛡️ SEGURIDAD (Row Level Security)

### **Antes del Login:**
```sql
-- Pueden crear perfiles (registro)
CREATE POLICY ON user_profiles FOR INSERT
WITH CHECK (true);

-- Pueden leer usernames (para login)
CREATE POLICY ON user_profiles FOR SELECT
USING (true);
```

### **Después del Login:**
```sql
-- Solo actualizar propio perfil
CREATE POLICY ON user_profiles FOR UPDATE
USING (auth.uid() = user_id);
```

---

## 📦 ARCHIVOS IMPORTANTES

```
OurCorner/
├── views/
│   ├── login.html                    ← Formularios (con 👁️ botones)
│   └── email-confirmed.html          ← Nueva página confirmación
├── assets/js/services/
│   └── authService.js                ← Lógica mejorada
├── docs/
│   ├── QUICK-START-EMAIL.md          ← Inicio rápido
│   ├── EMAIL-VERIFICATION.md         ← Guía completa
│   └── sql/
│       └── fix-user-profiles-rls.sql ← Script SQL
```

---

## 🎯 RESULTADO FINAL

### ✅ **LO QUE TIENES AHORA:**
- 📧 Envío automático de emails de verificación
- 🔐 Solo usuarios verificados pueden entrar
- 👁️ Botones para ver/ocultar contraseñas
- 🎨 Páginas bonitas y profesionales
- 🛡️ Seguridad con Row Level Security
- 🌐 Compatible con GitHub Pages (sin servidor)
- ⚡ Sistema 100% funcional

### ❌ **LO QUE NO NECESITAS:**
- ~~PHP~~
- ~~Servidor backend~~
- ~~Configurar SMTP~~
- ~~Archivo .env~~
- ~~Laragon/Apache~~

---

**Todo funciona en la nube con Supabase** 🚀
