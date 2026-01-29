-- Script para LIMPIAR y RECREAR la tabla visitor_logs
-- Ejecutar en Supabase SQL Editor si quieres empezar de cero

-- 1. Eliminar políticas existentes
DROP POLICY IF EXISTS "Permitir insertar logs públicamente" ON visitor_logs;
DROP POLICY IF EXISTS "Permitir leer logs públicamente" ON visitor_logs;
DROP POLICY IF EXISTS "Permitir leer logs a usuarios autenticados" ON visitor_logs;

-- 2. Eliminar vista
DROP VIEW IF EXISTS visitor_stats;

-- 3. Eliminar tabla
DROP TABLE IF EXISTS visitor_logs;

-- 4. Ahora ejecuta el SQL original completo de visitor-logs-setup.sql
