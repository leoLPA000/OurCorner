# 📦 Configuración de Políticas de Storage en Supabase

> **⚠️ IMPORTANTE**: Este documento describe cómo configurar políticas **temporales abiertas** para el bucket `archivos` durante desarrollo. Estas políticas permiten acceso anónimo completo y **NO deben usarse en producción**.

---

## 🎯 Objetivo

Permitir que usuarios anónimos (usando `anon key`) puedan:
- ✅ **Subir archivos** (INSERT) al bucket `archivos`
- ✅ **Leer/descargar archivos** (SELECT)
- ✅ **Eliminar archivos** (DELETE)

---

## 📋 Pasos para configurar desde la UI de Supabase

### 1. Acceder a la configuración del bucket

1. Abre tu proyecto en [Supabase Console](https://supabase.com/dashboard)
2. En el menú lateral izquierdo, haz clic en **"Storage"**
3. Verás la lista de buckets. Haz clic en el bucket **`archivos`**
4. Busca la pestaña **"Policies"** o **"Configuration"** → **"Policies"**

---

### 2. Crear política para INSERT (Upload/Subir archivos)

1. Haz clic en **"New Policy"** o **"Create Policy"**
2. Selecciona el template **"Custom"** o **"Allow public access"**
3. Configura la política con estos valores:

   - **Policy name**: `allow_anon_upload_archivos`
   - **Allowed operation**: `INSERT` (o marca "Upload")
   - **Target roles**: `anon` (o marca "Public access")
   - **USING expression** (si te pide condición):
     ```sql
     bucket_id = 'archivos'
     ```
   - **WITH CHECK expression**:
     ```sql
     bucket_id = 'archivos'
     ```

4. Guarda la política.

---

### 3. Crear política para SELECT (Read/Leer archivos)

1. Haz clic en **"New Policy"**
2. Configura:

   - **Policy name**: `allow_anon_select_archivos`
   - **Allowed operation**: `SELECT` (o marca "Download")
   - **Target roles**: `anon`
   - **USING expression**:
     ```sql
     bucket_id = 'archivos'
     ```

3. Guarda la política.

---

### 4. Crear política para DELETE (Eliminar archivos)

1. Haz clic en **"New Policy"**
2. Configura:

   - **Policy name**: `allow_anon_delete_archivos`
   - **Allowed operation**: `DELETE` (o marca "Delete")
   - **Target roles**: `anon`
   - **USING expression**:
     ```sql
     bucket_id = 'archivos'
     ```

3. Guarda la política.

---

### 5. (Opcional) Crear política para UPDATE

Si necesitas permitir que se actualicen metadatos de archivos:

1. Haz clic en **"New Policy"**
2. Configura:

   - **Policy name**: `allow_anon_update_archivos`
   - **Allowed operation**: `UPDATE`
   - **Target roles**: `anon`
   - **USING expression**:
     ```sql
     bucket_id = 'archivos'
     ```

3. Guarda la política.

---

## ✅ Verificación

Después de crear las políticas, verifica que funcionan:

1. Abre `http://localhost/pro/nuestroMes/test-supabase.html`
2. Abre la consola del navegador (F12)
3. Deberías ver:
   ```json
   {
     "uploadData": { ... },
     "uploadError": null
   }
   ```

Si sigue apareciendo el error `"new row violates row-level security policy"`, revisa:

- ✅ Que las políticas estén habilitadas y guardadas
- ✅ Que el nombre del bucket sea exactamente `archivos` (sin mayúsculas)
- ✅ Que estés usando la `anon key` en `js/supabaseConfig.js` (NO la service_role key)

---

## 🔒 Migración a Producción (TODO)

**Antes de publicar tu sitio**, debes:

1. **Implementar autenticación** con Supabase Auth
2. **Cambiar las políticas** para requerir `auth.uid()`:
   ```sql
   -- Ejemplo: permitir upload solo a usuarios autenticados
   CREATE POLICY allow_authenticated_upload ON storage.objects
     FOR INSERT
     WITH CHECK (
       bucket_id = 'archivos' 
       AND auth.role() = 'authenticated'
     );
   ```
3. **Eliminar políticas temporales** que usan `WITH CHECK (true)`

---

## 🆘 Solución de Problemas

### Error: "must be owner of table objects"

- **Causa**: Intentaste crear políticas desde SQL Editor sin permisos
- **Solución**: Usa la UI (Storage → Policies) en lugar de SQL

### Error: "new row violates row-level security policy"

- **Causa**: Las políticas no están creadas o no cubren la operación
- **Solución**: Verifica que exista la política de INSERT con `bucket_id = 'archivos'`

### Los archivos se suben pero no se ven

- **Causa**: El bucket no es público o falta política SELECT
- **Solución**: 
  1. Ve a Storage → Buckets → archivos → Settings
  2. Marca "Public bucket" como ON
  3. Crea la política SELECT según el paso 3

---

## 📝 Comandos SQL alternativos (si tienes permisos de owner)

Si prefieres usar SQL y tu cuenta tiene permisos completos:

```sql
-- Habilitar RLS en storage.objects
ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

-- Permitir INSERT
CREATE POLICY allow_anon_upload_archivos ON storage.objects
  FOR INSERT
  WITH CHECK (bucket_id = 'archivos');

-- Permitir SELECT
CREATE POLICY allow_anon_select_archivos ON storage.objects
  FOR SELECT
  USING (bucket_id = 'archivos');

-- Permitir DELETE
CREATE POLICY allow_anon_delete_archivos ON storage.objects
  FOR DELETE
  USING (bucket_id = 'archivos');
```

**Nota**: Es probable que te salga el error "must be owner of table objects". En ese caso, usa la UI.

---

## 🎉 Próximos Pasos

Una vez que las políticas estén configuradas:

1. ✅ Prueba el upload desde `test-supabase.html`
2. ✅ Integra las subidas en `js/musica.js` y `js/galeria.js`
3. ✅ Añade lógica para insertar metadata en las tablas `canciones`, `fotos` y `mensajes`
4. 🔜 Implementa autenticación para producción
5. 🔜 Ajusta políticas RLS para seguridad real

---

**¿Necesitas ayuda?** Consulta la [documentación oficial de Supabase Storage](https://supabase.com/docs/guides/storage).
