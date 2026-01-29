-- Tabla para almacenar logs de visitantes
-- Ejecutar en Supabase SQL Editor

CREATE TABLE IF NOT EXISTS visitor_logs (
    -- Identificación
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    visitor_id TEXT NOT NULL,
    timestamp TIMESTAMPTZ DEFAULT NOW(),
    
    -- Información de Red
    ip_publica TEXT,
    ip_local TEXT,
    isp TEXT,
    asn TEXT,
    
    -- Geolocalización
    pais TEXT,
    codigo_pais TEXT,
    region TEXT,
    ciudad TEXT,
    codigo_postal TEXT,
    latitud NUMERIC,
    longitud NUMERIC,
    zona_horaria TEXT,
    
    -- Dispositivo y Navegador
    navegador TEXT,
    sistema_operativo TEXT,
    plataforma TEXT,
    tipo_dispositivo TEXT,
    es_movil BOOLEAN DEFAULT FALSE,
    user_agent TEXT,
    
    -- Hardware
    resolucion_pantalla TEXT,
    profundidad_color INTEGER,
    nucleos_cpu INTEGER,
    memoria TEXT,
    
    -- Capacidades
    idioma TEXT,
    idiomas TEXT[],
    cookies_habilitadas BOOLEAN,
    dnt TEXT,
    
    -- Fingerprints
    canvas_fp TEXT,
    webgl_vendor TEXT,
    webgl_renderer TEXT,
    fingerprint_unico TEXT,
    
    -- Navegación
    url_actual TEXT,
    url_referrer TEXT,
    
    -- Datos completos en JSON (para flexibilidad)
    datos_completos JSONB,
    
    -- Índices para búsquedas rápidas
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índices para mejorar rendimiento
CREATE INDEX IF NOT EXISTS idx_visitor_logs_timestamp ON visitor_logs(timestamp DESC);
CREATE INDEX IF NOT EXISTS idx_visitor_logs_ip ON visitor_logs(ip_publica);
CREATE INDEX IF NOT EXISTS idx_visitor_logs_pais ON visitor_logs(pais);
CREATE INDEX IF NOT EXISTS idx_visitor_logs_fingerprint ON visitor_logs(fingerprint_unico);

-- RLS (Row Level Security) - Permitir lectura/escritura pública para logs
ALTER TABLE visitor_logs ENABLE ROW LEVEL SECURITY;

-- Política: Permitir insertar a cualquiera (para capturar visitantes)
CREATE POLICY "Permitir insertar logs públicamente" 
ON visitor_logs
FOR INSERT 
TO anon
WITH CHECK (true);

-- Política: Permitir leer todos los logs (para el panel)
-- NOTA: Esto es público. Si quieres protección, cambia a authenticated y requiere login
CREATE POLICY "Permitir leer logs públicamente" 
ON visitor_logs
FOR SELECT 
TO anon
USING (true);

-- Si prefieres que solo usuarios autenticados lean logs, usa esto en su lugar:
-- CREATE POLICY "Permitir leer logs a usuarios autenticados" 
-- ON visitor_logs
-- FOR SELECT 
-- TO authenticated
-- USING (true);

-- Vista para estadísticas rápidas
CREATE OR REPLACE VIEW visitor_stats AS
SELECT 
    COUNT(*) as total_visitas,
    COUNT(DISTINCT ip_publica) as ips_unicas,
    COUNT(DISTINCT pais) as paises_unicos,
    COUNT(CASE WHEN DATE(timestamp) = CURRENT_DATE THEN 1 END) as visitas_hoy,
    COUNT(CASE WHEN es_movil = true THEN 1 END) as visitas_moviles,
    COUNT(CASE WHEN tipo_dispositivo = 'Desktop' THEN 1 END) as visitas_desktop
FROM visitor_logs;

-- Permitir leer estadísticas
GRANT SELECT ON visitor_stats TO anon, authenticated;

COMMENT ON TABLE visitor_logs IS 'Registro de visitantes con información detallada del dispositivo y ubicación';
