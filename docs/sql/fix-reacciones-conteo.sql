-- ============================================================================
-- 🔐 ARREGLAR FUNCIÓN reacciones_conteo CON search_path
-- ============================================================================

-- Si la función existe, recrearla con search_path
CREATE OR REPLACE FUNCTION public.reacciones_conteo()
RETURNS TABLE(emoji TEXT, total BIGINT)
SECURITY DEFINER
SET search_path = public
LANGUAGE SQL AS $$
    SELECT emoji, COUNT(*) as total
    FROM public.reacciones
    GROUP BY emoji;
$$;

-- ============================================================================
-- VERIFICAR FUNCIÓN
-- ============================================================================
-- SELECT proname, prosecdef, proconfig FROM pg_proc WHERE proname = 'reacciones_conteo';
