-- ============================================================================
-- 🔐 SISTEMA DE AUTENTICACIÓN Y ROW LEVEL SECURITY (RLS)
-- Para OurCorner - Sistema de autenticación con Supabase Auth
-- ============================================================================

-- ----------------------------------------------------------------------------
-- 1. CREAR TABLA DE PERFILES DE USUARIO
-- Almacena username único para cada usuario (login con username en lugar de email)
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user_profiles (
    id SERIAL PRIMARY KEY,
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
    username VARCHAR(20) UNIQUE NOT NULL,
    email VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Crear índices para búsquedas rápidas
CREATE UNIQUE INDEX IF NOT EXISTS idx_user_profiles_username ON user_profiles(LOWER(username));
CREATE INDEX IF NOT EXISTS idx_user_profiles_user_id ON user_profiles(user_id);
CREATE INDEX IF NOT EXISTS idx_user_profiles_email ON user_profiles(email);

-- Habilitar RLS en user_profiles
ALTER TABLE user_profiles ENABLE ROW LEVEL SECURITY;

-- Política: Todos pueden leer perfiles (para login con username)
DROP POLICY IF EXISTS "Perfiles públicos para lectura" ON user_profiles;
CREATE POLICY "Perfiles públicos para lectura"
ON user_profiles FOR SELECT
TO public
USING (true);

-- Política: Solo el sistema puede crear perfiles (se crean al registrar)
DROP POLICY IF EXISTS "Sistema puede crear perfiles" ON user_profiles;
CREATE POLICY "Sistema puede crear perfiles"
ON user_profiles FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id);

-- Política: Solo el usuario puede actualizar su perfil
DROP POLICY IF EXISTS "Usuarios pueden actualizar su perfil" ON user_profiles;
CREATE POLICY "Usuarios pueden actualizar su perfil"
ON user_profiles FOR UPDATE
TO authenticated
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

-- ----------------------------------------------------------------------------
-- 2. ACTUALIZAR TABLA MENSAJES
-- Agregar columna user_id para asociar mensajes con usuarios
-- ----------------------------------------------------------------------------
ALTER TABLE mensajes 
ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;

-- Crear índice para mejorar el rendimiento
CREATE INDEX IF NOT EXISTS idx_mensajes_user_id ON mensajes(user_id);

-- ----------------------------------------------------------------------------
-- 2. ACTUALIZAR TABLA REACCIONES
-- Cambiar session_id a user_id para autenticación real
-- ----------------------------------------------------------------------------
ALTER TABLE reacciones 
ADD COLUMN IF NOT EXISTS user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE;

-- Crear índice para mejorar el rendimiento
CREATE INDEX IF NOT EXISTS idx_reacciones_user_id ON reacciones(user_id);

-- Migrar datos existentes (opcional, eliminar si no hay datos previos)
-- UPDATE reacciones SET user_id = NULL WHERE user_id IS NULL;

-- ----------------------------------------------------------------------------
-- 3. HABILITAR ROW LEVEL SECURITY (RLS)
-- Proteger las tablas con políticas de seguridad
-- ----------------------------------------------------------------------------
ALTER TABLE mensajes ENABLE ROW LEVEL SECURITY;
ALTER TABLE reacciones ENABLE ROW LEVEL SECURITY;

-- ----------------------------------------------------------------------------
-- 4. POLÍTICAS DE MENSAJES
-- Definir quién puede leer, crear, actualizar y eliminar mensajes
-- ----------------------------------------------------------------------------

-- Política de LECTURA: Todos pueden leer mensajes (público)
DROP POLICY IF EXISTS "Mensajes son públicos para lectura" ON mensajes;
CREATE POLICY "Mensajes son públicos para lectura"
ON mensajes FOR SELECT
TO public
USING (true);

-- Política de CREACIÓN: Solo usuarios autenticados pueden crear mensajes
DROP POLICY IF EXISTS "Usuarios autenticados pueden crear mensajes" ON mensajes;
CREATE POLICY "Usuarios autenticados pueden crear mensajes"
ON mensajes FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id);

-- Política de ACTUALIZACIÓN: Solo el autor puede actualizar sus mensajes
DROP POLICY IF EXISTS "Usuarios pueden actualizar sus propios mensajes" ON mensajes;
CREATE POLICY "Usuarios pueden actualizar sus propios mensajes"
ON mensajes FOR UPDATE
TO authenticated
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

-- Política de ELIMINACIÓN: Solo el autor puede eliminar sus mensajes
DROP POLICY IF EXISTS "Usuarios pueden eliminar sus propios mensajes" ON mensajes;
CREATE POLICY "Usuarios pueden eliminar sus propios mensajes"
ON mensajes FOR DELETE
TO authenticated
USING (auth.uid() = user_id);

-- ----------------------------------------------------------------------------
-- 5. POLÍTICAS DE REACCIONES
-- Definir quién puede leer, crear, actualizar y eliminar reacciones
-- ----------------------------------------------------------------------------

-- Política de LECTURA: Todos pueden leer reacciones (público)
DROP POLICY IF EXISTS "Reacciones son públicas para lectura" ON reacciones;
CREATE POLICY "Reacciones son públicas para lectura"
ON reacciones FOR SELECT
TO public
USING (true);

-- Política de CREACIÓN: Solo usuarios autenticados pueden crear reacciones
DROP POLICY IF EXISTS "Usuarios autenticados pueden crear reacciones" ON reacciones;
CREATE POLICY "Usuarios autenticados pueden crear reacciones"
ON reacciones FOR INSERT
TO authenticated
WITH CHECK (auth.uid() = user_id);

-- Política de ACTUALIZACIÓN: Solo el usuario puede actualizar sus propias reacciones
DROP POLICY IF EXISTS "Usuarios pueden actualizar sus propias reacciones" ON reacciones;
CREATE POLICY "Usuarios pueden actualizar sus propias reacciones"
ON reacciones FOR UPDATE
TO authenticated
USING (auth.uid() = user_id)
WITH CHECK (auth.uid() = user_id);

-- Política de ELIMINACIÓN: Solo el usuario puede eliminar sus propias reacciones
DROP POLICY IF EXISTS "Usuarios pueden eliminar sus propias reacciones" ON reacciones;
CREATE POLICY "Usuarios pueden eliminar sus propias reacciones"
ON reacciones FOR DELETE
TO authenticated
USING (auth.uid() = user_id);

-- ----------------------------------------------------------------------------
-- 6. FUNCIONES Y TRIGGERS (opcional)
-- Agregar timestamp automático y validaciones
-- ----------------------------------------------------------------------------

-- Crear timestamp automático para nuevos mensajes
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Aplicar trigger si existe columna updated_at en mensajes
-- DROP TRIGGER IF EXISTS update_mensajes_updated_at ON mensajes;
-- CREATE TRIGGER update_mensajes_updated_at
--     BEFORE UPDATE ON mensajes
--     FOR EACH ROW
--     EXECUTE FUNCTION update_updated_at_column();

-- ----------------------------------------------------------------------------
-- 7. VERIFICACIÓN DE CONFIGURACIÓN
-- Consultas para verificar que todo está configurado correctamente
-- ----------------------------------------------------------------------------

-- Verificar que RLS está habilitado
SELECT tablename, rowsecurity 
FROM pg_tables 
WHERE schemaname = 'public' 
AND tablename IN ('mensajes', 'reacciones');

-- Ver todas las políticas creadas
SELECT schemaname, tablename, policyname, permissive, roles, cmd, qual
FROM pg_policies
WHERE tablename IN ('mensajes', 'reacciones')
ORDER BY tablename, policyname;

-- ----------------------------------------------------------------------------
-- 8. CONFIGURACIÓN DE SUPABASE AUTH (desde el Dashboard)
-- Estos pasos debes realizarlos manualmente en Supabase Dashboard
-- ----------------------------------------------------------------------------

/*
1. Ir a Authentication > Settings en Supabase Dashboard
2. Configurar Email Auth:
   - Habilitar "Email" como provider
   - Configurar "Enable email confirmations" según prefieras
   - Configurar "Email templates" personalizados (opcional)

3. Configurar Site URL:
   - Site URL: https://tu-usuario.github.io/OurCorner
   - Redirect URLs: 
     * https://tu-usuario.github.io/OurCorner
     * https://tu-usuario.github.io/OurCorner/views/login.html

4. Configurar Email Templates (opcional):
   - Personalizar emails de confirmación
   - Personalizar emails de recuperación de contraseña

5. Para desarrollo local también agregar:
   - http://localhost:5500
   - http://127.0.0.1:5500

IMPORTANTE: Reemplaza "tu-usuario" con tu nombre de usuario de GitHub
*/

-- ----------------------------------------------------------------------------
-- 9. NOTAS ADICIONALES
-- ----------------------------------------------------------------------------

/*
SEGURIDAD:
- Nunca uses la service_role key en el frontend
- Solo usa la anon key (ya configurada en supabase.js)
- RLS protege automáticamente tus datos incluso si alguien usa la anon key

TESTING:
- Crea un usuario de prueba desde la aplicación
- Verifica que solo puedas editar/eliminar tus propios mensajes
- Verifica que puedas ver todos los mensajes públicos

MIGRACIÓN DE DATOS EXISTENTES:
Si tienes mensajes o reacciones sin user_id, puedes:
1. Asignarlos a un usuario específico:
   UPDATE mensajes SET user_id = 'UUID-DEL-USUARIO' WHERE user_id IS NULL;
   
2. O eliminarlos si son de prueba:
   DELETE FROM mensajes WHERE user_id IS NULL;
   DELETE FROM reacciones WHERE user_id IS NULL;
*/

-- ============================================================================
-- FIN DEL SCRIPT
-- ============================================================================
