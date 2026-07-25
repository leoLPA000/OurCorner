-- ============================================================================
-- Añadir soporte de imágenes al calendario
-- Ejecutar en: Supabase Dashboard → SQL Editor
-- ============================================================================

-- ── 1. Columna image_url en la tabla ──
ALTER TABLE public.calendario_eventos
    ADD COLUMN IF NOT EXISTS image_url TEXT;

-- ── 2. Crear bucket de almacenamiento ──
INSERT INTO storage.buckets (id, name, public)
VALUES ('calendario-imagenes', 'calendario-imagenes', true)
ON CONFLICT (id) DO NOTHING;

-- ── 3. Políticas del bucket ──
-- Solo admin puede subir imágenes
CREATE POLICY "cal_img_insert_admin" ON storage.objects
    FOR INSERT TO authenticated
    WITH CHECK (
        bucket_id = 'calendario-imagenes'
        AND public.current_user_is_admin()
    );

-- Cualquiera puede ver las imágenes (bucket público)
CREATE POLICY "cal_img_select_public" ON storage.objects
    FOR SELECT TO public
    USING (bucket_id = 'calendario-imagenes');

-- Solo admin puede eliminar imágenes
CREATE POLICY "cal_img_delete_admin" ON storage.objects
    FOR DELETE TO authenticated
    USING (
        bucket_id = 'calendario-imagenes'
        AND public.current_user_is_admin()
    );
