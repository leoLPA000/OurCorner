-- ============================================================================
-- 📅 CALENDARIO DE EVENTOS
-- Guarda eventos del calendario con sincronización entre usuarios
-- Ejecutar en: Supabase Dashboard → SQL Editor
-- ============================================================================

-- ── TABLA: calendario_eventos ──
CREATE TABLE IF NOT EXISTS public.calendario_eventos (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id        UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    fecha           DATE NOT NULL,
    tipo            TEXT DEFAULT 'poema',
    titulo          TEXT,
    contenido       TEXT,
    music_url       TEXT,
    tagged_user_id  UUID REFERENCES auth.users(id) ON DELETE SET NULL,
    creado_en       TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_cal_owner   ON public.calendario_eventos(owner_id);
CREATE INDEX IF NOT EXISTS idx_cal_tagged  ON public.calendario_eventos(tagged_user_id);
CREATE INDEX IF NOT EXISTS idx_cal_fecha   ON public.calendario_eventos(fecha);

ALTER TABLE public.calendario_eventos ENABLE ROW LEVEL SECURITY;

-- Dueño y usuario etiquetado pueden leer
CREATE POLICY "cal_select" ON public.calendario_eventos
    FOR SELECT TO authenticated
    USING (auth.uid() = owner_id OR auth.uid() = tagged_user_id);

-- Solo admin/super_admin pueden crear eventos
CREATE POLICY "cal_insert" ON public.calendario_eventos
    FOR INSERT TO authenticated
    WITH CHECK (
        auth.uid() = owner_id
        AND public.current_user_is_admin()
    );

-- Solo admin/super_admin dueño puede actualizar
CREATE POLICY "cal_update_owner" ON public.calendario_eventos
    FOR UPDATE TO authenticated
    USING (auth.uid() = owner_id AND public.current_user_is_admin())
    WITH CHECK (auth.uid() = owner_id AND public.current_user_is_admin());

-- Solo admin/super_admin dueño puede eliminar
CREATE POLICY "cal_delete_owner" ON public.calendario_eventos
    FOR DELETE TO authenticated
    USING (auth.uid() = owner_id AND public.current_user_is_admin());

-- ── ACTUALIZAR políticas de notificaciones ──
-- Separar pizarra (solo admin) de calendario (cualquier usuario autenticado)

DROP POLICY IF EXISTS "notif_insert_admin" ON public.notificaciones;

CREATE POLICY "notif_insert_pizarra" ON public.notificaciones
    FOR INSERT TO authenticated
    WITH CHECK (
        auth.uid() = sender_id
        AND tipo = 'pizarra_compartida'
        AND public.current_user_is_admin()
    );

CREATE POLICY "notif_insert_calendario" ON public.notificaciones
    FOR INSERT TO authenticated
    WITH CHECK (
        auth.uid() = sender_id
        AND tipo = 'calendario_invitacion'
    );
