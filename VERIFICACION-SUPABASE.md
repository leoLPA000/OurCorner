# ✅ Verificación de Sincronización con Supabase

## 🔍 Checklist de Verificación

### 1. SDK de Supabase Cargado ✅
**Archivos actualizados:**
- ✅ `index.html` - SDK v2.39.0
- ✅ `mensajes.html` - SDK v2.39.0  
- ✅ `mis-mensajes.html` - SDK v2.39.0

**URL del SDK:**
```html
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2.39.0/dist/umd/supabase.min.js"></script>
```

### 2. Configuración de Supabase ✅
**Archivo:** `js/supabaseConfig.js`
- ✅ URL del proyecto configurada
- ✅ Anon key configurada
- ✅ Cliente global expuesto (`window.supabaseClient`)

### 3. Base de Datos - Tablas Necesarias

Ejecuta este SQL en Supabase para verificar las tablas:

```sql
-- Verificar que existen las tablas
SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'public' 
  AND table_name IN ('canciones', 'fotos', 'mensajes');

-- Verificar estructura de tabla canciones
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'canciones';

-- Ver políticas RLS de canciones
SELECT * FROM pg_policies WHERE tablename = 'canciones';
```

### 4. Storage - Bucket Configurado

**Verificación en Supabase Console:**
1. Ve a Storage → Buckets
2. Confirma que existe el bucket `archivos`
3. Verifica que sea público
4. Revisa las políticas:
   - ✅ SELECT (anon) - `true`
   - ✅ INSERT (anon) - `true`
   - ✅ UPDATE (anon) - `true`
   - ✅ DELETE (anon) - `true`

### 5. Funcionalidad del Reproductor 🎵

**Verificaciones:**
- ✅ Reproductor carga con 5 canciones predeterminadas
- ✅ Botón ▶️ reproduce música
- ✅ Botones ⏮️ ⏭️ cambian de canción
- ✅ Botón 📋 muestra playlist
- ✅ Botón ➕ abre formulario para agregar canciones
- ✅ Al agregar canción se sube a Supabase Storage
- ✅ Metadata se guarda en tabla `canciones`

**Test en Consola (F12):**
```javascript
// Verificar cliente Supabase
console.log('Cliente Supabase:', !!window.supabaseClient);

// Listar canciones en DB
const { data, error } = await window.supabaseClient
  .from('canciones')
  .select('*');
console.log('Canciones en DB:', data);

// Verificar bucket
const { data: buckets } = await window.supabaseClient
  .storage
  .listBuckets();
console.log('Buckets:', buckets);
```

## 🚀 Pasos para Completar la Sincronización

### Paso 1: Ejecutar SQL de Setup
1. Abre Supabase Dashboard: https://supabase.com/dashboard
2. Ve a tu proyecto
3. Click en "SQL Editor"
4. Copia y pega el contenido de `supabase-setup.sql`
5. Click en "Run" o presiona Ctrl+Enter

### Paso 2: Configurar Storage Policies
1. Ve a Storage → Buckets
2. Si no existe, crea bucket `archivos` (público)
3. Click en `archivos` → Configuration → Policies
4. Crea estas políticas:

**Policy 1: SELECT (anon)**
```sql
((bucket_id = 'archivos'::text))
```

**Policy 2: INSERT (anon)**
```sql
((bucket_id = 'archivos'::text))
```

**Policy 3: UPDATE (anon)**
```sql
((bucket_id = 'archivos'::text))
```

**Policy 4: DELETE (anon)**
```sql
((bucket_id = 'archivos'::text))
```

### Paso 3: Insertar Canciones de Prueba (Opcional)
Ejecuta el SQL del archivo `insert-canciones.sql`:

```sql
-- Insertar canciones de ejemplo
INSERT INTO canciones (titulo, artista, url, tipo) VALUES
('Perfect', 'Ed Sheeran', 'URL_DE_TU_CANCION', 'predeterminada'),
('A Thousand Years', 'Christina Perri', 'URL_DE_TU_CANCION', 'predeterminada');
```

⚠️ **Nota:** Necesitas URLs reales de archivos MP3. Puedes:
- Subirlos manualmente a Storage y obtener la URL pública
- Usar URLs de servicios de música libre

### Paso 4: Verificar en el Navegador
1. Abre tu sitio: `https://leolpa000.github.io/NuestroMes/`
2. Abre la consola (F12)
3. Busca el mensaje: `"Supabase client initialized: true"`
4. Busca: `"🎵 Creando controles del reproductor..."`
5. Busca: `"✅ Eventos del reproductor vinculados correctamente"`

### Paso 5: Probar Funcionalidad
1. **Click en ▶️** → Debe reproducir una de las 5 canciones predeterminadas
2. **Click en 📋** → Debe mostrar la lista de canciones
3. **Click en ➕** → Debe abrir formulario para subir canción
4. **Sube una canción de prueba:**
   - Selecciona un MP3
   - Llena título y artista
   - Click en "Guardar Canción"
   - Verifica en Supabase Storage que se subió
   - Verifica en tabla `canciones` que se guardó la metadata

## ❌ Solución de Problemas Comunes

### Error: "supabaseClient is not defined"
**Causa:** SDK no cargó o orden incorrecto
**Solución:**
```html
<!-- Orden correcto en HTML -->
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2.39.0/dist/umd/supabase.min.js"></script>
<script src="js/supabaseConfig.js"></script>
<script src="js/musica.js"></script>
```

### Error: "new row violates row-level security policy"
**Causa:** Políticas RLS no configuradas
**Solución:** Ejecuta `supabase-setup.sql` completo

### Error al subir archivos: "PolicyNotFound"
**Causa:** Políticas de Storage no configuradas
**Solución:** Configura políticas en Storage → Buckets → archivos → Policies

### Reproductor no se ve o no responde
**Causa:** CSS no cargado o eventos no vinculados
**Solución:** 
1. Refresca con Ctrl+F5
2. Verifica consola (F12) para errores
3. Verifica que `estilos.css` se cargue correctamente

### Canciones no se escuchan
**Causa:** URLs inválidas o archivos no existen
**Solución:**
1. Verifica que las URLs en la tabla `canciones` sean accesibles
2. Abre una URL de canción en nueva pestaña para probar
3. Verifica que los archivos estén en Storage

## 📊 Estado Actual

### ✅ Completado:
- [x] SDK de Supabase actualizado a v2.39.0
- [x] Configuración de cliente (`supabaseConfig.js`)
- [x] Reproductor con 5 canciones predeterminadas
- [x] Funcionalidad CRUD para canciones
- [x] Fallback a localStorage
- [x] Scripts SQL para setup

### ⏳ Pendiente de Verificar:
- [ ] Ejecutar `supabase-setup.sql` en Supabase
- [ ] Configurar políticas de Storage
- [ ] Probar upload de archivos
- [ ] Verificar que canciones se guarden en DB
- [ ] Confirmar reproducción desde Supabase

## 🎯 Próximos Pasos

1. **Ejecuta el SQL de setup** en Supabase Dashboard
2. **Configura las políticas de Storage**
3. **Prueba subir una canción** desde el reproductor
4. **Verifica en Supabase** que se guardó correctamente
5. **Confirma que se reproduce** la canción subida

---

**Última actualización:** 6 de noviembre de 2025
**Estado:** ✅ Código actualizado - Pendiente configuración en Supabase
