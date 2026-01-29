-- Agregar columnas adicionales para IPGeolocation.io
-- Estos campos proporcionan mayor precisión geográfica

ALTER TABLE visitor_logs 
ADD COLUMN IF NOT EXISTS distrito VARCHAR(255),
ADD COLUMN IF NOT EXISTS conexion_tipo VARCHAR(50),
ADD COLUMN IF NOT EXISTS organizacion VARCHAR(255);

-- Comentarios para documentar
COMMENT ON COLUMN visitor_logs.distrito IS 'Distrito o barrio (solo disponible con IPGeolocation.io)';
COMMENT ON COLUMN visitor_logs.conexion_tipo IS 'Tipo de conexión: dialup, cable, cellular, etc.';
COMMENT ON COLUMN visitor_logs.organizacion IS 'Organización propietaria del rango IP';
