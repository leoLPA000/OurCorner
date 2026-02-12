# 🎯 INSTRUCCIONES FINALES - Integración Valentine + OurCorner

¡Perfecto! He completado toda la configuración. Ahora sigue estos pasos en orden:

---

## 📋 PASO 1: Configurar Supabase (10 minutos)

### 1.1 Crear Proyecto Supabase
1. Ve a https://supabase.com/dashboard
2. Haz clic en **"New Project"**
3. Completa:
   - **Project Name:** `valentine-ourcorner` (o el nombre que prefieras)
   - **Database Password:** Crea una contraseña segura (guárdala)
   - **Region:** Selecciona la más cercana a ti
4. Haz clic en **"Create new project"**
5. ⏳ Espera 2-3 minutos mientras se crea

### 1.2 Ejecutar Script SQL
1. En el panel lateral, ve a **SQL Editor**
2. Haz clic en **"+ New query"**
3. Abre el archivo: `valentine/supabase-setup.sql`
4. Copia TODO el contenido
5. Pégalo en el editor SQL de Supabase
6. Haz clic en **"Run"** (o presiona `Ctrl+Enter`)
7. ✅ Deberías ver: "Success. No rows returned"

### 1.3 Verificar Tablas
1. Ve a **Table Editor** (panel lateral)
2. Deberías ver 3 tablas:
   - ✅ `cards`
   - ✅ `card_logs`
   - ✅ `shared_cards`

### 1.4 Obtener Credenciales
1. Ve a **Settings** > **API** (panel lateral)
2. Busca y copia estos valores:
   - **Project URL:** `https://xxxxx.supabase.co`
   - **anon public key:** `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...` (clave larga)

---

## 📝 PASO 2: Configurar Variables de Entorno (2 minutos)

### 2.1 Editar .env.local
1. Abre el archivo: `valentine/.env.local`
2. Reemplaza los valores:
   ```env
   NEXT_PUBLIC_SUPABASE_URL=https://tu-proyecto-real.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJI... (pega la clave completa)
   ```
3. **Guarda el archivo** (`Ctrl+S`)

### 2.2 ⚠️ Verificar .gitignore
1. Abre: `valentine/.gitignore`
2. Verifica que contenga la línea: `.env.local`
3. ✅ Esto evita que subas tus credenciales a GitHub

---

## 🧪 PASO 3: Probar Localmente (5 minutos)

### 3.1 Instalar Dependencias
Abre una terminal en la carpeta `valentine/`:

```powershell
cd valentine
pnpm install
```

### 3.2 Ejecutar Servidor de Desarrollo
```powershell
pnpm dev
```

### 3.3 Probar la Aplicación
1. Abre http://localhost:3000
2. **Prueba crear una tarjeta:**
   - Escribe un nombre de emisor
   - Escribe un nombre de receptor
   - Haz un dibujo simple
   - Haz clic en "Generar Link"
3. ✅ Si todo funciona, verás un enlace compartible

### 3.4 Verificar Base de Datos
1. Vuelve a Supabase > **Table Editor**
2. Abre la tabla `card_logs`
3. Deberías ver tu tarjeta registrada con los nombres que usaste

---

## 🚀 PASO 4: Desplegar en Vercel (10 minutos)

### 4.1 Preparar Repositorio Git

#### Opción A: Crear Repositorio Nuevo (Recomendado)
```powershell
cd valentine
git init
git add .
git commit -m "Initial commit: Valentine project"
```

Luego crea el repositorio en GitHub:
- Ve a https://github.com/new
- Nombre: `valentine`
- Visibilidad: Pública o Privada
- NO inicialices con README
- Copia la URL del repositorio

Conecta y sube:
```powershell
git remote add origin https://github.com/TU-USUARIO/valentine.git
git branch -M main
git push -u origin main
```

#### Opción B: Subir como Subcarpeta (Más simple)
Si quieres mantenerlo dentro de OurCorner temporalmente:
```powershell
# Desde la raíz de OurCorner
git add valentine/
git commit -m "Add valentine project"
git push
```

### 4.2 Desplegar en Vercel

1. Ve a https://vercel.com/new
2. **Importa tu repositorio Git:**
   - Si es repo separado: selecciona `valentine`
   - Si está en OurCorner: selecciona `OurCorner` y luego configura el directorio raíz como `valentine`
3. **Framework Preset:** Vercel detectará automáticamente **Next.js** ✅
4. **Root Directory:** 
   - Si es repo separado: déjalo como `./`
   - Si está en OurCorner: cambia a `valentine/`

### 4.3 Configurar Variables de Entorno en Vercel

**⚠️ IMPORTANTE: NO hagas clic en Deploy todavía**

1. En la sección **Environment Variables**, agrega:

   **Variable 1:**
   - Name: `NEXT_PUBLIC_SUPABASE_URL`
   - Value: `https://tu-proyecto-real.supabase.co` (el mismo de .env.local)
   - Environments: ✅ Production, ✅ Preview, ✅ Development

   **Variable 2:**
   - Name: `NEXT_PUBLIC_SUPABASE_ANON_KEY`
   - Value: `eyJhbGci...` (la clave completa de .env.local)
   - Environments: ✅ Production, ✅ Preview, ✅ Development

2. Haz clic en **Add** para cada una

### 4.4 Deploy
1. Ahora sí, haz clic en **Deploy**
2. ⏳ Espera 2-3 minutos
3. 🎉 ¡Listo! Vercel te mostrará la URL: `https://valentine-xxxxx.vercel.app`

---

## 🔗 PASO 5: Actualizar URLs en OurCorner (5 minutos)

### 5.1 Actualizar Libreta
1. Abre: `views/Libreta-flipbook.html`
2. Busca la línea (aprox. línea 480):
   ```html
   <a href="https://tu-dominio-aqui.vercel.app" target="_blank"
   ```
3. Reemplaza `https://tu-dominio-aqui.vercel.app` con tu URL real de Vercel
4. Ejemplo:
   ```html
   <a href="https://valentine-abc123.vercel.app" target="_blank"
   ```
5. **Guarda el archivo**

### 5.2 Actualizar Metadata del Proyecto Valentine (Opcional pero Recomendado)
1. Abre: `valentine/src/app/layout.tsx`
2. Busca y reemplaza TODOS los `https://tu-dominio-aqui.vercel.app` con tu URL real
3. Ejemplos de líneas a cambiar:
   - Línea ~32: `metadataBase`
   - Línea ~84: `url` en openGraph
   - Línea ~112: `canonical`
   - Línea ~118: `url` en jsonLd
   - Línea ~125: `target` en jsonLd
4. **Guarda el archivo**

### 5.3 Redesplegar Valentine (si actualizaste metadata)
```powershell
cd valentine
git add .
git commit -m "Update production URLs"
git push
```
Vercel automáticamente redesplegar (1-2 minutos).

---

## ✅ PASO 6: Verificación Final

### 6.1 Probar Valentine en Producción
1. Abre tu URL de Vercel: `https://valentine-xxxxx.vercel.app`
2. Crea una tarjeta completa
3. Copia el enlace generado
4. Abre el enlace en una ventana de incógnito
5. ✅ Deberías ver la tarjeta funcionando perfectamente

### 6.2 Verificar Datos en Supabase
1. Ve a Supabase > **Table Editor** > `cards`
2. Deberías ver las tarjetas guardadas en la galería
3. Ve a `card_logs` para ver estadísticas

### 6.3 Probar Libreta en OurCorner
1. Abre: `views/Libreta-flipbook.html` en tu navegador
2. Navega hasta la **Página 4: San Valentín**
3. Haz clic en **"💖 Crear Tarjeta de San Valentín"**
4. ✅ Debería abrirse Valentine en una nueva pestaña

---

## 🎨 PERSONALIZACIÓN ADICIONAL (Opcional)

### Cambiar Colores o Estilos
- Estilos globales: `valentine/src/app/globals.css`
- Componentes: `valentine/src/app/components/`

### Modificar Frases Románticas
- Archivo: `valentine/src/app/utils/encode.ts`
- Busca el array `ROMANTIC_QUOTES`

### Agregar Templates de Dibujo
- Archivo: `valentine/src/app/utils/templates.ts`
- Sigue el patrón de los templates existentes

---

## 🔧 SOLUCIÓN DE PROBLEMAS

### ❌ Error: "Supabase not configured"
**Causa:** Variables de entorno no configuradas correctamente.
**Solución:**
1. Verifica que `.env.local` tenga los valores correctos
2. En Vercel: Settings > Environment Variables - verifica los valores
3. Redesplegar si cambiaste algo

### ❌ No se guardan las tarjetas
**Causa:** Políticas RLS mal configuradas o script SQL incompleto.
**Solución:**
1. Ve a Supabase > Authentication > Policies
2. Verifica que existan políticas para `cards`, `card_logs` y `shared_cards`
3. Si no existen, vuelve a ejecutar `supabase-setup.sql`

### ❌ El enlace en la libreta no funciona
**Causa:** URL incorrecta o navegador bloqueando pop-ups.
**Solución:**
1. Verifica que la URL en `Libreta-flipbook.html` sea correcta
2. Abre la consola del navegador (F12) y busca errores
3. Asegúrate de que el atributo `target="_blank"` esté presente

---

## 📊 MONITOREO Y MANTENIMIENTO

### Ver Estadísticas
- **Supabase:** Table Editor > `card_logs` - ver cuántas tarjetas se crean
- **Vercel:** Analytics (incluido gratis)

### Backup de Base de Datos
1. Supabase > Database > Backups
2. Se crean backups automáticos diariamente

### Actualizar el Proyecto
```powershell
cd valentine
# Hacer cambios...
git add .
git commit -m "Descripción del cambio"
git push
# Vercel redesplegar automáticamente
```

---

## 🎉 ¡FELICIDADES!

Has completado exitosamente:
- ✅ Configuración de Supabase con tablas y políticas
- ✅ Limpieza de datos del propietario anterior
- ✅ Configuración de variables de entorno
- ✅ Despliegue en Vercel
- ✅ Integración con OurCorner

**Tu proyecto Valentine está listo para usar y compartir** 💖

---

## 📞 CONTACTO Y RECURSOS

- **Documentación Valentine:** `valentine/README.md`
- **Guía de Despliegue:** `valentine/DEPLOY.md`
- **Script SQL:** `valentine/supabase-setup.sql`

**¿Necesitas ayuda?**
- Revisa los logs en Vercel
- Consulta la documentación de Supabase
- Verifica la consola del navegador (F12)

---

**✨ Disfruta compartiendo amor con Valentine ✨**
