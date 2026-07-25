-- Política UPDATE faltante en calendario_eventos
-- Solo el dueño admin puede modificar su propio evento
CREATE POLICY "cal_update_owner" ON public.calendario_eventos
    FOR UPDATE TO authenticated
    USING (auth.uid() = owner_id AND public.current_user_is_admin())
    WITH CHECK (auth.uid() = owner_id AND public.current_user_is_admin());
