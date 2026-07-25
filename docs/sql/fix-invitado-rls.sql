-- ============================================================================
-- FIX: Restringir usuarios "invitado" a solo lectura en Supabase
-- Los invitados no deben poder escribir NADA en la base de datos.
-- Ejecutar en: Supabase Dashboard → SQL Editor
-- ============================================================================

-- ── notificaciones: eliminar política que permitía insertar a cualquier usuario ──
-- La función current_user_is_admin() ya existe (creada en fix-pizarras-rls.sql)
DROP POLICY IF EXISTS "notif_insert_calendario" ON public.notificaciones;

CREATE POLICY "notif_insert_calendario" ON public.notificaciones
    FOR INSERT TO authenticated
    WITH CHECK (
        auth.uid() = sender_id
        AND tipo = 'calendario_invitacion'
        AND public.current_user_is_admin()
    );

-- ── notificaciones: UPDATE (marcar como leída) ──
-- Solo el destinatario puede marcar sus propias notificaciones como leídas.
-- Esto ya debería existir, pero lo reafirmamos explícitamente.
DROP POLICY IF EXISTS "notif_update_recipient" ON public.notificaciones;

CREATE POLICY "notif_update_recipient" ON public.notificaciones
    FOR UPDATE TO authenticated
    USING (auth.uid() = recipient_id)
    WITH CHECK (auth.uid() = recipient_id);

-- ── notificaciones: DELETE ──
-- Nadie puede eliminar notificaciones desde el frontend (solo pg_cron).
DROP POLICY IF EXISTS "notif_delete" ON public.notificaciones;

-- ── calendario_eventos: confirmar que INSERT sigue siendo solo admin ──
-- (ya fue creado en calendario-eventos-setup.sql, pero lo reafirmamos)
DROP POLICY IF EXISTS "cal_insert" ON public.calendario_eventos;

CREATE POLICY "cal_insert" ON public.calendario_eventos
    FOR INSERT TO authenticated
    WITH CHECK (
        auth.uid() = owner_id
        AND public.current_user_is_admin()
    );

-- ── calendario_eventos: UPDATE solo para admin/dueño ──
DROP POLICY IF EXISTS "cal_update_owner" ON public.calendario_eventos;

CREATE POLICY "cal_update_owner" ON public.calendario_eventos
    FOR UPDATE TO authenticated
    USING (auth.uid() = owner_id AND public.current_user_is_admin())
    WITH CHECK (auth.uid() = owner_id AND public.current_user_is_admin());

-- ── calendario_eventos: DELETE solo para admin/dueño ──
DROP POLICY IF EXISTS "cal_delete_owner" ON public.calendario_eventos;

CREATE POLICY "cal_delete_owner" ON public.calendario_eventos
    FOR DELETE TO authenticated
    USING (auth.uid() = owner_id AND public.current_user_is_admin());

-- ── pizarras: DELETE solo para admin/dueño ──
-- (protección extra por si no estaba definida)
DROP POLICY IF EXISTS "pizarras_delete_owner" ON public.pizarras;

CREATE POLICY "pizarras_delete_owner" ON public.pizarras
    FOR DELETE TO authenticated
    USING (auth.uid() = owner_id AND public.current_user_is_admin());

-- ── Verificar políticas activas ──
-- SELECT schemaname, tablename, policyname, cmd, qual
-- FROM pg_policies
-- WHERE schemaname = 'public'
-- ORDER BY tablename, cmd;
