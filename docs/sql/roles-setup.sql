-- ============================================================================
-- 🔐 SISTEMA DE ROLES Y PERMISOS
-- Implementación de 3 niveles: super_admin, admin, invitado
-- ============================================================================

-- ============================================================================
-- 1. CREAR TABLA DE ROLES DE USUARIO
-- ============================================================================

CREATE TABLE IF NOT EXISTS public.user_roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    email TEXT NOT NULL,
    role TEXT NOT NULL DEFAULT 'invitado',
    created_at TIMESTAMPTZ DEFAULT NOW(),
    updated_at TIMESTAMPTZ DEFAULT NOW(),
    updated_by UUID REFERENCES auth.users(id),
    UNIQUE(user_id),
    UNIQUE(email),
    CONSTRAINT valid_role CHECK (role IN ('super_admin', 'admin', 'invitado'))
);

-- Índices para mejor rendimiento
CREATE INDEX IF NOT EXISTS idx_user_roles_user_id ON public.user_roles(user_id);
CREATE INDEX IF NOT EXISTS idx_user_roles_email ON public.user_roles(email);
CREATE INDEX IF NOT EXISTS idx_user_roles_role ON public.user_roles(role);

-- ============================================================================
-- 2. FUNCIÓN PARA ASIGNAR ROL AUTOMÁTICAMENTE AL REGISTRARSE
-- ============================================================================

-- Función que se ejecuta cuando un nuevo usuario se registra
CREATE OR REPLACE FUNCTION public.handle_new_user_role()
RETURNS TRIGGER AS $$
BEGIN
    -- Por defecto, todos los nuevos usuarios son 'invitado'
    INSERT INTO public.user_roles (user_id, email, role)
    VALUES (NEW.id, NEW.email, 'invitado');
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger que ejecuta la función al crear un usuario
DROP TRIGGER IF EXISTS on_auth_user_created_role ON auth.users;
CREATE TRIGGER on_auth_user_created_role
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_user_role();

-- ============================================================================
-- 3. ASIGNAR SUPER_ADMIN AL USUARIO PRINCIPAL
-- ============================================================================

-- Primero, verificar si el usuario ya tiene un rol asignado
-- Si no, insertarlo. Si ya existe, actualizarlo a super_admin

DO $$
BEGIN
    -- Insertar o actualizar rol de super_admin para leonardopenaanez@gmail.com
    INSERT INTO public.user_roles (user_id, email, role)
    SELECT id, email, 'super_admin'
    FROM auth.users
    WHERE email = 'leonardopenaanez@gmail.com'
    ON CONFLICT (email) 
    DO UPDATE SET role = 'super_admin', updated_at = NOW();
    
    RAISE NOTICE 'Super admin asignado exitosamente';
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error al asignar super admin: %', SQLERRM;
END $$;

-- ============================================================================
-- 4. CREAR POLÍTICAS RLS PARA LA TABLA user_roles
-- ============================================================================

-- Habilitar RLS
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

-- Política: Todos pueden ver su propio rol
CREATE POLICY "Los usuarios pueden ver su propio rol"
ON public.user_roles FOR SELECT
TO authenticated
USING (auth.uid() = user_id);

-- Política: Super admins pueden ver todos los roles
CREATE POLICY "Super admins pueden ver todos los roles"
ON public.user_roles FOR SELECT
TO authenticated
USING (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role = 'super_admin'
    )
);

-- Política: Solo super admins pueden actualizar roles
CREATE POLICY "Solo super admins pueden actualizar roles"
ON public.user_roles FOR UPDATE
TO authenticated
USING (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role = 'super_admin'
    )
)
WITH CHECK (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role = 'super_admin'
    )
);

-- Política: Solo super admins pueden eliminar roles
CREATE POLICY "Solo super admins pueden eliminar roles"
ON public.user_roles FOR DELETE
TO authenticated
USING (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role = 'super_admin'
    )
);

-- ============================================================================
-- 5. FUNCIÓN HELPER PARA VERIFICAR ROL
-- ============================================================================

-- Función para obtener el rol de un usuario
CREATE OR REPLACE FUNCTION public.get_user_role(user_id_param UUID)
RETURNS TEXT AS $$
DECLARE
    user_role TEXT;
BEGIN
    SELECT role INTO user_role
    FROM public.user_roles
    WHERE user_id = user_id_param;
    
    RETURN COALESCE(user_role, 'invitado');
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Función para verificar si usuario tiene permiso
CREATE OR REPLACE FUNCTION public.user_has_role(required_role TEXT)
RETURNS BOOLEAN AS $$
DECLARE
    current_role TEXT;
BEGIN
    SELECT role INTO current_role
    FROM public.user_roles
    WHERE user_id = auth.uid();
    
    -- Super admin tiene acceso a todo
    IF current_role = 'super_admin' THEN
        RETURN TRUE;
    END IF;
    
    -- Admin tiene acceso si se requiere admin o invitado
    IF current_role = 'admin' AND required_role IN ('admin', 'invitado') THEN
        RETURN TRUE;
    END IF;
    
    -- Invitado solo tiene acceso si se requiere invitado
    IF current_role = 'invitado' AND required_role = 'invitado' THEN
        RETURN TRUE;
    END IF;
    
    RETURN FALSE;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- ============================================================================
-- 6. ACTUALIZAR POLÍTICAS DE TABLAS EXISTENTES CON ROLES
-- ============================================================================

-- EJEMPLO: Restringir INSERT en mensajes solo a admin y super_admin
-- (Elimina la política antigua si existe)
DROP POLICY IF EXISTS "Usuarios autenticados pueden insertar mensajes" ON public.mensajes;

CREATE POLICY "Solo admins pueden insertar mensajes"
ON public.mensajes FOR INSERT
TO authenticated
WITH CHECK (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    )
);

-- EJEMPLO: Restringir UPDATE en mensajes solo a admin y super_admin
DROP POLICY IF EXISTS "Usuarios autenticados pueden actualizar mensajes" ON public.mensajes;

CREATE POLICY "Solo admins pueden actualizar mensajes"
ON public.mensajes FOR UPDATE
TO authenticated
USING (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    )
);

-- EJEMPLO: Restringir DELETE en mensajes solo a admin y super_admin
DROP POLICY IF EXISTS "Usuarios autenticados pueden eliminar mensajes" ON public.mensajes;

CREATE POLICY "Solo admins pueden eliminar mensajes"
ON public.mensajes FOR DELETE
TO authenticated
USING (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    )
);

-- Política: Todos (incluso invitados) pueden leer mensajes
CREATE POLICY "Todos pueden leer mensajes"
ON public.mensajes FOR SELECT
TO authenticated
USING (true);

-- ============================================================================
-- 7. APLICAR ROLES A CANCIONES
-- ============================================================================

-- Solo admins pueden insertar canciones
DROP POLICY IF EXISTS "Usuarios autenticados pueden insertar canciones" ON public.canciones;

CREATE POLICY "Solo admins pueden insertar canciones"
ON public.canciones FOR INSERT
TO authenticated
WITH CHECK (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    )
);

-- Solo admins pueden actualizar canciones
CREATE POLICY "Solo admins pueden actualizar canciones"
ON public.canciones FOR UPDATE
TO authenticated
USING (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    )
);

-- Solo admins pueden eliminar canciones
CREATE POLICY "Solo admins pueden eliminar canciones"
ON public.canciones FOR DELETE
TO authenticated
USING (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    )
);

-- Todos pueden leer canciones
CREATE POLICY "Todos pueden leer canciones"
ON public.canciones FOR SELECT
TO authenticated
USING (true);

-- ============================================================================
-- 8. APLICAR ROLES A FOTOS
-- ============================================================================

-- Solo admins pueden insertar fotos
DROP POLICY IF EXISTS "Usuarios autenticados pueden insertar fotos" ON public.fotos;

CREATE POLICY "Solo admins pueden insertar fotos"
ON public.fotos FOR INSERT
TO authenticated
WITH CHECK (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    )
);

-- Solo admins pueden actualizar fotos
CREATE POLICY "Solo admins pueden actualizar fotos"
ON public.fotos FOR UPDATE
TO authenticated
USING (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    )
);

-- Solo admins pueden eliminar fotos
CREATE POLICY "Solo admins pueden eliminar fotos"
ON public.fotos FOR DELETE
TO authenticated
USING (
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    )
);

-- Todos pueden leer fotos
CREATE POLICY "Todos pueden leer fotos"
ON public.fotos FOR SELECT
TO authenticated
USING (true);

-- ============================================================================
-- 9. VERIFICAR INSTALACIÓN
-- ============================================================================

-- Ver todos los roles asignados
SELECT u.email, ur.role, ur.created_at
FROM public.user_roles ur
JOIN auth.users u ON u.id = ur.user_id
ORDER BY ur.created_at DESC;

-- Verificar que el super admin está configurado
SELECT email, role 
FROM public.user_roles 
WHERE role = 'super_admin';

-- ============================================================================
-- NOTAS IMPORTANTES:
-- ============================================================================
-- 
-- JERARQUÍA DE ROLES:
-- 1. super_admin → Acceso total + gestión de usuarios
-- 2. admin → CRUD completo (mensajes, fotos, canciones)
-- 3. invitado → Solo lectura
--
-- PERMISOS POR ROL:
-- - super_admin: TODO
-- - admin: INSERT, UPDATE, DELETE, SELECT en mensajes/fotos/canciones
-- - invitado: Solo SELECT (lectura)
--
-- CAMBIAR ROL DE UN USUARIO (solo super_admin puede hacer esto):
-- UPDATE public.user_roles 
-- SET role = 'admin', updated_at = NOW(), updated_by = auth.uid()
-- WHERE email = 'usuario@ejemplo.com';
--
-- ============================================================================
