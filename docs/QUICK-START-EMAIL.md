# ⚡ Inicio Rápido - Activar Verificación de Email

## 🎯 Solo 3 pasos en Supabase Dashboard

### 1️⃣ **Ejecutar SQL** (2 minutos)

```bash
Ve a: Supabase Dashboard > SQL Editor > New Query
```

Copia y ejecuta este código:

```sql
-- Eliminar políticas anteriores
DROP POLICY IF EXISTS "Perfiles públicos para lectura" ON user_profiles;
DROP POLICY IF EXISTS "Sistema puede crear perfiles" ON user_profiles;
DROP POLICY IF EXISTS "Usuarios pueden actualizar su perfil" ON user_profiles;

-- Crear políticas correctas
CREATE POLICY "Permitir lectura pública de perfiles"
ON user_profiles FOR SELECT USING (true);

CREATE POLICY "Permitir creación de perfiles"
ON user_profiles FOR INSERT WITH CHECK (true);

CREATE POLICY "Usuario puede actualizar su propio perfil"
ON user_profiles FOR UPDATE USING (auth.uid() = user_id);

-- Habilitar RLS
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

-- Permisos
GRANT SELECT ON user_profiles TO anon;
GRANT INSERT ON user_profiles TO anon;
GRANT SELECT, UPDATE ON user_profiles TO authenticated;
```

**✅ Click en RUN**

---

### 2️⃣ **Configurar Email** (1 minuto)

```bash
Ve a: Authentication > Providers > Email
```

**Activar:**
- ✅ Enable email confirmations
- ✅ Secure email change

**Click en SAVE**

---

### 3️⃣ **Agregar URLs** (1 minuto)

```bash
Ve a: Authentication > URL Configuration
```

**Agregar en "Redirect URLs":**
```
http://localhost:8000/views/email-confirmed.html
http://127.0.0.1:8000/views/email-confirmed.html
https://tu-usuario.github.io/OurCorner/views/email-confirmed.html
```

**Click en SAVE**

---

## 🧪 Probar Ahora

1. **Iniciar servidor local:**
   ```bash
   cd c:\laragon\www\OurCorner
   python -m http.server 8000
   ```

2. **Abrir navegador:**
   ```
   http://localhost:8000/views/login.html
   ```

3. **Registrar usuario:**
   - Username: `testuser`
   - Email: `tu-email@gmail.com`
   - Contraseña: `123456`

4. **Revisar Gmail** → Click en enlace

5. **Iniciar sesión** ✅

---

## ❌ Si algo falla

### **Error 406 al registrar**
→ Ejecutaste el SQL del paso 1?

### **No llega el email**
→ Revisa carpeta SPAM
→ Espera 2 minutos

### **Error "Email not confirmed"**
→ Perfecto! Significa que funciona
→ Debes verificar el email primero

---

## ✅ Funciona!

Ahora tu sistema:
- ✉️ Envía emails automáticamente
- 🔐 Solo usuarios verificados pueden entrar
- 👁️ Botones para ver/ocultar contraseñas
- 🎨 Página bonita de confirmación

---

**Ver guía completa:** [EMAIL-VERIFICATION.md](EMAIL-VERIFICATION.md)
