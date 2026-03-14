-- ============================================================================
-- 🔐 ARREGLAR POLÍTICAS RLS PARA USER_PROFILES
-- Solución para errores 406 (Not Acceptable)
-- ============================================================================

-- 1. Eliminar políticas anteriores problemáticas
DROP POLICY IF EXISTS "Perfiles públicos para lectura" ON user_profiles;
DROP POLICY IF EXISTS "Sistema puede crear perfiles" ON user_profiles;
DROP POLICY IF EXISTS "Usuarios pueden actualizar su perfil" ON user_profiles;

-- 2. Crear nuevas políticas más permisivas para resolver el 406

-- Política de LECTURA: Cualquiera puede leer (necesario para login con username)
CREATE POLICY "Permitir lectura pública de perfiles"
ON user_profiles FOR SELECT
USING (true);

-- Política de INSERCIÓN: Usuarios autenticados pueden crear su perfil
-- O permitir inserción anónima durante el registro
CREATE POLICY "Permitir creación de perfiles"
ON user_profiles FOR INSERT
WITH CHECK (true);

-- Política de ACTUALIZACIÓN: Solo el dueño puede actualizar
CREATE POLICY "Usuario puede actualizar su propio perfil"
ON user_profiles FOR UPDATE
USING (auth.uid() = user_id);

-- 3. Asegurarse que RLS esté habilitado
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

-- 4. Otorgar permisos básicos (si es necesario)
GRANT SELECT ON user_profiles TO anon;
GRANT INSERT ON user_profiles TO anon;
GRANT SELECT, UPDATE ON user_profiles TO authenticated;

-- ============================================================================
-- NOTA IMPORTANTE: Ejecuta este script en el SQL Editor de Supabase
-- Dashboard > SQL Editor > New Query > Pega este código > Run
-- ============================================================================
