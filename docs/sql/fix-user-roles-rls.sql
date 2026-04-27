-- ============================================================================
-- 🔐 ARREGLAR RLS EN TABLA user_roles - SOLUCIÓN CRÍTICA DE SEGURIDAD
-- Problema: "Mesa de acceso público" - RLS deshabilitado en user_roles
-- ============================================================================

-- 1. ELIMINAR POLÍTICAS EXISTENTES INCOMPLETAS
DROP POLICY IF EXISTS "Los usuarios pueden ver su propio rol" ON public.user_roles;
DROP POLICY IF EXISTS "Super admins pueden ver todos los roles" ON public.user_roles;
DROP POLICY IF EXISTS "Solo super admins pueden actualizar roles" ON public.user_roles;
DROP POLICY IF EXISTS "Solo super admins pueden eliminar roles" ON public.user_roles;

-- 2. HABILITAR ROW LEVEL SECURITY (CRÍTICO)
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

-- 3. CREAR POLÍTICAS RLS SEGURAS PARA user_roles

-- ✅ POLÍTICA DE LECTURA 1: Cualquiera puede leer su propio rol
CREATE POLICY "Usuario puede ver su propio rol"
ON public.user_roles FOR SELECT
USING (auth.uid() = user_id);

-- ✅ POLÍTICA DE LECTURA 2: Super admins pueden ver todos los roles
CREATE POLICY "Super admin puede ver todos los roles"
ON public.user_roles FOR SELECT
USING (
    EXISTS (
        SELECT 1 FROM public.user_roles ur
        WHERE ur.user_id = auth.uid() AND ur.role = 'super_admin'
    )
);

-- ✅ POLÍTICA DE INSERCIÓN: Solo super admins pueden crear roles
CREATE POLICY "Super admin puede crear roles"
ON public.user_roles FOR INSERT
WITH CHECK (
    EXISTS (
        SELECT 1 FROM public.user_roles ur
        WHERE ur.user_id = auth.uid() AND ur.role = 'super_admin'
    )
);

-- ✅ POLÍTICA DE ACTUALIZACIÓN: Solo super admins pueden actualizar roles
CREATE POLICY "Super admin puede actualizar roles"
ON public.user_roles FOR UPDATE
USING (
    EXISTS (
        SELECT 1 FROM public.user_roles ur
        WHERE ur.user_id = auth.uid() AND ur.role = 'super_admin'
    )
)
WITH CHECK (
    EXISTS (
        SELECT 1 FROM public.user_roles ur
        WHERE ur.user_id = auth.uid() AND ur.role = 'super_admin'
    )
);

-- ✅ POLÍTICA DE ELIMINACIÓN: Solo super admins pueden eliminar roles
CREATE POLICY "Super admin puede eliminar roles"
ON public.user_roles FOR DELETE
USING (
    EXISTS (
        SELECT 1 FROM public.user_roles ur
        WHERE ur.user_id = auth.uid() AND ur.role = 'super_admin'
    )
);

-- 4. OTORGAR PERMISOS NECESARIOS
GRANT SELECT ON public.user_roles TO authenticated;
GRANT INSERT ON public.user_roles TO authenticated;
GRANT UPDATE ON public.user_roles TO authenticated;
GRANT DELETE ON public.user_roles TO authenticated;

-- ============================================================================
-- VERIFICAR QUE RLS ESTÁ HABILITADO
-- ============================================================================
-- Ejecuta esto después para verificar:
-- SELECT tablename, rowsecurity FROM pg_tables WHERE tablename = 'user_roles';
-- Debe mostrar: user_roles | t (true)
