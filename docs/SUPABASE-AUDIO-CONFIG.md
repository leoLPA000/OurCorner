# 🎵 Configuración de Supabase para Cualquier Formato de Audio

## ✅ Tu configuración actual

Las políticas RLS en `storage-policies.sql` **ya permiten cualquier tipo de archivo**:

```sql
-- Esta política NO tiene restricciones de tipo MIME
CREATE POLICY "Usuarios autenticados pueden subir archivos"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'archivos');
```

✅ **No necesitas modificar las políticas SQL**

---

## 🔧 Verificar configuración del Bucket en Supabase UI

### 1. Ve a la consola de Supabase

1. Abre [https://supabase.com/dashboard](https://supabase.com/dashboard)
2. Selecciona tu proyecto: `lrjbpnzkvueralkqrsfd`
3. Ve a **Storage** en el menú lateral

### 2. Configuración del bucket "archivos"

Haz clic en el bucket **"archivos"** y luego en **⚙️ Settings** o **Configuration**:

#### 📋 Configuraciones recomendadas:

| Configuración | Valor Recomendado | Descripción |
|--------------|-------------------|-------------|
| **Public bucket** | ✅ ON | Archivos accesibles públicamente |
| **File size limit** | **50 MB** | Máximo por archivo |
| **Allowed MIME types** | `*/*` o dejar vacío | **Permite todos los tipos** |

### 3. IMPORTANTE: Allowed MIME types

Si ves una opción llamada **"Allowed MIME types"** o **"Restrict file types"**:

#### Opción A: Permitir TODO (recomendado)
```
*/*
```

#### Opción B: Solo audio (más restrictivo)
```
audio/*
```

#### Opción C: Formatos específicos
```
audio/mpeg
audio/mp3
audio/mp4
audio/x-m4a
audio/m4a
audio/wav
audio/ogg
audio/flac
audio/aac
audio/opus
audio/webm
audio/x-ms-wma
audio/aiff
```

#### ⚠️ Si está vacío
- Algunos buckets **vacíos = permiten todo** ✅
- Otros buckets **vacíos = restringen todo** ❌
- Prueba subir un archivo para verificar

---

## 🧪 Cómo verificar la configuración

### Método 1: Prueba desde la UI de Supabase

1. Ve a **Storage** > **archivos**
2. Haz clic en **Upload file**
3. Intenta subir un archivo M4A
4. Si funciona → ✅ Configuración correcta

### Método 2: Verifica con SQL

```sql
-- Ver configuración del bucket
SELECT * FROM storage.buckets WHERE name = 'archivos';
```

Busca columnas como:
- `allowed_mime_types` → Debería ser `null` o contener `audio/*`
- `file_size_limit` → Debería ser suficiente (50000000 = 50MB)
- `public` → Debería ser `true`

---

## 🔄 Si necesitas cambiar la configuración

### Desde la UI (Recomendado):

1. **Storage** > **archivos** > **⚙️ Settings**
2. Modifica **"Allowed MIME types"** a: `*/*`
3. Modifica **"File size limit"** a: `50` MB
4. Guarda cambios

### Desde SQL (Avanzado):

```sql
-- Actualizar configuración del bucket
UPDATE storage.buckets
SET 
  allowed_mime_types = NULL,  -- NULL = permite todo
  file_size_limit = 52428800  -- 50 MB en bytes
WHERE name = 'archivos';
```

---

## ❌ Problemas comunes

### Error: "Invalid MIME type"

**Causa:** El bucket tiene restricciones de tipo MIME

**Solución:**
1. Ve a Storage > archivos > Settings
2. Cambia "Allowed MIME types" a `*/*` o `audio/*`
3. Guarda y reintenta

### Error: "File too large"

**Causa:** El archivo excede el límite del bucket

**Solución:**
1. Verifica que "File size limit" sea al menos 50 MB
2. O reduce el tamaño del archivo

### Error: "Policy violation"

**Causa:** No estás autenticado

**Solución:**
1. Cierra sesión y vuelve a iniciar
2. Verifica que las políticas RLS estén correctas (ver `storage-policies.sql`)

---

## 📊 Límites del plan gratuito de Supabase

| Recurso | Límite Gratuito |
|---------|----------------|
| Storage total | **1 GB** |
| Tamaño por archivo | **50 MB** (configurable) |
| Transferencia mensual | **2 GB** |
| Ancho de banda | **5 GB/día** |

⚠️ **Nota:** Si subes muchos archivos de audio, podrías alcanzar el límite de 1 GB

---

## ✅ Checklist de verificación

- [ ] Bucket "archivos" existe
- [ ] Bucket es público (`public = true`)
- [ ] "Allowed MIME types" = `*/*` o `audio/*` o vacío
- [ ] "File size limit" ≥ 50 MB
- [ ] Políticas RLS ejecutadas (de `storage-policies.sql`)
- [ ] Usuario autenticado al subir archivos

---

## 🆘 Si nada funciona

1. **Elimina y recrea el bucket:**
   ```sql
   -- ⚠️ CUIDADO: Esto elimina todos los archivos
   DROP POLICY IF EXISTS "Lectura pública de archivos" ON storage.objects;
   DROP POLICY IF EXISTS "Usuarios autenticados pueden subir archivos" ON storage.objects;
   -- Luego ve a UI y elimina/recrea el bucket
   ```

2. **Verifica logs en tiempo real:**
   - Ve a **Logs** en Supabase
   - Filtra por "storage"
   - Intenta subir un archivo
   - Lee el error específico

3. **Prueba con la API directamente:**
   ```javascript
   // En la consola del navegador
   const testFile = new File(['test'], 'test.m4a', { type: 'audio/mp4' });
   const { data, error } = await window.supabaseClient.storage
     .from('archivos')
     .upload('test/test.m4a', testFile);
   console.log({ data, error });
   ```

---

## 📝 Resumen

**Para aceptar cualquier formato de audio:**

1. ✅ Código JavaScript → Ya está listo (sin restricciones)
2. ✅ Políticas SQL → Ya están listas (sin restricciones)
3. ⚙️ **Config del bucket** → Verificar en UI que permita `audio/*` o `*/*`

**La mayoría de las veces, la configuración por defecto del bucket ya permite todo.**  
Solo necesitas verificar si hay errores específicos al subir.
