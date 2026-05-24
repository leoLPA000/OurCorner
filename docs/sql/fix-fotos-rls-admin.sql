-- ============================================================================
-- 🔐 CORREGIR POLÍTICAS RLS DE TABLA FOTOS
-- Solo administradores y superadmins pueden subir fotos
-- ============================================================================

-- Eliminar TODAS las políticas actuales (antiguas y nuevas si existen)
DROP POLICY IF EXISTS "fotos_select_all" ON public.fotos;
DROP POLICY IF EXISTS "fotos_select_owner" ON public.fotos;
DROP POLICY IF EXISTS "fotos_insert_auth" ON public.fotos;
DROP POLICY IF EXISTS "fotos_update_owner" ON public.fotos;
DROP POLICY IF EXISTS "fotos_delete_owner" ON public.fotos;

-- Eliminar las políticas antiguas de fix-rls-final.sql si existen
DROP POLICY IF EXISTS "Fotos - SELECT público" ON public.fotos;
DROP POLICY IF EXISTS "Fotos - INSERT autenticado" ON public.fotos;

-- Eliminar las políticas con nombres en español (si existen)
DROP POLICY IF EXISTS "Solo admins pueden actualizar fotos" ON public.fotos;
DROP POLICY IF EXISTS "Solo admins pueden eliminar fotos" ON public.fotos;
DROP POLICY IF EXISTS "Solo admins pueden insertar fotos" ON public.fotos;
DROP POLICY IF EXISTS "Todos pueden leer fotos" ON public.fotos;

-- Eliminar las nuevas políticas si ya existen
DROP POLICY IF EXISTS "fotos_delete_admin" ON public.fotos;
DROP POLICY IF EXISTS "fotos_insert_admin" ON public.fotos;
DROP POLICY IF EXISTS "fotos_select_admin" ON public.fotos;
DROP POLICY IF EXISTS "fotos_select_public" ON public.fotos;
DROP POLICY IF EXISTS "fotos_update_admin" ON public.fotos;

-- ============================================================================
-- NUEVAS POLÍTICAS - SOLO ADMIN/SUPERADMIN PUEDEN CREAR/EDITAR/ELIMINAR
-- ============================================================================

-- 1️⃣ SELECT: Todos pueden leer fotos públicas
CREATE POLICY "fotos_select_public" ON public.fotos
    FOR SELECT
    USING (publico = true);

-- 2️⃣ SELECT: Admins pueden ver todas las fotos (incluso las no públicas)
CREATE POLICY "fotos_select_admin" ON public.fotos
    FOR SELECT
    TO authenticated
    USING (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    ));

-- 3️⃣ INSERT: Solo admin/superadmin pueden insertar fotos
CREATE POLICY "fotos_insert_admin" ON public.fotos
    FOR INSERT
    TO authenticated
    WITH CHECK (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    ));

-- 4️⃣ UPDATE: Solo admin/superadmin pueden actualizar fotos
CREATE POLICY "fotos_update_admin" ON public.fotos
    FOR UPDATE
    TO authenticated
    USING (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    ))
    WITH CHECK (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    ));

-- 5️⃣ DELETE: Solo admin/superadmin pueden eliminar fotos
CREATE POLICY "fotos_delete_admin" ON public.fotos
    FOR DELETE
    TO authenticated
    USING (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    ));

-- ============================================================================
-- VERIFICACIÓN
-- ============================================================================
-- Ver todas las políticas de la tabla fotos
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual
FROM pg_policies
WHERE tablename = 'fotos'
ORDER BY policyname;

-- ============================================================================
-- 📝 NOTAS DE APLICACIÓN
-- ============================================================================
/*
1. Ejecuta este script en la consola SQL de Supabase
2. Las nuevas políticas solo permiten admin/superadmin subir fotos
3. Todos pueden ver fotos públicas (publico = true)
4. Los admins pueden ver y gestionar todas las fotos
5. El campo 'owner' seguirá registrándose pero no será usada para control de acceso
6. Para deshacer: Ver comentarios al inicio (DROP POLICY)

IMPORTANTE:
- Asegúrate de que hay al menos un usuario marcado como 'super_admin' en user_roles
- Los usuarios regulares no podrán subir fotos después de esto
- Solo admins y superadmins verán el botón de "Agregar foto" en el frontend
*/
