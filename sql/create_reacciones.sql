-- Crear tabla reacciones (versión mejorada con session_id)
CREATE TABLE IF NOT EXISTS reacciones (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mensaje_id uuid REFERENCES mensajes(id) ON DELETE CASCADE,
  session_id text NOT NULL, -- ID de sesión para simular usuario anónimo
  emoji text NOT NULL,
  creado_en timestamptz DEFAULT now()
);

-- Índice para consultas por mensaje
CREATE INDEX IF NOT EXISTS idx_reacciones_mensaje_id ON reacciones(mensaje_id);

-- Índice único para evitar múltiples reacciones por sesión/mensaje
CREATE UNIQUE INDEX IF NOT EXISTS idx_reacciones_unique_session 
ON reacciones(mensaje_id, session_id);

-- Función RPC optimizada para conteos únicos
CREATE OR REPLACE FUNCTION reacciones_conteo(mensaje uuid)
RETURNS TABLE(emoji text, total bigint)
LANGUAGE sql STABLE AS $$
  SELECT emoji, COUNT(DISTINCT session_id)::bigint AS total
  FROM reacciones
  WHERE mensaje_id = mensaje
  GROUP BY emoji;
$$;

-- Conteo por mensaje y emoji (opcional: materialized view ejemplo)
-- CREATE MATERIALIZED VIEW reacciones_por_mensaje AS
-- SELECT mensaje_id, emoji, count(*) as total
-- FROM reacciones
-- GROUP BY mensaje_id, emoji;
