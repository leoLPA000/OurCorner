-- ============================================================================
-- 🔐 ARREGLAR POLÍTICAS RLS - VERSIÓN FINAL (SOLO TABLAS EXISTENTES)
-- ============================================================================

-- ============================================================================
-- 1. REACCIONES
-- ============================================================================

DROP POLICY IF EXISTS "Permitir todas las operaciones públicas en reacciones" ON reacciones;
DROP POLICY IF EXISTS "allow_insert_anonymous" ON reacciones;
DROP POLICY IF EXISTS "Reacciones - Lectura pública" ON reacciones;
DROP POLICY IF EXISTS "Reacciones - Inserción con registro" ON reacciones;
DROP POLICY IF EXISTS "Reacciones - Actualización permitida" ON reacciones;
DROP POLICY IF EXISTS "Reacciones - Eliminación permitida" ON reacciones;

CREATE POLICY "Reacciones - SELECT público"
ON reacciones FOR SELECT
USING (true);

CREATE POLICY "Reacciones - INSERT público"
ON reacciones FOR INSERT
WITH CHECK (true);

-- ============================================================================
-- 2. MENSAJES
-- ============================================================================

DROP POLICY IF EXISTS "mensajes_insert_temp" ON mensajes;
DROP POLICY IF EXISTS "mensajes_update_temp" ON mensajes;
DROP POLICY IF EXISTS "mensajes_delete_temp" ON mensajes;
DROP POLICY IF EXISTS "Mensajes - Inserción permitida" ON mensajes;
DROP POLICY IF EXISTS "Mensajes - Actualización permitida" ON mensajes;
DROP POLICY IF EXISTS "Mensajes - Eliminación permitida" ON mensajes;

CREATE POLICY "Mensajes - SELECT público"
ON mensajes FOR SELECT
USING (true);

CREATE POLICY "Mensajes - INSERT permitido"
ON mensajes FOR INSERT
WITH CHECK (true);

-- ============================================================================
-- 3. CANCIONES
-- ============================================================================

DROP POLICY IF EXISTS "canciones_insert_temp" ON canciones;
DROP POLICY IF EXISTS "canciones_update_temp" ON canciones;
DROP POLICY IF EXISTS "canciones_delete_temp" ON canciones;
DROP POLICY IF EXISTS "anon_insert" ON canciones;
DROP POLICY IF EXISTS "public_delete" ON canciones;
DROP POLICY IF EXISTS "Canciones - Inserción permitida" ON canciones;
DROP POLICY IF EXISTS "Canciones - Actualización permitida" ON canciones;
DROP POLICY IF EXISTS "Canciones - Eliminación permitida" ON canciones;

CREATE POLICY "Canciones - SELECT público"
ON canciones FOR SELECT
USING (true);

CREATE POLICY "Canciones - INSERT permitido"
ON canciones FOR INSERT
WITH CHECK (true);

-- ============================================================================
-- 4. FOTOS
-- ============================================================================

DROP POLICY IF EXISTS "Usuarios autenticados pueden actualizar fotos" ON fotos;
DROP POLICY IF EXISTS "Usuarios autenticados pueden eliminar fotos" ON fotos;
DROP POLICY IF EXISTS "fotos_insert_temp" ON fotos;
DROP POLICY IF EXISTS "fotos_update_temp" ON fotos;
DROP POLICY IF EXISTS "fotos_delete_temp" ON fotos;
DROP POLICY IF EXISTS "Fotos - Inserción permitida" ON fotos;
DROP POLICY IF EXISTS "Fotos - Actualización permitida" ON fotos;
DROP POLICY IF EXISTS "Fotos - Eliminación permitida" ON fotos;

CREATE POLICY "Fotos - SELECT público"
ON fotos FOR SELECT
USING (true);

CREATE POLICY "Fotos - INSERT autenticado"
ON fotos FOR INSERT
WITH CHECK (auth.role() = 'authenticated');

-- ============================================================================
-- 5. USER_PROFILES
-- ============================================================================

DROP POLICY IF EXISTS "Creación de perfiles permitida" ON user_profiles;
DROP POLICY IF EXISTS "Permitir creación de perfiles" ON user_profiles;
DROP POLICY IF EXISTS "Perfiles pueden ser creados durante registro" ON user_profiles;
DROP POLICY IF EXISTS "Perfiles - Lectura pública" ON user_profiles;
DROP POLICY IF EXISTS "Perfiles - Inserción permitida" ON user_profiles;
DROP POLICY IF EXISTS "Perfiles - Actualización permitida" ON user_profiles;

CREATE POLICY "User profiles - SELECT público"
ON user_profiles FOR SELECT
USING (true);

CREATE POLICY "User profiles - INSERT permitido"
ON user_profiles FOR INSERT
WITH CHECK (true);

-- ============================================================================
-- 6. VISITOR_LOGS
-- ============================================================================

DROP POLICY IF EXISTS "Permitir inserción pública en visitor_logs" ON visitor_logs;
DROP POLICY IF EXISTS "Permitir insertar logs públicamente" ON visitor_logs;
DROP POLICY IF EXISTS "Visitor logs pueden ser insertados con validación" ON visitor_logs;
DROP POLICY IF EXISTS "Visitor logs - Lectura pública" ON visitor_logs;
DROP POLICY IF EXISTS "Visitor logs - Inserción pública" ON visitor_logs;

CREATE POLICY "Visitor logs - SELECT público"
ON visitor_logs FOR SELECT
USING (true);

CREATE POLICY "Visitor logs - INSERT público"
ON visitor_logs FOR INSERT
WITH CHECK (true);

-- ============================================================================
-- ✅ FIN - RLS HABILITADO EN TODAS LAS TABLAS
-- ============================================================================
