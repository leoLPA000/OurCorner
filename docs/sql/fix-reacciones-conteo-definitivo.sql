-- ============================================================================
-- 🔐 ARREGLAR FUNCIÓN reacciones_conteo - VERSIÓN DEFINITIVA
-- ============================================================================

-- Paso 1: Eliminar la función
DROP FUNCTION IF EXISTS public.reacciones_conteo() CASCADE;

-- Paso 2: Recrear con search_path obligatorio
CREATE FUNCTION public.reacciones_conteo()
RETURNS TABLE(emoji TEXT, total BIGINT)
LANGUAGE SQL
SECURITY DEFINER
SET search_path = 'public'
STABLE
AS $$
    SELECT emoji, COUNT(*) as total
    FROM public.reacciones
    GROUP BY emoji
    ORDER BY total DESC;
$$;

-- Paso 3: Dar permisos
GRANT EXECUTE ON FUNCTION public.reacciones_conteo() TO authenticated, anon;

-- ============================================================================
-- ✅ FIN - Función recreada con search_path correcto
-- ============================================================================
