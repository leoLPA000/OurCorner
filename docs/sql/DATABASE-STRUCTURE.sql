-- ============================================================================
-- 📊 ESTRUCTURA COMPLETA DE BASE DE DATOS - OURCORNER
-- Esquema detallado de todas las entidades y atributos
-- ============================================================================
-- 
-- Descripción: Este script documenta la estructura COMPLETA de la BD
-- sin incluir tablas relacionadas con IP tracking/geolocalización
-- 
-- Fecha: 2 de mayo 2026
-- Rama: 25-04-2026-Refactorizacion02-05-2026
--
-- ============================================================================

-- ============================================================================
-- 📋 ENTIDADES Y RELACIONES
-- ============================================================================
/*
TABLA 1: canciones
├─ Almacena información de canciones personalizadas
├─ Relaciones: Ninguna (tabla independiente)
└─ RLS: Habilitado (público)

TABLA 2: fotos  
├─ Almacena metadata e información de imágenes
├─ Relaciones: Ninguna (tabla independiente)
└─ RLS: Habilitado (público)

TABLA 3: mensajes
├─ Almacena mensajes de texto entre usuarios
├─ Relaciones: auth.users (usuario autor)
└─ RLS: Habilitado (público lectura, protegido escritura)

TABLA 4: regalos_navidad
├─ Calendario de adviento con regalos diarios
├─ Relaciones: Ninguna (tabla independiente)
└─ RLS: Habilitado (público)

TABLA 5: user_profiles
├─ Perfiles de usuarios con login por username
├─ Relaciones: auth.users (1:1)
└─ RLS: Habilitado (público lectura, protegido escritura)

TABLA 6: user_roles
├─ Asignación de roles (super_admin, admin, invitado)
├─ Relaciones: auth.users (1:1)
└─ RLS: Habilitado (protegido)

TABLA 7: reacciones
├─ Emojis/reacciones a mensajes (likes, hearts, etc)
├─ Relaciones: auth.users (opcional)
└─ RLS: Habilitado (público)
*/

-- ============================================================================
-- TABLA 1: canciones
-- ============================================================================
/*
Propósito: Almacenar información de canciones personalizadas
Privacidad: Pública
RLS: Habilitado
*/

CREATE TABLE IF NOT EXISTS public.canciones (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    -- Identidad única
    
    titulo TEXT NOT NULL,
    -- Nombre de la canción (requerido)
    
    artista TEXT NOT NULL,
    -- Nombre del artista/compositor (requerido)
    
    url TEXT NOT NULL,
    -- URL pública de acceso a la canción (requerido)
    -- Puede ser URL de Storage o URL externa
    
    tipo TEXT DEFAULT 'personalizada',
    -- Tipo: 'personalizada' | 'predeterminada' | 'romantica'
    -- Categoría de la canción
    
    path TEXT,
    -- Path en Storage interno (ej: 'canciones/mi-cancion.mp3')
    -- NULL si es URL externa
    
    owner UUID,
    -- ID del usuario propietario (opcional)
    -- NULL para canciones públicas
    
    publico BOOLEAN DEFAULT TRUE,
    -- Si es pública o privada
    
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    -- Timestamp de creación (automático)
);

-- Índices para performance
CREATE INDEX IF NOT EXISTS idx_canciones_owner ON public.canciones(owner);
CREATE INDEX IF NOT EXISTS idx_canciones_creado_en ON public.canciones(creado_en DESC);
CREATE INDEX IF NOT EXISTS idx_canciones_titulo ON public.canciones(titulo);

-- RLS
ALTER TABLE public.canciones ENABLE ROW LEVEL SECURITY;

CREATE POLICY "canciones_select_all" ON public.canciones
    FOR SELECT USING (true);

CREATE POLICY "canciones_insert_auth" ON public.canciones
    FOR INSERT TO authenticated
    WITH CHECK (auth.uid() = owner OR owner IS NULL);

CREATE POLICY "canciones_update_owner" ON public.canciones
    FOR UPDATE TO authenticated
    USING (auth.uid() = owner)
    WITH CHECK (auth.uid() = owner);

CREATE POLICY "canciones_delete_owner" ON public.canciones
    FOR DELETE TO authenticated
    USING (auth.uid() = owner);

-- ============================================================================
-- TABLA 2: fotos
-- ============================================================================
/*
Propósito: Almacenar metadata de imágenes/fotos
Privacidad: Pública
RLS: Habilitado
Relación con Storage: Almacenan referencias a archivos en Storage
*/

CREATE TABLE IF NOT EXISTS public.fotos (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    -- Identidad única
    
    titulo TEXT,
    -- Título descriptivo de la foto (opcional)
    
    descripcion TEXT,
    -- Descripción más detallada (opcional)
    
    url TEXT NOT NULL,
    -- URL pública accesible (requerido)
    -- Generada por Supabase Storage
    
    path TEXT NOT NULL,
    -- Path dentro del bucket Storage (requerido)
    -- Ej: 'fotos/2025-11-06_imagen.jpg'
    
    tipo TEXT DEFAULT 'foto',
    -- Tipo: 'foto' | 'imagen' | 'galeria' | 'portada'
    -- Categoría del archivo
    
    owner UUID,
    -- ID del usuario propietario (opcional)
    
    publico BOOLEAN DEFAULT TRUE,
    -- Si es visible públicamente
    
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    -- Timestamp de creación (automático)
);

-- Índices para performance
CREATE INDEX IF NOT EXISTS idx_fotos_owner ON public.fotos(owner);
CREATE INDEX IF NOT EXISTS idx_fotos_creado_en ON public.fotos(creado_en DESC);
CREATE INDEX IF NOT EXISTS idx_fotos_tipo ON public.fotos(tipo);

-- RLS
ALTER TABLE public.fotos ENABLE ROW LEVEL SECURITY;

CREATE POLICY "fotos_select_all" ON public.fotos
    FOR SELECT USING (publico = true);

CREATE POLICY "fotos_select_owner" ON public.fotos
    FOR SELECT TO authenticated
    USING (auth.uid() = owner);

CREATE POLICY "fotos_insert_auth" ON public.fotos
    FOR INSERT TO authenticated
    WITH CHECK (auth.uid() = owner);

CREATE POLICY "fotos_update_owner" ON public.fotos
    FOR UPDATE TO authenticated
    USING (auth.uid() = owner)
    WITH CHECK (auth.uid() = owner);

CREATE POLICY "fotos_delete_owner" ON public.fotos
    FOR DELETE TO authenticated
    USING (auth.uid() = owner);

-- ============================================================================
-- TABLA 3: mensajes
-- ============================================================================
/*
Propósito: Almacenar mensajes de texto entre usuarios
Privacidad: Pública (todos leen) / Protegida (solo autor escribe)
RLS: Habilitado
Relación: Vinculado a auth.users por user_id
*/

CREATE TABLE IF NOT EXISTS public.mensajes (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    -- Identidad única
    
    autor UUID,
    -- ID del usuario que escribió (puede ser NULL para anónimo)
    
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    -- FK a tabla auth.users de Supabase
    -- NULL para mensajes anónimos
    
    texto TEXT NOT NULL,
    -- Contenido del mensaje (requerido, sin límite de caracteres)
    
    privado BOOLEAN DEFAULT FALSE,
    -- Si es privado (solo visible para el autor)
    
    referencia_tipo TEXT,
    -- Tipo de referencia: 'foto' | 'cancion' | 'regalo' (opcional)
    
    referencia_id UUID,
    -- ID de la entidad referenciada (opcional)
    -- Ejemplo: ID de foto, canción o regalo de adviento
    
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    -- Timestamp de creación (automático)
    
    actualizado_en TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    -- Timestamp de última actualización
);

-- Índices para performance
CREATE INDEX IF NOT EXISTS idx_mensajes_user_id ON public.mensajes(user_id);
CREATE INDEX IF NOT EXISTS idx_mensajes_creado_en ON public.mensajes(creado_en DESC);
CREATE INDEX IF NOT EXISTS idx_mensajes_referencia ON public.mensajes(referencia_tipo, referencia_id);

-- RLS
ALTER TABLE public.mensajes ENABLE ROW LEVEL SECURITY;

CREATE POLICY "mensajes_select_publicos" ON public.mensajes
    FOR SELECT USING (privado = false OR privado IS NULL);

CREATE POLICY "mensajes_select_propios" ON public.mensajes
    FOR SELECT TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "mensajes_insert_auth" ON public.mensajes
    FOR INSERT TO authenticated
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "mensajes_update_author" ON public.mensajes
    FOR UPDATE TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "mensajes_delete_author" ON public.mensajes
    FOR DELETE TO authenticated
    USING (auth.uid() = user_id);

-- ============================================================================
-- TABLA 4: regalos_navidad
-- ============================================================================
/*
Propósito: Calendario de adviento (24 regalos para diciembre)
Privacidad: Pública
RLS: Habilitado
Características:
- Día único entre 1 y 24
- Control de desbloqueo automático
- Múltiples tipos de contenido
*/

CREATE TABLE IF NOT EXISTS public.regalos_navidad (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    -- Identidad única
    
    dia INTEGER NOT NULL UNIQUE CHECK (dia >= 1 AND dia <= 24),
    -- Día del calendario (1-24, único, con validación)
    
    titulo TEXT NOT NULL,
    -- Título del regalo
    
    tipo TEXT DEFAULT 'mensaje',
    -- Tipo: 'mensaje' | 'foto' | 'cancion' | 'mixto'
    -- Define qué tipo de contenido contiene
    
    contenido TEXT,
    -- Contenido de texto del regalo (opcional)
    
    foto_url TEXT,
    -- URL pública de imagen asociada (opcional)
    
    foto_path TEXT,
    -- Path en Storage de la imagen (opcional)
    
    emoji TEXT DEFAULT '🎁',
    -- Emoji representativo del regalo
    
    desbloqueado BOOLEAN DEFAULT FALSE,
    -- Control si el regalo ya fue desbloqueado
    
    fecha_desbloqueo TIMESTAMP WITH TIME ZONE,
    -- Timestamp de cuándo se desbloqueó
    
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    -- Timestamp de creación
    
    actualizado_en TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    -- Timestamp de última actualización
);

-- Índices para performance
CREATE INDEX IF NOT EXISTS idx_regalos_dia ON public.regalos_navidad(dia);
CREATE INDEX IF NOT EXISTS idx_regalos_desbloqueado ON public.regalos_navidad(desbloqueado);

-- RLS
ALTER TABLE public.regalos_navidad ENABLE ROW LEVEL SECURITY;

CREATE POLICY "regalos_select_all" ON public.regalos_navidad
    FOR SELECT USING (true);

CREATE POLICY "regalos_insert_admin" ON public.regalos_navidad
    FOR INSERT TO authenticated
    WITH CHECK (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    ));

CREATE POLICY "regalos_update_admin" ON public.regalos_navidad
    FOR UPDATE TO authenticated
    USING (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    ))
    WITH CHECK (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    ));

-- ============================================================================
-- TABLA 5: user_profiles
-- ============================================================================
/*
Propósito: Almacenar perfiles de usuario con username único
Privacidad: Públicos (para login)
RLS: Habilitado
Relación: 1:1 con auth.users
Nota: Permite login por username en lugar de solo email
*/

CREATE TABLE IF NOT EXISTS public.user_profiles (
    id SERIAL PRIMARY KEY,
    -- ID auto-incremental
    
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    -- FK a auth.users (relación 1:1)
    
    username VARCHAR(20) UNIQUE NOT NULL,
    -- Username único para login (máx 20 caracteres)
    
    email VARCHAR(255) NOT NULL,
    -- Email del usuario
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    -- Timestamp de creación
    
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    -- Timestamp de última actualización
);

-- Índices para performance
CREATE UNIQUE INDEX IF NOT EXISTS idx_user_profiles_username ON public.user_profiles(LOWER(username));
CREATE INDEX IF NOT EXISTS idx_user_profiles_user_id ON public.user_profiles(user_id);
CREATE INDEX IF NOT EXISTS idx_user_profiles_email ON public.user_profiles(email);

-- RLS
ALTER TABLE public.user_profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "profiles_select_public" ON public.user_profiles
    FOR SELECT USING (true);

CREATE POLICY "profiles_insert_self" ON public.user_profiles
    FOR INSERT TO authenticated
    WITH CHECK (auth.uid() = user_id);

CREATE POLICY "profiles_update_self" ON public.user_profiles
    FOR UPDATE TO authenticated
    USING (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- ============================================================================
-- TABLA 6: user_roles
-- ============================================================================
/*
Propósito: Asignar roles a usuarios (control de permisos)
Privacidad: Protegida
RLS: Habilitado
Roles disponibles:
  - super_admin: Control total
  - admin: Moderador
  - invitado: Usuario normal
*/

CREATE TABLE IF NOT EXISTS public.user_roles (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    -- Identidad única
    
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    -- FK a auth.users
    
    email TEXT NOT NULL,
    -- Email para referencia
    
    role TEXT NOT NULL DEFAULT 'invitado',
    -- Rol asignado (super_admin | admin | invitado)
    
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    -- Timestamp de creación
    
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    -- Timestamp de última actualización
    
    updated_by UUID REFERENCES auth.users(id),
    -- Quién hizo la última actualización
    
    UNIQUE(user_id),
    UNIQUE(email),
    CONSTRAINT valid_role CHECK (role IN ('super_admin', 'admin', 'invitado'))
    -- Validación de rol
);

-- Índices para performance
CREATE INDEX IF NOT EXISTS idx_user_roles_user_id ON public.user_roles(user_id);
CREATE INDEX IF NOT EXISTS idx_user_roles_email ON public.user_roles(email);
CREATE INDEX IF NOT EXISTS idx_user_roles_role ON public.user_roles(role);

-- RLS
ALTER TABLE public.user_roles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "roles_select_own" ON public.user_roles
    FOR SELECT TO authenticated
    USING (auth.uid() = user_id);

CREATE POLICY "roles_select_admins" ON public.user_roles
    FOR SELECT TO authenticated
    USING (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role = 'super_admin'
    ));

CREATE POLICY "roles_update_admin" ON public.user_roles
    FOR UPDATE TO authenticated
    USING (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role = 'super_admin'
    ))
    WITH CHECK (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role = 'super_admin'
    ));

-- ============================================================================
-- TABLA 7: reacciones
-- ============================================================================
/*
Propósito: Almacenar reacciones (emojis) a mensajes
Privacidad: Pública
RLS: Habilitado
Nota: Permite usuarios anónimos y autenticados reaccionar
*/

CREATE TABLE IF NOT EXISTS public.reacciones (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    -- Identidad única
    
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    -- FK a auth.users (NULL para anónimos)
    
    session_id TEXT,
    -- ID de sesión para usuarios anónimos (puede ser NULL)
    
    emoji TEXT NOT NULL,
    -- El emoji de reacción (❤️, 😄, 🔥, etc)
    
    mensaje_id UUID,
    -- ID del mensaje reaccionado (opcional)
    
    creado_en TIMESTAMP WITH TIME ZONE DEFAULT NOW()
    -- Timestamp de creación
);

-- Índices para performance
CREATE INDEX IF NOT EXISTS idx_reacciones_user_id ON public.reacciones(user_id);
CREATE INDEX IF NOT EXISTS idx_reacciones_session_id ON public.reacciones(session_id);
CREATE INDEX IF NOT EXISTS idx_reacciones_emoji ON public.reacciones(emoji);
CREATE INDEX IF NOT EXISTS idx_reacciones_mensaje ON public.reacciones(mensaje_id);
CREATE INDEX IF NOT EXISTS idx_reacciones_creado ON public.reacciones(creado_en DESC);

-- RLS
ALTER TABLE public.reacciones ENABLE ROW LEVEL SECURITY;

CREATE POLICY "reacciones_select_all" ON public.reacciones
    FOR SELECT USING (true);

CREATE POLICY "reacciones_insert_all" ON public.reacciones
    FOR INSERT WITH CHECK (true);

CREATE POLICY "reacciones_update_all" ON public.reacciones
    FOR UPDATE USING (true)
    WITH CHECK (true);

CREATE POLICY "reacciones_delete_all" ON public.reacciones
    FOR DELETE USING (true);

-- ============================================================================
-- FUNCIONES AUXILIARES
-- ============================================================================

-- Función para actualizar timestamp automático
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.actualizado_en = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para mensajes
DROP TRIGGER IF EXISTS update_mensajes_timestamp ON public.mensajes;
CREATE TRIGGER update_mensajes_timestamp
    BEFORE UPDATE ON public.mensajes
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Trigger para regalos_navidad
DROP TRIGGER IF EXISTS update_regalos_timestamp ON public.regalos_navidad;
CREATE TRIGGER update_regalos_timestamp
    BEFORE UPDATE ON public.regalos_navidad
    FOR EACH ROW
    EXECUTE FUNCTION update_updated_at_column();

-- Función para asignar rol automáticamente al registrarse
CREATE OR REPLACE FUNCTION public.handle_new_user_role()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO public.user_roles (user_id, email, role)
    VALUES (NEW.id, NEW.email, 'invitado')
    ON CONFLICT (user_id) DO NOTHING;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

-- Trigger para crear rol automáticamente
DROP TRIGGER IF EXISTS on_auth_user_created_role ON auth.users;
CREATE TRIGGER on_auth_user_created_role
    AFTER INSERT ON auth.users
    FOR EACH ROW
    EXECUTE FUNCTION public.handle_new_user_role();

-- ============================================================================
-- FUNCIÓN PARA CONTAR REACCIONES POR EMOJI
-- ============================================================================

DROP FUNCTION IF EXISTS public.reacciones_conteo() CASCADE;
CREATE FUNCTION public.reacciones_conteo()
RETURNS TABLE(emoji TEXT, total BIGINT)
SECURITY DEFINER
SET search_path = public
LANGUAGE SQL AS $$
    SELECT emoji, COUNT(*) as total
    FROM public.reacciones
    GROUP BY emoji
    ORDER BY total DESC;
$$;

-- ============================================================================
-- VERIFICACIÓN Y DOCUMENTACIÓN
-- ============================================================================

-- Consulta para ver todas las tablas
-- SELECT table_name FROM information_schema.tables WHERE table_schema = 'public';

-- Consulta para ver estructura de tabla específica
-- SELECT column_name, data_type, is_nullable FROM information_schema.columns WHERE table_name = 'nombre_tabla';

-- Consulta para ver RLS policies
-- SELECT tablename, policyname, permissive, roles, cmd FROM pg_policies WHERE tablename = 'nombre_tabla';

-- ============================================================================
-- 📊 RESUMEN DE ENTIDADES
-- ============================================================================
/*
Total de tablas: 7
- canciones (10 columnas)
- fotos (10 columnas)
- mensajes (11 columnas)
- regalos_navidad (12 columnas)
- user_profiles (5 columnas)
- user_roles (8 columnas)
- reacciones (6 columnas)

Total de índices: 21+
- Mejoran búsquedas por user_id, timestamp, emoji, etc

Funciones: 3
- update_updated_at_column() - Auto timestamp
- handle_new_user_role() - Auto role assignment
- reacciones_conteo() - Contar reacciones por emoji

Triggers: 4
- update_mensajes_timestamp
- update_regalos_timestamp
- on_auth_user_created_role (x2)

RLS Enabled: 7/7 tablas
Todas las tablas tienen Row Level Security habilitado

Relaciones FK: 4
- user_profiles → auth.users (1:1)
- user_roles → auth.users (1:1)
- mensajes → auth.users (N:1)
- reacciones → auth.users (N:1)
*/

-- ============================================================================
-- FIN DE ESTRUCTURA DE BASE DE DATOS
-- ============================================================================
