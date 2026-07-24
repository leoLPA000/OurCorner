-- ============================================================================
-- FIX: RLS en tabla pizarras y notificaciones
-- Problema: la política INSERT hacía subquery a user_roles que tiene RLS
--           propio, causando conflicto de permisos (código 42501).
-- Solución: función SECURITY DEFINER que bypass RLS para chequear el rol.
-- ============================================================================

-- Función auxiliar: comprueba si el usuario actual es admin/super_admin
-- SECURITY DEFINER = corre como superuser, ignora RLS en user_roles
CREATE OR REPLACE FUNCTION public.current_user_is_admin()
RETURNS BOOLEAN
LANGUAGE SQL
SECURITY DEFINER
SET search_path = public
AS $$
    SELECT EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid()
          AND role IN ('admin', 'super_admin')
    );
$$;

-- ── Pizarras: reemplazar política INSERT ──
DROP POLICY IF EXISTS "pizarras_insert_admin" ON public.pizarras;

CREATE POLICY "pizarras_insert_admin" ON public.pizarras
    FOR INSERT TO authenticated
    WITH CHECK (
        auth.uid() = owner_id
        AND public.current_user_is_admin()
    );

-- ── Pizarras: reemplazar política SELECT (referenciaba notificaciones que puede no existir aún) ──
DROP POLICY IF EXISTS "pizarras_select" ON public.pizarras;

CREATE POLICY "pizarras_select" ON public.pizarras
    FOR SELECT TO authenticated
    USING (
        auth.uid() = owner_id
        OR EXISTS (
            SELECT 1 FROM public.notificaciones
            WHERE recipient_id = auth.uid()
              AND (payload->>'pizarra_id')::uuid = pizarras.id
        )
    );

-- ── Notificaciones: reemplazar política INSERT ──
DROP POLICY IF EXISTS "notif_insert_admin" ON public.notificaciones;

CREATE POLICY "notif_insert_admin" ON public.notificaciones
    FOR INSERT TO authenticated
    WITH CHECK (
        auth.uid() = sender_id
        AND public.current_user_is_admin()
    );
