-- ================================================
-- VALENTINE PROJECT - Supabase Database Setup
-- ================================================
-- Este script configura las tablas necesarias para el proyecto Valentine
-- Ejecuta esto en el SQL Editor de tu proyecto Supabase
-- ================================================

-- 1. Tabla para tarjetas en la galería pública
CREATE TABLE IF NOT EXISTS cards (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    sender TEXT NOT NULL,
    receiver TEXT NOT NULL,
    drawing JSONB NOT NULL, -- Array de strokes (color + path coordinates)
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índice para optimizar consultas por fecha
CREATE INDEX IF NOT EXISTS idx_cards_created_at ON cards(created_at DESC);

-- 2. Tabla para analíticas (logs de creación)
CREATE TABLE IF NOT EXISTS card_logs (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    sender TEXT NOT NULL,
    receiver TEXT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índice para análisis temporal
CREATE INDEX IF NOT EXISTS idx_card_logs_created_at ON card_logs(created_at DESC);

-- 3. Tabla para enlaces cortos compartidos
CREATE TABLE IF NOT EXISTS shared_cards (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    sender TEXT NOT NULL,
    receiver TEXT NOT NULL,
    drawing JSONB NOT NULL,
    quote_index INTEGER DEFAULT 0,
    created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Índice para búsqueda rápida por ID
CREATE INDEX IF NOT EXISTS idx_shared_cards_id ON shared_cards(id);

-- ================================================
-- Row Level Security (RLS) Policies
-- ================================================
-- Habilitar RLS en todas las tablas
ALTER TABLE cards ENABLE ROW LEVEL SECURITY;
ALTER TABLE card_logs ENABLE ROW LEVEL SECURITY;
ALTER TABLE shared_cards ENABLE ROW LEVEL SECURITY;

-- Políticas para 'cards' (galería pública)
-- Cualquiera puede leer
CREATE POLICY "Allow public read access to cards"
    ON cards FOR SELECT
    USING (true);

-- Cualquiera puede insertar (crear tarjetas)
CREATE POLICY "Allow public insert to cards"
    ON cards FOR INSERT
    WITH CHECK (true);

-- Políticas para 'card_logs' (solo inserción)
-- Solo inserción permitida (para analíticas)
CREATE POLICY "Allow public insert to card_logs"
    ON card_logs FOR INSERT
    WITH CHECK (true);

-- Políticas para 'shared_cards'
-- Cualquiera puede leer
CREATE POLICY "Allow public read access to shared_cards"
    ON shared_cards FOR SELECT
    USING (true);

-- Cualquiera puede insertar
CREATE POLICY "Allow public insert to shared_cards"
    ON shared_cards FOR INSERT
    WITH CHECK (true);

-- ================================================
-- Verificación (opcional)
-- ================================================
-- Descomentar para verificar que todo se creó correctamente:
-- SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';
-- SELECT * FROM cards LIMIT 1;
-- SELECT * FROM card_logs LIMIT 1;
-- SELECT * FROM shared_cards LIMIT 1;

-- ================================================
-- LIMPIEZA (solo si necesitas resetear)
-- ================================================
-- CUIDADO: Esto elimina TODOS los datos
-- Descomentar solo si quieres empezar de cero:
-- DROP TABLE IF EXISTS cards CASCADE;
-- DROP TABLE IF EXISTS card_logs CASCADE;
-- DROP TABLE IF EXISTS shared_cards CASCADE;
