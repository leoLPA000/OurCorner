-- ============================================================================
-- AUTO-CLEANUP: pizarras y notificaciones
-- Lógica: el contador de 6 días empieza desde que se LEYÓ la notificación.
-- Pasos:
--   1. Agregar columna leida_en a notificaciones
--   2. Trigger que la llena automáticamente al marcar como leída
--   3. pg_cron que corre cada noche y borra lo viejo
-- ============================================================================

-- ── 1. Columna que guarda cuándo se leyó la notificación ──
ALTER TABLE public.notificaciones
    ADD COLUMN IF NOT EXISTS leida_en TIMESTAMP WITH TIME ZONE;

-- ── 2. Trigger: al poner leida = true, guarda la hora exacta ──
CREATE OR REPLACE FUNCTION public.set_notif_leida_en()
RETURNS TRIGGER
LANGUAGE plpgsql AS $$
BEGIN
    IF NEW.leida = true AND (OLD.leida = false OR OLD.leida IS NULL) THEN
        NEW.leida_en = NOW();
    END IF;
    RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS trg_notif_leida_en ON public.notificaciones;
CREATE TRIGGER trg_notif_leida_en
    BEFORE UPDATE ON public.notificaciones
    FOR EACH ROW EXECUTE FUNCTION public.set_notif_leida_en();

-- ── 3. Habilitar pg_cron (solo si no está habilitado ya) ──
-- Ir a: Supabase Dashboard → Database → Extensions → buscar "pg_cron" → Enable

-- ── 4. Job diario: borrar notificaciones leídas hace más de 6 días ──
SELECT cron.schedule(
    'cleanup-notificaciones-leidas',   -- nombre del job (único)
    '0 3 * * *',                       -- cada día a las 3am UTC
    $$
        DELETE FROM public.notificaciones
        WHERE leida = true
          AND leida_en < NOW() - INTERVAL '6 days';
    $$
);

-- ── 5. Job diario: borrar pizarras huérfanas ──
-- Una pizarra se borra cuando ya no tiene ninguna notificación activa
-- (todas fueron leídas y eliminadas) Y tiene más de 6 días de creada.
SELECT cron.schedule(
    'cleanup-pizarras-huerfanas',
    '0 3 * * *',
    $$
        DELETE FROM public.pizarras p
        WHERE
            -- No tiene notificaciones activas apuntando a ella
            NOT EXISTS (
                SELECT 1 FROM public.notificaciones n
                WHERE (n.payload->>'pizarra_id')::uuid = p.id
            )
            -- Y tiene más de 6 días (margen de seguridad para pizarras recién guardadas)
            AND p.creado_en < NOW() - INTERVAL '6 days';
    $$
);

-- ── Verificar jobs creados ──
-- SELECT * FROM cron.job;

-- ── Para eliminar un job si necesitas cambiar algo ──
-- SELECT cron.unschedule('cleanup-notificaciones-leidas');
-- SELECT cron.unschedule('cleanup-pizarras-huerfanas');
