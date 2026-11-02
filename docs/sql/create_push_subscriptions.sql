-- ============================================================================
-- MIGRACIÓN: create_push_subscriptions
-- Descripción: Tabla para almacenar suscripciones Web Push con RLS y cascada
-- Proyecto: OurCorner PWA
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.push_subscriptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    endpoint TEXT NOT NULL UNIQUE,
    p256dh TEXT NOT NULL,
    auth TEXT NOT NULL,
    user_agent TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

-- Índices de rendimiento
CREATE INDEX IF NOT EXISTS idx_push_subscriptions_user_id ON public.push_subscriptions(user_id);
CREATE INDEX IF NOT EXISTS idx_push_subscriptions_endpoint ON public.push_subscriptions(endpoint);

-- Habilitar Row Level Security (RLS)
ALTER TABLE public.push_subscriptions ENABLE ROW LEVEL SECURITY;

-- 1. Política SELECT: Los usuarios solo pueden ver sus propias suscripciones
CREATE POLICY "push_subscriptions_select_own"
    ON public.push_subscriptions
    FOR SELECT
    TO authenticated
    USING (auth.uid() = user_id);

-- 2. Política INSERT: Los usuarios solo pueden registrar suscripciones para su propio usuario
CREATE POLICY "push_subscriptions_insert_own"
    ON public.push_subscriptions
    FOR INSERT
    TO authenticated
    WITH CHECK (auth.uid() = user_id);

-- 3. Política UPDATE: Los usuarios solo pueden actualizar sus propias suscripciones
CREATE POLICY "push_subscriptions_update_own"
    ON public.push_subscriptions
    FOR UPDATE
    TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- 4. Política DELETE: Los usuarios solo pueden eliminar sus propias suscripciones
CREATE POLICY "push_subscriptions_delete_own"
    ON public.push_subscriptions
    FOR DELETE
    TO authenticated
    USING (auth.uid() = user_id);

-- Trigger para actualizar updated_at automáticamente
CREATE OR REPLACE FUNCTION public.handle_push_subscription_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = timezone('utc'::text, now());
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trigger_push_subscription_updated_at ON public.push_subscriptions;
CREATE TRIGGER trigger_push_subscription_updated_at
    BEFORE UPDATE ON public.push_subscriptions
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_push_subscription_updated_at();

COMMENT ON TABLE public.push_subscriptions IS 'Almacén de suscripciones Web Push para notificaciones móviles y de escritorio en OurCorner PWA';
