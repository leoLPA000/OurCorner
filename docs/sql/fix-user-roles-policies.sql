-- ============================================================================
-- 🔐 ARREGLAR POLÍTICAS RLS DE user_roles - QUITAR CIRCULARES
-- ============================================================================

-- Eliminar las políticas problemáticas
DROP POLICY IF EXISTS "Usuario puede ver su propio rol" ON public.user_roles;
DROP POLICY IF EXISTS "Super admin puede ver todos los roles" ON public.user_roles;
DROP POLICY IF EXISTS "Super admin puede crear roles" ON public.user_roles;
DROP POLICY IF EXISTS "Super admin puede actualizar roles" ON public.user_roles;
DROP POLICY IF EXISTS "Super admin puede eliminar roles" ON public.user_roles;

-- ============================================================================
-- CREAR POLÍTICAS SIMPLES Y SIN CIRCULARIDAD
-- ============================================================================

-- 1. SELECT: Los usuarios autenticados pueden LEER la tabla (necesario para verificar su rol)
CREATE POLICY "Autenticados pueden leer user_roles"
ON public.user_roles FOR SELECT
TO authenticated
USING (true);

-- 2. INSERT: Solo super_admin pueden crear roles (se crea automáticamente vía trigger normalmente)
CREATE POLICY "Super admin puede crear roles"
ON public.user_roles FOR INSERT
WITH CHECK (
    (SELECT role FROM public.user_roles WHERE user_id = auth.uid() LIMIT 1) = 'super_admin'
);

-- 3. UPDATE: Solo super_admin pueden actualizar roles
CREATE POLICY "Super admin puede actualizar roles"
ON public.user_roles FOR UPDATE
USING (
    (SELECT role FROM public.user_roles WHERE user_id = auth.uid() LIMIT 1) = 'super_admin'
)
WITH CHECK (
    (SELECT role FROM public.user_roles WHERE user_id = auth.uid() LIMIT 1) = 'super_admin'
);

-- 4. DELETE: Solo super_admin pueden eliminar roles
CREATE POLICY "Super admin puede eliminar roles"
ON public.user_roles FOR DELETE
USING (
    (SELECT role FROM public.user_roles WHERE user_id = auth.uid() LIMIT 1) = 'super_admin'
);

-- ============================================================================
-- ✅ FIN - Políticas corregidas sin circularidad
-- ============================================================================
