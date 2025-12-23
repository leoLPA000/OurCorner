-- SQL para insertar canciones de ejemplo en Supabase
-- Ejecuta esto en el SQL Editor de Supabase
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Primero, asegúrate de que la tabla 'canciones' existe
CREATE TABLE IF NOT EXISTS canciones (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    titulo TEXT NOT NULL,
    artista TEXT NOT NULL,
    url TEXT NOT NULL,
    tipo TEXT DEFAULT 'personalizada',
    path TEXT,
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Insertar canciones de ejemplo (URLs de ejemplo - reemplaza con tus URLs reales)
-- Estas son URLs de ejemplo, necesitas subirlas a tu Storage primero o usar URLs públicas

INSERT INTO canciones (titulo, artista, url, tipo) VALUES
('Perfect', 'Ed Sheeran', 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3', 'predeterminada');

-- Ver las canciones insertadas
SELECT * FROM canciones ORDER BY creado_en DESC;

-- NOTA IMPORTANTE:
-- Las URLs de arriba son de ejemplo y NO son canciones reales románticas.
-- Para usar canciones reales, necesitas:
-- 1. Subir archivos MP3 a Supabase Storage (bucket 'archivos')
-- 2. Obtener las URLs públicas de cada archivo
-- 3. Reemplazar las URLs en este script
-- 
-- O usar URLs públicas de servicios como:
-- - Archive.org (música de dominio público)
-- - Freesound.org
-- - YouTube Audio Library (descargadas y subidas a tu storage)
