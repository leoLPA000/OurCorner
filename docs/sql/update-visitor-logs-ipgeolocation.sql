-- Agregar columnas adicionales para IPGeolocation.io y GPS
-- Estos campos proporcionan mayor precisión geográfica

ALTER TABLE visitor_logs 
ADD COLUMN IF NOT EXISTS distrito VARCHAR(255),
ADD COLUMN IF NOT EXISTS conexion_tipo VARCHAR(50),
ADD COLUMN IF NOT EXISTS organizacion VARCHAR(255),
ADD COLUMN IF NOT EXISTS gps_latitud DECIMAL(10, 7),
ADD COLUMN IF NOT EXISTS gps_longitud DECIMAL(10, 7),
ADD COLUMN IF NOT EXISTS gps_precision INTEGER,
ADD COLUMN IF NOT EXISTS gps_altitud DECIMAL(10, 2),
ADD COLUMN IF NOT EXISTS gps_velocidad DECIMAL(8, 2),
ADD COLUMN IF NOT EXISTS gps_estado VARCHAR(50);

-- Comentarios para documentar
COMMENT ON COLUMN visitor_logs.distrito IS 'Distrito o barrio (solo disponible con IPGeolocation.io)';
COMMENT ON COLUMN visitor_logs.conexion_tipo IS 'Tipo de conexión: dialup, cable, cellular, etc.';
COMMENT ON COLUMN visitor_logs.organizacion IS 'Organización propietaria del rango IP';
COMMENT ON COLUMN visitor_logs.gps_latitud IS 'Latitud GPS real del dispositivo (más precisa que IP)';
COMMENT ON COLUMN visitor_logs.gps_longitud IS 'Longitud GPS real del dispositivo';
COMMENT ON COLUMN visitor_logs.gps_precision IS 'Precisión del GPS en metros';
COMMENT ON COLUMN visitor_logs.gps_altitud IS 'Altitud en metros sobre nivel del mar';
COMMENT ON COLUMN visitor_logs.gps_velocidad IS 'Velocidad del dispositivo en m/s';
COMMENT ON COLUMN visitor_logs.gps_estado IS 'Estado de la captura GPS: Obtenido, Permiso denegado, No soportado, etc.';
