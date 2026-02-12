# ⚡ INICIO RÁPIDO - Valentine

## ✅ Credenciales Configuradas

Ya tienes tus credenciales de Supabase en `.env.local`:
- ✅ URL: `https://lrjbpnzkvueralkqrsfd.supabase.co`
- ✅ Anon Key: Configurada

---

## 🎯 Solo 2 Pasos para Empezar

### PASO 1: Ejecutar Script SQL en Supabase (3 min)

1. **Abre tu proyecto Supabase:**
   👉 https://supabase.com/dashboard/project/lrjbpnzkvueralkqrsfd

2. **Ve al SQL Editor:**
   - En el menú lateral izquierdo: **SQL Editor**
   - Haz clic en **"+ New query"**

3. **Ejecuta el script:**
   - Abre el archivo: `valentine/supabase-setup.sql`
   - Copia TODO el contenido (97 líneas)
   - Pégalo en el editor SQL
   - Haz clic en **"Run"** (o `Ctrl+Enter`)

4. **Verifica que se creó todo:**
   - Deberías ver: ✅ "Success. No rows returned"
   - Ve a **Table Editor** (menú lateral)
   - Verifica que aparecen las nuevas tablas:
     - ✅ `cards`
     - ✅ `card_logs`
     - ✅ `shared_cards`

---

### PASO 2: Probar Localmente (5 min)

Abre PowerShell en la carpeta `valentine/`:

```powershell
# Instalar dependencias (solo la primera vez)
cd C:\laragon\www\OurCorner\valentine
pnpm install

# Iniciar servidor de desarrollo
pnpm dev
```

Abre tu navegador en: **http://localhost:3000**

#### ✨ Prueba la aplicación:
1. Escribe tu nombre y el de tu pareja
2. Haz un dibujo simple en el canvas
3. Haz clic en **"Generar Link"**
4. ✅ Si funciona, verás un enlace compartible

#### 🔍 Verificar en Supabase:
1. Ve a **Table Editor** > `card_logs`
2. Deberías ver tu tarjeta registrada

---

## 🚀 Desplegar en Vercel (Opcional - 10 min)

Cuando estés listo para publicarlo:

### Opción A: Despliegue Rápido

1. **Crear repositorio Git:**
   ```powershell
   cd valentine
   git init
   git add .
   git commit -m "Initial commit"
   ```

2. **Subir a GitHub:**
   - Crea un repo en: https://github.com/new
   - Nombre: `valentine`
   - Copia la URL y ejecuta:
   ```powershell
   git remote add origin https://github.com/TU-USUARIO/valentine.git
   git branch -M main
   git push -u origin main
   ```

3. **Desplegar en Vercel:**
   - Ve a: https://vercel.com/new
   - Importa el repositorio `valentine`
   - En **Environment Variables**, agrega:
     - `NEXT_PUBLIC_SUPABASE_URL` = `https://lrjbpnzkvueralkqrsfd.supabase.co`
     - `NEXT_PUBLIC_SUPABASE_ANON_KEY` = `eyJhbGci...` (tu clave completa)
   - Haz clic en **Deploy**

4. **Actualizar enlace en OurCorner:**
   - Abre: `views/Libreta-flipbook.html`
   - Busca (línea ~480): `href="https://tu-dominio-aqui.vercel.app"`
   - Reemplaza con tu URL de Vercel: `https://valentine-xxxxx.vercel.app`

---

## 📋 Checklist Completo

- [ ] Ejecutar `valentine/supabase-setup.sql` en Supabase
- [ ] Verificar que las 3 tablas se crearon correctamente
- [ ] Ejecutar `pnpm install` en la carpeta valentine
- [ ] Ejecutar `pnpm dev` y abrir http://localhost:3000
- [ ] Crear una tarjeta de prueba
- [ ] Verificar que se guardó en Supabase (Table Editor)
- [ ] (Opcional) Crear repositorio Git
- [ ] (Opcional) Desplegar en Vercel
- [ ] (Opcional) Actualizar URL en Libreta-flipbook.html

---

## 🐛 Solución Rápida de Problemas

### ❌ Error: "Cannot find module 'next'"
**Solución:** Ejecuta `pnpm install` en la carpeta valentine

### ❌ Error: "Supabase not configured"
**Solución:** Verifica que `.env.local` tenga las credenciales correctas

### ❌ No se guardan las tarjetas en Supabase
**Solución:** Asegúrate de haber ejecutado el script SQL completo

### ❌ El puerto 3000 ya está en uso
**Solución:** Mata el proceso anterior o usa otro puerto:
```powershell
pnpm dev -- -p 3001
```

---

## 🎉 ¡Listo!

Una vez que completes estos pasos, tendrás:
- ✅ Valentine funcionando localmente
- ✅ Base de datos Supabase configurada
- ✅ Lista para compartir con tu pareja

**Cuando despliegues en Vercel, actualiza la URL en la libreta de OurCorner** para que el botón de San Valentín funcione correctamente.

---

**¿Necesitas más ayuda?** Consulta:
- `DEPLOY.md` - Guía completa de despliegue
- `INSTRUCCIONES-FINALES.md` - Paso a paso detallado
- `README.md` - Documentación del proyecto
