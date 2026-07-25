-- ============================================================================
-- FIX: Cerrar escrituras abiertas a invitados
-- Problema: múltiples políticas INSERT conflictivas se aplican con OR,
--           las permisivas anulan las restrictivas.
-- Solución: eliminar las permisivas, dejar solo las que exigen admin.
-- Ejecutar en: Supabase Dashboard → SQL Editor
-- ============================================================================

-- ── MENSAJES ──
-- Problema: "INSERT autenticado" y "Usuarios autenticados pueden crear" anulan "Solo admins"
DROP POLICY IF EXISTS "Mensajes - INSERT autenticado"             ON public.mensajes;
DROP POLICY IF EXISTS "Usuarios autenticados pueden crear mensajes" ON public.mensajes;
-- Dejar solo: "Solo admins pueden insertar mensajes"

-- Problema: cualquier usuario puede actualizar/eliminar sus propios mensajes
DROP POLICY IF EXISTS "Usuarios pueden actualizar sus propios mensajes" ON public.mensajes;
DROP POLICY IF EXISTS "Usuarios pueden eliminar sus propios mensajes"   ON public.mensajes;
-- Dejar solo las de admins para UPDATE/DELETE

-- ── CANCIONES ──
-- Problema: "Canciones - INSERT autenticado" anula "Solo admins pueden insertar"
DROP POLICY IF EXISTS "Canciones - INSERT autenticado" ON public.canciones;
-- Dejar solo: "Solo admins pueden insertar canciones"

-- ── REACCIONES ──
-- Cualquier usuario puede hacer INSERT/UPDATE/DELETE — cerrar todo
DROP POLICY IF EXISTS "Reacciones - INSERT autenticado"                  ON public.reacciones;
DROP POLICY IF EXISTS "Usuarios autenticados pueden crear reacciones"    ON public.reacciones;
DROP POLICY IF EXISTS "Usuarios pueden actualizar sus propias reacciones" ON public.reacciones;
DROP POLICY IF EXISTS "Usuarios pueden eliminar sus propias reacciones"  ON public.reacciones;

CREATE POLICY "reacciones_insert_admin" ON public.reacciones
    FOR INSERT TO authenticated
    WITH CHECK (public.current_user_is_admin());

CREATE POLICY "reacciones_update_admin" ON public.reacciones
    FOR UPDATE TO authenticated
    USING (public.current_user_is_admin());

CREATE POLICY "reacciones_delete_admin" ON public.reacciones
    FOR DELETE TO authenticated
    USING (public.current_user_is_admin());

-- ── CARD_LOGS ──
DROP POLICY IF EXISTS "Card logs - INSERT autenticado" ON public.card_logs;

CREATE POLICY "card_logs_insert_admin" ON public.card_logs
    FOR INSERT TO authenticated
    WITH CHECK (public.current_user_is_admin());

-- ── CARDS ──
DROP POLICY IF EXISTS "Cards - INSERT autenticado" ON public.cards;

CREATE POLICY "cards_insert_admin" ON public.cards
    FOR INSERT TO authenticated
    WITH CHECK (public.current_user_is_admin());

-- ── SHARED_CARDS ──
DROP POLICY IF EXISTS "Shared cards - INSERT autenticado" ON public.shared_cards;

CREATE POLICY "shared_cards_insert_admin" ON public.shared_cards
    FOR INSERT TO authenticated
    WITH CHECK (public.current_user_is_admin());

-- ── PIZARRAS: cerrar UPDATE a no-admins ──
-- Actualmente "pizarras_update_owner" no exige admin
DROP POLICY IF EXISTS "pizarras_update_owner" ON public.pizarras;

CREATE POLICY "pizarras_update_owner" ON public.pizarras
    FOR UPDATE TO authenticated
    USING (auth.uid() = owner_id AND public.current_user_is_admin())
    WITH CHECK (auth.uid() = owner_id AND public.current_user_is_admin());

-- ── Verificar resultado ──
-- SELECT tablename, policyname, cmd, qual
-- FROM pg_policies
-- WHERE schemaname = 'public'
-- ORDER BY tablename, cmd;
