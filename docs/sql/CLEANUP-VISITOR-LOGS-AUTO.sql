-- ============================================================================
-- 🧹 SCRIPT DE LIMPIEZA AUTOMÁTICA - SUPABASE
-- ============================================================================
-- 
-- Descripción: Este script elimina completamente toda la funcionalidad 
-- de IP tracking y geolocalización de la base de datos
--
-- Fecha: 2 de mayo 2026
-- Rama: 25-04-2026-Refactorizacion02-05-2026
--
-- ⚠️  ADVERTENCIA: Este script es DESTRUCTIVO
-- Antes de ejecutar, HACER BACKUP DE LA BASE DE DATOS
-- 
-- ============================================================================

-- Paso 1: Verificar que la tabla existe
-- (Si no existe, el script continúa sin error)
DO $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_name = 'visitor_logs'
    ) THEN
        RAISE NOTICE 'Tabla visitor_logs encontrada. Iniciando limpieza...';
    ELSE
        RAISE NOTICE 'Tabla visitor_logs NO existe. Saltando limpieza.';
        RETURN;
    END IF;
END $$;

-- ============================================================================
-- Paso 2: Desactivar triggers (si existen)
-- ============================================================================
DO $$
DECLARE
    trigger_record RECORD;
BEGIN
    FOR trigger_record IN 
        SELECT trigger_name 
        FROM information_schema.triggers 
        WHERE event_object_table = 'visitor_logs'
    LOOP
        EXECUTE 'DROP TRIGGER IF EXISTS ' || trigger_record.trigger_name || 
                ' ON public.visitor_logs CASCADE';
        RAISE NOTICE 'Trigger eliminado: %', trigger_record.trigger_name;
    END LOOP;
END $$;

-- ============================================================================
-- Paso 3: Eliminar RLS Policies
-- ============================================================================
RAISE NOTICE 'Eliminando RLS Policies...';

DROP POLICY IF EXISTS "enable_read_visitor_logs" ON public.visitor_logs;
DROP POLICY IF EXISTS "enable_insert_visitor_logs" ON public.visitor_logs;
DROP POLICY IF EXISTS "enable_update_visitor_logs" ON public.visitor_logs;
DROP POLICY IF EXISTS "enable_delete_visitor_logs" ON public.visitor_logs;
DROP POLICY IF EXISTS "Visitor logs - INSERT público" ON public.visitor_logs;
DROP POLICY IF EXISTS "Visitor logs - INSERT autenticado" ON public.visitor_logs;

-- Desactivar RLS en la tabla
ALTER TABLE IF EXISTS public.visitor_logs DISABLE ROW LEVEL SECURITY;

-- ============================================================================
-- Paso 4: Eliminar funciones relacionadas
-- ============================================================================
RAISE NOTICE 'Eliminando funciones relacionadas...';

DROP FUNCTION IF EXISTS public.get_visitor_stats() CASCADE;
DROP FUNCTION IF EXISTS public.count_visitor_logs() CASCADE;
DROP FUNCTION IF EXISTS public.get_recent_visitors() CASCADE;
DROP FUNCTION IF EXISTS public.visitor_stats_summary() CASCADE;

-- ============================================================================
-- Paso 5: Eliminar vistas dependientes (si existen)
-- ============================================================================
RAISE NOTICE 'Eliminando vistas dependientes...';

DROP VIEW IF EXISTS public.visitor_logs_summary CASCADE;
DROP VIEW IF EXISTS public.visitor_stats CASCADE;

-- ============================================================================
-- Paso 6: Eliminar la tabla principal
-- ============================================================================
RAISE NOTICE 'Eliminando tabla visitor_logs...';

DROP TABLE IF EXISTS public.visitor_logs CASCADE;

-- ============================================================================
-- Paso 7: Eliminar índices relacionados (si existen independientemente)
-- ============================================================================
RAISE NOTICE 'Limpiando índices...';

DROP INDEX IF EXISTS public.idx_visitor_logs_fingerprint CASCADE;
DROP INDEX IF EXISTS public.idx_visitor_logs_ip CASCADE;
DROP INDEX IF EXISTS public.idx_visitor_logs_timestamp CASCADE;
DROP INDEX IF EXISTS public.idx_visitor_logs_visitor_id CASCADE;

-- ============================================================================
-- Paso 8: Eliminar secuencias (si existen)
-- ============================================================================
RAISE NOTICE 'Limpiando secuencias...';

DROP SEQUENCE IF EXISTS public.visitor_logs_id_seq CASCADE;

-- ============================================================================
-- ✅ LIMPIEZA COMPLETADA
-- ============================================================================

RAISE NOTICE '✅ Limpieza de IP tracking completada exitosamente';
RAISE NOTICE 'La tabla visitor_logs y todas sus dependencias han sido eliminadas';

-- Verificación final
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.tables 
        WHERE table_schema = 'public' 
        AND table_name = 'visitor_logs'
    ) THEN
        RAISE NOTICE '✅ VERIFICACIÓN: La tabla visitor_logs ha sido eliminada correctamente';
    ELSE
        RAISE WARNING '⚠️  ADVERTENCIA: La tabla visitor_logs aún existe';
    END IF;
END $$;
