-- Script de limpieza: Eliminar tabla visitor_logs
-- Ejecutar en Supabase SQL Editor
-- Fecha: 2 de mayo 2026

-- ADVERTENCIA: Este script elimina TODA la tabla visitor_logs
-- Hacer backup antes de ejecutar

-- Paso 1: Eliminar RLS policies relacionadas
DROP POLICY IF EXISTS "enable_read_visitor_logs" ON public.visitor_logs;
DROP POLICY IF EXISTS "enable_insert_visitor_logs" ON public.visitor_logs;
DROP POLICY IF EXISTS "enable_update_visitor_logs" ON public.visitor_logs;
DROP POLICY IF EXISTS "enable_delete_visitor_logs" ON public.visitor_logs;

-- Paso 2: Desactivar RLS en la tabla
ALTER TABLE IF EXISTS public.visitor_logs DISABLE ROW LEVEL SECURITY;

-- Paso 3: Eliminar funciones relacionadas
DROP FUNCTION IF EXISTS public.get_visitor_stats() CASCADE;
DROP FUNCTION IF EXISTS public.count_visitor_logs() CASCADE;

-- Paso 4: Eliminar la tabla
DROP TABLE IF EXISTS public.visitor_logs CASCADE;

-- Confirmación
-- Si ejecuta sin errores, la tabla visitor_logs ha sido eliminada correctamente
