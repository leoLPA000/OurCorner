-- ============================================================================
-- 🔐 VERIFICAR Y ARREGLAR ROL DE LEONARDO
-- ============================================================================

-- 1. VERIFICAR QUÉ USUARIOS EXISTEN EN auth.users
SELECT id, email FROM auth.users ORDER BY created_at;

-- ============================================================================
-- 2. VER TABLA DE ROLES ACTUAL
-- ============================================================================

SELECT id, user_id, email, role, created_at FROM public.user_roles ORDER BY created_at;

-- ============================================================================
-- 3. ARREGLAR: Asignar super_admin a Leonardo
-- ============================================================================
-- Si Leonardo existe en auth.users con email leonardopenaanez@gmail.com,
-- ejecuta esto para asignarlo como super_admin:

UPDATE public.user_roles 
SET role = 'super_admin', updated_at = NOW()
WHERE email = 'leonardopenaanez@gmail.com';

-- Si el UPDATE no afectó filas, insertar nuevo registro
INSERT INTO public.user_roles (user_id, email, role)
SELECT id, email, 'super_admin'
FROM auth.users
WHERE email = 'leonardopenaanez@gmail.com'
ON CONFLICT (user_id) DO UPDATE
SET role = 'super_admin', updated_at = NOW();

-- ============================================================================
-- 4. VERIFICAR QUE SE APLICÓ CORRECTAMENTE
-- ============================================================================

SELECT user_id, email, role FROM public.user_roles WHERE email = 'leonardopenaanez@gmail.com';
