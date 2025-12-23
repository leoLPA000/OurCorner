-- ==============================================================================
-- ACTUALIZACIÓN TABLA MENSAJES - Agregar columnas faltantes
-- ==============================================================================
-- Este script agrega las columnas necesarias para el formulario de mensajes
-- ==============================================================================

-- Agregar columnas faltantes a la tabla mensajes
ALTER TABLE public.mensajes
ADD COLUMN IF NOT EXISTS categoria text,
ADD COLUMN IF NOT EXISTS emoji text DEFAULT '💕',
ADD COLUMN IF NOT EXISTS nota text;

-- Actualizar el nombre de la columna 'autor' para que sea text en lugar de uuid
-- (si ya está como text, esto no hace nada)
ALTER TABLE public.mensajes
ALTER COLUMN autor TYPE text;

-- Crear índice para búsquedas por categoría
CREATE INDEX IF NOT EXISTS idx_mensajes_categoria ON public.mensajes(categoria);

-- Verificar que todo está correcto
SELECT column_name, data_type, is_nullable
FROM information_schema.columns
WHERE table_name = 'mensajes'
AND table_schema = 'public'
ORDER BY ordinal_position;
