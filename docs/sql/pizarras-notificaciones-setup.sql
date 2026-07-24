-- ============================================================================
-- 🎨 PIZARRAS + 🔔 NOTIFICACIONES
-- Guardar dibujos en nube y sistema de notificaciones internas
-- Ejecutar en: Supabase Dashboard → SQL Editor
-- ============================================================================

-- ── TABLA: pizarras ──
CREATE TABLE IF NOT EXISTS public.pizarras (
    id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    owner_id        UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    titulo          TEXT DEFAULT 'Mi dibujo',
    board_data      JSONB NOT NULL,          -- { objects: [...], currentTheme: '...' }
    creado_en       TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    actualizado_en  TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_pizarras_owner   ON public.pizarras(owner_id);
CREATE INDEX IF NOT EXISTS idx_pizarras_created ON public.pizarras(creado_en DESC);

ALTER TABLE public.pizarras ENABLE ROW LEVEL SECURITY;

-- Dueño puede leer sus pizarras; receptor de una notificación también
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

-- Solo admin/super_admin pueden guardar
CREATE POLICY "pizarras_insert_admin" ON public.pizarras
    FOR INSERT TO authenticated
    WITH CHECK (
        auth.uid() = owner_id AND
        EXISTS (
            SELECT 1 FROM public.user_roles
            WHERE user_id = auth.uid() AND role IN ('admin', 'super_admin')
        )
    );

-- Dueño puede actualizar (para sobrescribir el mismo dibujo)
CREATE POLICY "pizarras_update_owner" ON public.pizarras
    FOR UPDATE TO authenticated
    USING (auth.uid() = owner_id)
    WITH CHECK (auth.uid() = owner_id);

-- Dueño puede borrar
CREATE POLICY "pizarras_delete_owner" ON public.pizarras
    FOR DELETE TO authenticated
    USING (auth.uid() = owner_id);

-- Auto-timestamp en actualización
CREATE OR REPLACE FUNCTION public.update_pizarras_timestamp()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN NEW.actualizado_en = NOW(); RETURN NEW; END;
$$;
DROP TRIGGER IF EXISTS trg_pizarras_timestamp ON public.pizarras;
CREATE TRIGGER trg_pizarras_timestamp
    BEFORE UPDATE ON public.pizarras
    FOR EACH ROW EXECUTE FUNCTION public.update_pizarras_timestamp();

-- ── TABLA: notificaciones ──
CREATE TABLE IF NOT EXISTS public.notificaciones (
    id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    recipient_id  UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    sender_id     UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    tipo          TEXT NOT NULL DEFAULT 'pizarra_compartida',
    payload       JSONB,                     -- { pizarra_id: '...' }
    leida         BOOLEAN DEFAULT FALSE,
    creado_en     TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_notif_recipient ON public.notificaciones(recipient_id);
CREATE INDEX IF NOT EXISTS idx_notif_leida     ON public.notificaciones(leida);
CREATE INDEX IF NOT EXISTS idx_notif_created   ON public.notificaciones(creado_en DESC);

ALTER TABLE public.notificaciones ENABLE ROW LEVEL SECURITY;

-- Receptor lee sus propias notificaciones
CREATE POLICY "notif_select_recipient" ON public.notificaciones
    FOR SELECT TO authenticated
    USING (auth.uid() = recipient_id);

-- Admin/super_admin pueden enviar notificaciones
CREATE POLICY "notif_insert_admin" ON public.notificaciones
    FOR INSERT TO authenticated
    WITH CHECK (
        auth.uid() = sender_id AND
        EXISTS (
            SELECT 1 FROM public.user_roles
            WHERE user_id = auth.uid() AND role IN ('admin', 'super_admin')
        )
    );

-- Receptor puede marcar como leída
CREATE POLICY "notif_update_recipient" ON public.notificaciones
    FOR UPDATE TO authenticated
    USING (auth.uid() = recipient_id)
    WITH CHECK (auth.uid() = recipient_id);

-- ── Habilitar Realtime (para notificaciones en vivo) ──
-- Ejecutar esto también en el Dashboard → Database → Replication
-- ALTER PUBLICATION supabase_realtime ADD TABLE public.notificaciones;
