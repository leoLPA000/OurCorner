# 🚀 Guía de Despliegue - Valentine Project

Esta guía te ayudará a desplegar el proyecto Valentine en Vercel y conectarlo con Supabase.

---

## 📋 Checklist Pre-Despliegue

- [ ] Configurar proyecto en Supabase
- [ ] Ejecutar script SQL de tablas
- [ ] Configurar variables de entorno locales
- [ ] Probar localmente
- [ ] Crear repositorio independiente
- [ ] Desplegar en Vercel
- [ ] Configurar variables de entorno en Vercel
- [ ] Actualizar URLs en metadata

---

## 1️⃣ Configuración de Supabase

### Crear Proyecto en Supabase

1. Ve a [https://supabase.com/dashboard](https://supabase.com/dashboard)
2. Crea un nuevo proyecto (o usa uno existente)
3. Espera a que se complete la instalación (2-3 minutos)

### Ejecutar Script SQL

1. En tu proyecto Supabase, ve a: **SQL Editor** (menú lateral)
2. Haz clic en **New Query**
3. Copia y pega el contenido completo de `supabase-setup.sql`
4. Haz clic en **Run** o presiona `Ctrl+Enter`
5. Verifica que se crearon las 3 tablas:
   - `cards`
   - `card_logs`
   - `shared_cards`

### Obtener Credenciales

1. Ve a **Settings** > **API** (en el menú lateral)
2. Copia los siguientes valores:
   - **Project URL** (ej: `https://abcdefgh.supabase.co`)
   - **anon/public key** (una clave larga que empieza con `eyJ...`)

### Configurar `.env.local`

1. Abre el archivo `.env.local` en la carpeta `valentine/`
2. Reemplaza los valores placeholder:
   ```env
   NEXT_PUBLIC_SUPABASE_URL=https://tu-proyecto.supabase.co
   NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJ...tu-clave-aqui
   ```
3. Guarda el archivo

---

## 2️⃣ Prueba Local

Antes de desplegar, verifica que todo funciona localmente:

```bash
cd valentine
pnpm install
pnpm dev
```

Abre [http://localhost:3000](http://localhost:3000) y verifica:
- ✅ La página carga correctamente
- ✅ Puedes crear una tarjeta
- ✅ Puedes dibujar
- ✅ Se genera el enlace compartible
- ✅ La galería funciona (si está habilitada)

---

## 3️⃣ Crear Repositorio Independiente

### Opción A: Repositorio Nuevo

```bash
cd valentine
git init
git add .
git commit -m "Initial commit - Valentine project"
gh repo create valentine --public --source=. --remote=origin --push
```

### Opción B: Mover a Repositorio Existente

```bash
# Desde la raíz de OurCorner
git subtree split --prefix=valentine -b valentine-branch
cd ..
mkdir valentine-repo
cd valentine-repo
git init
git pull ../OurCorner valentine-branch
git remote add origin https://github.com/TU-USUARIO/valentine.git
git push -u origin main
```

---

## 4️⃣ Despliegue en Vercel

### Método 1: Desde Dashboard de Vercel (Recomendado)

1. Ve a [https://vercel.com/new](https://vercel.com/new)
2. Importa tu repositorio de GitHub
3. Vercel detectará automáticamente que es un proyecto Next.js
4. **NO hagas clic en Deploy todavía**

### Configurar Variables de Entorno en Vercel

1. En la página de configuración del proyecto, ve a **Environment Variables**
2. Agrega las siguientes variables:
   - **Name:** `NEXT_PUBLIC_SUPABASE_URL`
     **Value:** `https://tu-proyecto.supabase.co`
   - **Name:** `NEXT_PUBLIC_SUPABASE_ANON_KEY`
     **Value:** `eyJ...tu-clave-aqui`
3. Asegúrate de marcar todas las opciones (Production, Preview, Development)
4. Haz clic en **Add**

### Deploy

1. Haz clic en **Deploy**
2. Espera 2-3 minutos
3. Tu sitio estará disponible en: `https://tu-proyecto.vercel.app`

---

## 5️⃣ Actualizar URLs en Metadata

Después del despliegue, actualiza las URLs en tu código:

1. Abre `src/app/layout.tsx`
2. Busca todos los lugares donde dice `tu-dominio-aqui.vercel.app`
3. Reemplázalos con tu URL real de Vercel
4. Haz commit y push:
   ```bash
   git add .
   git commit -m "Update production URLs"
   git push
   ```
5. Vercel automáticamente redesplegar con los cambios

---

## 6️⃣ Configuración Adicional (Opcional)

### Dominio Personalizado

1. En Vercel, ve a tu proyecto > **Settings** > **Domains**
2. Agrega tu dominio personalizado
3. Sigue las instrucciones para configurar el DNS
4. Actualiza las URLs en `layout.tsx` con tu dominio personalizado

### Analytics

El proyecto ya incluye **Vercel Analytics** (`@vercel/analytics`). Se habilitará automáticamente en producción.

---

## 🔧 Solución de Problemas

### Error: "Supabase not configured"

- Verifica que las variables de entorno estén configuradas en Vercel
- Asegúrate de que no haya espacios al inicio/final de los valores
- Redesplega el proyecto después de agregar variables

### Error al crear tarjetas

- Verifica que ejecutaste el script SQL completo
- Verifica las políticas RLS en Supabase (Settings > Database > Policies)
- Revisa los logs en Vercel (proyecto > Deployments > [tu deploy] > Functions)

### La galería no muestra tarjetas

- Verifica que `isGalleryEnabled()` retorna `true`
- Revisa la consola del navegador para errores
- Verifica la tabla `cards` en Supabase

---

## 📦 Archivos que NO debes subir a GitHub

El archivo `.gitignore` ya está configurado, pero verifica que:

- ❌ `.env.local` NO esté en el repositorio
- ❌ `node_modules/` NO esté en el repositorio
- ❌ `.next/` NO esté en el repositorio

---

## ✅ Verificación Final

Después del despliegue, verifica:

1. [ ] La URL de producción funciona
2. [ ] Puedes crear y compartir tarjetas
3. [ ] Los enlaces cortos funcionan
4. [ ] La galería muestra tarjetas (si está habilitada)
5. [ ] Las analíticas se registran en Supabase
6. [ ] No hay errores en la consola del navegador
7. [ ] El sitio es responsive (prueba en móvil)

---

## 🎉 ¡Listo!

Tu proyecto Valentine está desplegado y funcionando. Ahora puedes:

- Compartir la URL con quien quieras
- Crear tarjetas personalizadas
- Ver las estadísticas en Supabase

**URL de producción:** `https://[tu-proyecto].vercel.app`

---

## 📚 Recursos Adicionales

- [Documentación de Vercel](https://vercel.com/docs)
- [Documentación de Supabase](https://supabase.com/docs)
- [Documentación de Next.js](https://nextjs.org/docs)

---

## 🆘 Soporte

Si tienes problemas:

1. Revisa los logs en Vercel
2. Revisa los logs en Supabase (Logs > Database)
3. Verifica la configuración de variables de entorno
4. Asegúrate de que el script SQL se ejecutó correctamente
