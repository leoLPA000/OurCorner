-- ============================================================================
-- 🔄 MIGRACIÓN DE USUARIOS ANTIGUOS A user_roles
-- Solución para usuarios que existían antes de implementar el sistema de roles
-- ============================================================================

-- ============================================================================
-- 1. CREAR FUNCIÓN RPC PARA OBTENER TODOS LOS USUARIOS CON SUS ROLES
-- ============================================================================

-- Esta función combina auth.users con user_roles para mostrar TODOS los usuarios
-- incluyendo aquellos que no tienen entrada en user_roles
CREATE OR REPLACE FUNCTION public.get_all_users_with_roles()
RETURNS TABLE (
    id UUID,
    user_id UUID,
    email TEXT,
    role TEXT,
    created_at TIMESTAMPTZ,
    updated_at TIMESTAMPTZ,
    updated_by UUID
) 
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql
AS $$
BEGIN
    -- Verificar que quien ejecuta sea super_admin
    IF NOT EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role = 'super_admin'
    ) THEN
        RAISE EXCEPTION 'No tienes permisos para ver usuarios';
    END IF;

    -- Retornar todos los usuarios de auth.users con su rol correspondiente
    RETURN QUERY
    SELECT 
        COALESCE(ur.id, gen_random_uuid()) as id,
        u.id as user_id,
        u.email::TEXT as email,
        COALESCE(ur.role, 'invitado') as role,
        COALESCE(ur.created_at, u.created_at) as created_at,
        ur.updated_at,
        ur.updated_by
    FROM auth.users u
    LEFT JOIN public.user_roles ur ON ur.user_id = u.id
    ORDER BY COALESCE(ur.created_at, u.created_at) DESC;
END;
$$;

-- Dar permisos de ejecución a usuarios autenticados
GRANT EXECUTE ON FUNCTION public.get_all_users_with_roles() TO authenticated;

-- ============================================================================
-- 2. MIGRAR TODOS LOS USUARIOS EXISTENTES
-- ============================================================================

-- Insertar en user_roles todos los usuarios de auth.users que no tengan rol asignado
-- ⚠️ IMPORTANTE: NO toca usuarios que ya tienen rol (incluye super_admin)
INSERT INTO public.user_roles (user_id, email, role, created_at)
SELECT 
    u.id,
    u.email,
    'invitado', -- Por defecto los nuevos son invitados
    u.created_at
FROM auth.users u
LEFT JOIN public.user_roles ur ON ur.user_id = u.id
WHERE ur.user_id IS NULL -- ✅ Solo usuarios que NO tienen rol asignado
  AND u.email != 'leonardopenaanez@gmail.com' -- ✅ Protección extra: nunca tocar super admin
ON CONFLICT (user_id) DO NOTHING; -- ✅ Por si ya existe, no hacer nada

-- ============================================================================
-- 3. VERIFICAR LA MIGRACIÓN
-- ============================================================================

-- Ver cuántos usuarios hay en auth.users vs user_roles
SELECT 
    'Total usuarios en auth.users' as descripcion,
    COUNT(*) as cantidad
FROM auth.users
UNION ALL
SELECT 
    'Total usuarios con rol asignado' as descripcion,
    COUNT(*) as cantidad
FROM public.user_roles;

-- Ver todos los usuarios con sus roles
SELECT 
    u.email,
    u.created_at as fecha_registro,
    COALESCE(ur.role, '❌ SIN ROL') as rol_asignado
FROM auth.users u
LEFT JOIN public.user_roles ur ON ur.user_id = u.id
ORDER BY u.created_at DESC;

-- ============================================================================
-- 4. ASIGNAR ROLES MANUALMENTE (OPCIONAL)
-- ============================================================================

-- Ejemplo: Cambiar un usuario a admin
-- UPDATE public.user_roles 
-- SET role = 'admin', updated_at = NOW()
-- WHERE email = 'usuario@ejemplo.com';

-- Ejemplo: Cambiar un usuario a super_admin
-- UPDATE public.user_roles 
-- SET role = 'super_admin', updated_at = NOW()
-- WHERE email = 'tuusuario@ejemplo.com';

-- ============================================================================
-- NOTAS IMPORTANTES:
-- ============================================================================
-- 
-- ✅ Esta migración es segura y puede ejecutarse múltiples veces
-- ✅ La función RPC permite ver todos los usuarios desde el cliente
-- 🛡️ NO afecta al super admin ni a usuarios que ya tienen rol asignado
-- 🛡️ Usa tres capas de protección: WHERE IS NULL, AND email !=, ON CONFLICT
-- ✅ Los usuarios antiguos ahora aparecerán en el panel de super admin
-- ✅ Todos los usuarios migrados tendrán rol 'invitado' por defecto
-- 
-- 📋 INSTRUCCIONES:
-- 1. Ejecuta este script completo en el SQL Editor de Supabase
-- 2. Verifica que todos los usuarios aparezcan en la consulta final
-- 3. Actualiza manualmente los roles si es necesario
-- 4. Prueba el panel de super admin desde la aplicación
--
-- ============================================================================
