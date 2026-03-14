-- Arreglar el problema de seguridad en visitor_stats
-- Ejecutar en Supabase SQL Editor

-- 1. Eliminar la vista existente
DROP VIEW IF EXISTS visitor_stats;

-- 2. Recrear la vista con seguridad correcta (SECURITY INVOKER en vez de DEFINER)
CREATE OR REPLACE VIEW visitor_stats 
WITH (security_invoker = true)
AS
SELECT 
    COUNT(*) as total_visitas,
    COUNT(DISTINCT ip_publica) as ips_unicas,
    COUNT(DISTINCT pais) as paises_unicos,
    COUNT(CASE WHEN DATE(timestamp) = CURRENT_DATE THEN 1 END) as visitas_hoy,
    COUNT(CASE WHEN es_movil = true THEN 1 END) as visitas_moviles,
    COUNT(CASE WHEN tipo_dispositivo = 'Desktop' THEN 1 END) as visitas_desktop
FROM visitor_logs;

-- 3. Dar permisos de lectura
GRANT SELECT ON visitor_stats TO anon, authenticated;

-- ✅ Esto elimina el warning de seguridad
