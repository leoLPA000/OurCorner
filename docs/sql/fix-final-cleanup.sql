-- ============================================================================
-- 🔐 ARREGLAR FUNCIÓN reacciones_conteo - DROP Y RECREATE
-- ============================================================================

-- Eliminar la función antigua
DROP FUNCTION IF EXISTS public.reacciones_conteo();

-- Recrearla con search_path correcto
CREATE FUNCTION public.reacciones_conteo()
RETURNS TABLE(emoji TEXT, total BIGINT)
SECURITY DEFINER
SET search_path = public
LANGUAGE SQL AS $$
    SELECT emoji, COUNT(*) as total
    FROM public.reacciones
    GROUP BY emoji;
$$;

-- ============================================================================
-- ✅ FIN
-- ============================================================================
