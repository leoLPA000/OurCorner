-- ============================================================================
-- 🗄️ POLÍTICAS DE SUPABASE STORAGE PARA ARCHIVOS
-- Configurar permisos para subir/ver/eliminar archivos
-- ============================================================================

-- 1. CREAR BUCKET SI NO EXISTE (ejecutar en Storage, no en SQL Editor)
-- Ve a Storage > Create new bucket
-- Nombre: archivos
-- Public: ON (para que las imágenes sean visibles públicamente)

-- ============================================================================
-- 2. POLÍTICAS PARA EL BUCKET "archivos"
-- Ejecutar en SQL Editor
-- ============================================================================

-- Política: Cualquiera puede VER archivos (lectura pública)
CREATE POLICY "Lectura pública de archivos"
ON storage.objects FOR SELECT
TO public
USING (bucket_id = 'archivos');

-- Política: Usuarios autenticados pueden SUBIR archivos
CREATE POLICY "Usuarios autenticados pueden subir archivos"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'archivos');

-- Política: Usuarios autenticados pueden ACTUALIZAR sus archivos
CREATE POLICY "Usuarios autenticados pueden actualizar archivos"
ON storage.objects FOR UPDATE
TO authenticated
USING (bucket_id = 'archivos')
WITH CHECK (bucket_id = 'archivos');

-- Política: Usuarios autenticados pueden ELIMINAR archivos
CREATE POLICY "Usuarios autenticados pueden eliminar archivos"
ON storage.objects FOR DELETE
TO authenticated
USING (bucket_id = 'archivos');

-- ============================================================================
-- 3. VERIFICAR POLÍTICAS
-- ============================================================================
SELECT * FROM storage.policies WHERE bucket_id = 'archivos';

-- ============================================================================
-- NOTAS IMPORTANTES:
-- ============================================================================
-- 1. Si ya tienes políticas antiguas, elimínalas primero:
--    DROP POLICY "nombre_de_la_politica" ON storage.objects;
--
-- 2. El bucket debe estar creado en Storage > Buckets
--
-- 3. Si el bucket es público, las URLs de las imágenes serán accesibles
--    sin autenticación (recomendado para una galería pública)
--
-- 4. Si quieres que solo el dueño pueda eliminar sus archivos:
--    USING (bucket_id = 'archivos' AND auth.uid() = owner)
-- ============================================================================
