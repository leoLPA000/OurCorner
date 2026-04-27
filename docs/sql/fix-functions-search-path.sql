-- ============================================================================
-- 🔐 ARREGLAR FUNCIONES SIN search_path
-- Problema: Functions Search Path Mutable
-- ============================================================================

-- 1. ARREGLAR handle_new_user_role
CREATE OR REPLACE FUNCTION public.handle_new_user_role()
RETURNS TRIGGER 
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO public.user_roles (user_id, email, role)
    VALUES (NEW.id, NEW.email, 'invitado');
    RETURN NEW;
END;
$$;

-- 2. ARREGLAR get_user_role
CREATE OR REPLACE FUNCTION public.get_user_role(user_id_param UUID)
RETURNS TEXT 
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql AS $$
DECLARE
    user_role TEXT;
BEGIN
    SELECT role INTO user_role
    FROM public.user_roles
    WHERE user_id = user_id_param;
    
    RETURN COALESCE(user_role, 'invitado');
END;
$$;

-- 3. ARREGLAR user_has_role
CREATE OR REPLACE FUNCTION public.user_has_role(required_role TEXT)
RETURNS BOOLEAN 
SECURITY DEFINER
SET search_path = public
LANGUAGE plpgsql AS $$
DECLARE
    current_role TEXT;
BEGIN
    SELECT role INTO current_role
    FROM public.user_roles
    WHERE user_id = auth.uid();
    
    IF current_role = 'super_admin' THEN
        RETURN TRUE;
    END IF;
    
    IF current_role = 'admin' AND required_role IN ('admin', 'invitado') THEN
        RETURN TRUE;
    END IF;
    
    IF current_role = 'invitado' AND required_role = 'invitado' THEN
        RETURN TRUE;
    END IF;
    
    RETURN FALSE;
END;
$$;

-- 4. ARREGLAR reacciones_conteo (si existe)
-- Si esta función existe, necesitaremos revisarla manualmente

-- ============================================================================
-- VERIFICAR QUE SE APLICARON LOS CAMBIOS
-- ============================================================================
-- SELECT proname, prosecdef, proconfig FROM pg_proc 
-- WHERE proname IN ('handle_new_user_role', 'get_user_role', 'user_has_role');
