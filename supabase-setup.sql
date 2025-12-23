-- ==============================================================================
-- SUPABASE SETUP SQL - NuestroMes (Configuración temporal para pruebas sin auth)
-- ==============================================================================
-- ADVERTENCIA: Estas políticas son ABIERTAS y permiten acceso anónimo.
-- Solo para desarrollo/pruebas. Para producción debes implementar autenticación.
-- ==============================================================================

-- ------------------------------------------------------------------------------
-- 1. TABLA: canciones (ya existe, añadir columnas owner y publico si faltan)
-- ------------------------------------------------------------------------------
ALTER TABLE public.canciones
ADD COLUMN IF NOT EXISTS owner uuid DEFAULT NULL,
ADD COLUMN IF NOT EXISTS publico boolean DEFAULT TRUE;

-- Habilitar RLS en canciones
ALTER TABLE public.canciones ENABLE ROW LEVEL SECURITY;

-- Política temporal: permitir SELECT a todos (anónimos)
DROP POLICY IF EXISTS canciones_select_all ON public.canciones;
CREATE POLICY canciones_select_all ON public.canciones
  FOR SELECT
  USING (true);

-- Política temporal: permitir INSERT a todos (anónimos) - SOLO PARA PRUEBAS
DROP POLICY IF EXISTS canciones_insert_temp ON public.canciones;
CREATE POLICY canciones_insert_temp ON public.canciones
  FOR INSERT
  WITH CHECK (true);

-- Política temporal: permitir DELETE a todos (anónimos) - SOLO PARA PRUEBAS
DROP POLICY IF EXISTS canciones_delete_temp ON public.canciones;
CREATE POLICY canciones_delete_temp ON public.canciones
  FOR DELETE
  USING (true);

-- Política temporal: permitir UPDATE a todos (anónimos) - SOLO PARA PRUEBAS
DROP POLICY IF EXISTS canciones_update_temp ON public.canciones;
CREATE POLICY canciones_update_temp ON public.canciones
  FOR UPDATE
  USING (true);

-- ------------------------------------------------------------------------------
-- 2. TABLA: fotos (metadata de imágenes)
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.fotos (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  titulo text,
  descripcion text,
  url text NOT NULL,            -- URL pública del archivo en Storage
  path text NOT NULL,           -- Path dentro del bucket (ej: 'fotos/2025-11-06_imagen.jpg')
  tipo text DEFAULT 'foto',     -- Tipo de contenido
  owner uuid,                   -- ID del usuario (null si anónimo)
  publico boolean DEFAULT TRUE, -- Si es público o privado
  creado_en timestamptz DEFAULT now()
);

-- Habilitar RLS en fotos
ALTER TABLE public.fotos ENABLE ROW LEVEL SECURITY;

-- Política temporal: permitir SELECT a todos
DROP POLICY IF EXISTS fotos_select_all ON public.fotos;
CREATE POLICY fotos_select_all ON public.fotos
  FOR SELECT
  USING (true);

-- Política temporal: permitir INSERT a todos - SOLO PARA PRUEBAS
DROP POLICY IF EXISTS fotos_insert_temp ON public.fotos;
CREATE POLICY fotos_insert_temp ON public.fotos
  FOR INSERT
  WITH CHECK (true);

-- Política temporal: permitir DELETE a todos - SOLO PARA PRUEBAS
DROP POLICY IF EXISTS fotos_delete_temp ON public.fotos;
CREATE POLICY fotos_delete_temp ON public.fotos
  FOR DELETE
  USING (true);

-- Política temporal: permitir UPDATE a todos - SOLO PARA PRUEBAS
DROP POLICY IF EXISTS fotos_update_temp ON public.fotos;
CREATE POLICY fotos_update_temp ON public.fotos
  FOR UPDATE
  USING (true);

-- ------------------------------------------------------------------------------
-- 3. TABLA: mensajes (mensajes de texto entre usuarios)
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.mensajes (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  autor uuid,                    -- ID del usuario que escribió (null si anónimo)
  texto text NOT NULL,
  privado boolean DEFAULT FALSE, -- Si es privado (solo visible para el autor)
  referencia_tipo text,          -- Opcional: 'foto' | 'cancion' para enlazar media
  referencia_id uuid,            -- Opcional: ID de la foto o canción relacionada
  creado_en timestamptz DEFAULT now()
);

-- Habilitar RLS en mensajes
ALTER TABLE public.mensajes ENABLE ROW LEVEL SECURITY;

-- Política temporal: permitir SELECT a todos
DROP POLICY IF EXISTS mensajes_select_all ON public.mensajes;
CREATE POLICY mensajes_select_all ON public.mensajes
  FOR SELECT
  USING (true);

-- Política temporal: permitir INSERT a todos - SOLO PARA PRUEBAS
DROP POLICY IF EXISTS mensajes_insert_temp ON public.mensajes;
CREATE POLICY mensajes_insert_temp ON public.mensajes
  FOR INSERT
  WITH CHECK (true);

-- Política temporal: permitir DELETE a todos - SOLO PARA PRUEBAS
DROP POLICY IF EXISTS mensajes_delete_temp ON public.mensajes;
CREATE POLICY mensajes_delete_temp ON public.mensajes
  FOR DELETE
  USING (true);

-- Política temporal: permitir UPDATE a todos - SOLO PARA PRUEBAS
DROP POLICY IF EXISTS mensajes_update_temp ON public.mensajes;
CREATE POLICY mensajes_update_temp ON public.mensajes
  FOR UPDATE
  USING (true);

-- ------------------------------------------------------------------------------
-- 4. ÍNDICES (mejoran performance de consultas)
-- ------------------------------------------------------------------------------
CREATE INDEX IF NOT EXISTS idx_fotos_owner ON public.fotos(owner);
CREATE INDEX IF NOT EXISTS idx_fotos_creado_en ON public.fotos(creado_en DESC);

CREATE INDEX IF NOT EXISTS idx_canciones_owner ON public.canciones(owner);
CREATE INDEX IF NOT EXISTS idx_canciones_creado_en ON public.canciones(creado_en DESC);

CREATE INDEX IF NOT EXISTS idx_mensajes_autor ON public.mensajes(autor);
CREATE INDEX IF NOT EXISTS idx_mensajes_creado_en ON public.mensajes(creado_en DESC);
CREATE INDEX IF NOT EXISTS idx_mensajes_referencia ON public.mensajes(referencia_tipo, referencia_id);

-- ------------------------------------------------------------------------------
-- 5. TABLA: regalos_navidad (Calendario de Adviento)
-- ------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS public.regalos_navidad (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  dia integer NOT NULL UNIQUE CHECK (dia >= 1 AND dia <= 24),
  titulo text NOT NULL,
  tipo text DEFAULT 'mensaje', -- 'mensaje', 'foto', 'cancion', 'mixto'
  contenido text,
  foto_url text,
  foto_path text,
  emoji text DEFAULT '🎁',
  desbloqueado boolean DEFAULT false,
  fecha_desbloqueo timestamptz,
  creado_en timestamptz DEFAULT now(),
  actualizado_en timestamptz DEFAULT now()
);

-- Habilitar RLS en regalos_navidad
ALTER TABLE public.regalos_navidad ENABLE ROW LEVEL SECURITY;

-- Política temporal: permitir SELECT a todos
DROP POLICY IF EXISTS regalos_select_all ON public.regalos_navidad;
CREATE POLICY regalos_select_all ON public.regalos_navidad
  FOR SELECT
  USING (true);

-- Política temporal: permitir INSERT a todos - SOLO PARA PRUEBAS
DROP POLICY IF EXISTS regalos_insert_temp ON public.regalos_navidad;
CREATE POLICY regalos_insert_temp ON public.regalos_navidad
  FOR INSERT
  WITH CHECK (true);

-- Política temporal: permitir DELETE a todos - SOLO PARA PRUEBAS
DROP POLICY IF EXISTS regalos_delete_temp ON public.regalos_navidad;
CREATE POLICY regalos_delete_temp ON public.regalos_navidad
  FOR DELETE
  USING (true);

-- Política temporal: permitir UPDATE a todos - SOLO PARA PRUEBAS
DROP POLICY IF EXISTS regalos_update_temp ON public.regalos_navidad;
CREATE POLICY regalos_update_temp ON public.regalos_navidad
  FOR UPDATE
  USING (true);

-- Índice para búsquedas por día
CREATE INDEX IF NOT EXISTS idx_regalos_dia ON public.regalos_navidad(dia);

-- Insertar datos iniciales de los 24 regalos
INSERT INTO public.regalos_navidad (dia, titulo, tipo, contenido, emoji) VALUES
(1, 'Nuestro Primer Mensaje', 'mensaje', 'Mi amor, hoy comienza algo especial. Cada día de diciembre tendrás una sorpresa que te recordará cuánto te amo. Este es solo el inicio de nuestra primera Navidad juntos. 💕', '💌'),
(2, 'La Primera Vez que Te Vi', 'mensaje', 'Recuerdo perfectamente ese momento. Tus ojos, tu sonrisa... supe que eras especial. Desde ese día, mi vida cambió para siempre. 🌟', '👀'),
(3, 'Nuestra Primera Videollamada', 'mensaje', 'Aunque estemos lejos, cada videollamada me hace sentir que estás aquí conmigo. Tu voz, tu risa, tu presencia... lo son todo para mí. 📱💕', '📞'),
(4, 'Cuando Supe que Eras Especial', 'mensaje', 'No fue un momento específico, fue cada pequeño detalle. Tu forma de ser, de hablar, de hacerme sentir... Todo en ti me enamoró. ✨', '💫'),
(5, 'Tu Sonrisa que Me Enamora', 'mensaje', 'Tu sonrisa ilumina mis días, incluso a la distancia. Es lo primero que pienso al despertar y lo último antes de dormir. 😊💕', '😄'),
(6, 'Nuestro Primer "Te Amo"', 'mensaje', 'Esas palabras cambiaron todo. Cuando las dijimos por primera vez, supe que esto era real, que era para siempre. Te amo hoy y siempre. ❤️', '💖'),
(7, 'Un Mes Juntos', 'mensaje', 'El 8 de noviembre celebramos nuestro primer mes. Fue solo el comienzo de algo hermoso que seguirá creciendo cada día. 🎉💕', '🎊'),
(8, '¡Nuestro Segundo Mes!', 'mensaje', 'Hoy, 8 de diciembre, celebramos DOS MESES juntos. Cada día a tu lado es un regalo. Gracias por existir, mi amor. Te amo más que ayer y menos que mañana. 💕🎉', '🎂'),
(9, 'Tu Forma de Reír', 'mensaje', 'Tu risa es mi canción favorita. Cuando te ríes, el mundo se detiene y solo existes tú. Haría cualquier cosa por escucharte reír todos los días. 😊🎵', '😂'),
(10, 'Tu Bondad', 'mensaje', 'Tienes el corazón más hermoso que he conocido. Tu bondad, tu empatía, tu forma de cuidar a los demás... me enamoran más cada día. 💝', '🤗'),
(11, 'Tu Inteligencia', 'mensaje', 'Me fascina cómo piensas, cómo analizas las cosas, cómo me sorprendes con tus ideas. Eres brillante en todos los sentidos. 🧠✨', '📚'),
(12, 'Cómo Me Haces Sentir', 'mensaje', 'Contigo me siento completo, amado, valorado. Me haces querer ser mejor persona cada día. Gracias por hacerme tan feliz. 💕', '🥰'),
(13, 'Tu Belleza Interior', 'mensaje', 'Eres hermosa por fuera, pero tu belleza interior es lo que realmente me conquistó. Tu alma es pura, tu corazón es oro. 💎', '✨'),
(14, 'Tus Sueños', 'mensaje', 'Admiro tus sueños, tus metas, tu determinación. Quiero estar a tu lado mientras los cumples, apoyándote en cada paso. 🌟', '🎯'),
(15, 'Lugares que Visitaremos', 'mensaje', 'Sueño con el día en que podamos viajar juntos. Playas, montañas, ciudades... cada lugar será mágico si estás a mi lado. 🗺️✈️', '🌍'),
(16, 'Nuestra Primera Navidad', 'mensaje', 'Esta es nuestra primera Navidad juntos, aunque sea a distancia. Pero sé que vendrán muchas más, y cada una será más especial. 🎄💕', '🎅'),
(17, 'Promesa: Siempre Estar Para Ti', 'mensaje', 'Te prometo que siempre estaré aquí para ti. En tus alegrías, en tus tristezas, en tus miedos y en tus sueños. Siempre. 🤝💕', '🤞'),
(18, 'Nuestro Futuro Juntos', 'mensaje', 'Veo un futuro hermoso contigo. Risas, aventuras, amor infinito. No importa qué nos depare el destino, lo enfrentaremos juntos. 🌈', '🔮'),
(19, 'Aventuras que Viviremos', 'mensaje', 'Quiero vivir mil aventuras contigo. Desde las más grandes hasta las más pequeñas. Cada momento a tu lado es una aventura. 🎢💕', '🎪'),
(20, 'Mi Compromiso Contigo', 'mensaje', 'Me comprometo a amarte, respetarte, cuidarte y hacerte feliz cada día. Eres mi prioridad, mi amor, mi todo. 💍💕', '💝'),
(21, 'Inicio del Invierno Juntos', 'mensaje', 'Hoy comienza el invierno, la estación más romántica. Aunque no pueda abrazarte físicamente, mi amor te mantiene calientita. ❄️💕', '⛄'),
(22, 'Carta de Amor Navideña', 'mensaje', 'Mi Rocío hermosa, esta Navidad es especial porque la paso contigo. Aunque estemos lejos, mi corazón está contigo siempre. Eres mi mejor regalo. Te amo infinitamente. 💌🎄', '💝'),
(23, 'Un Día Más Para Navidad', 'mensaje', 'Mañana es Nochebuena, y aunque no estemos juntos físicamente, quiero que sepas que estás en cada uno de mis pensamientos. Te amo, mi amor. 🎄💕', '🎁'),
(24, '¡Feliz Navidad, Mi Amor!', 'mixto', 'Feliz Navidad, Rocío. Eres el mejor regalo que la vida me ha dado. Gracias por existir, por amarme, por ser tú. Este es un regalo especial para ti... 🎁💕🎄', '🎅')
ON CONFLICT (dia) DO NOTHING;

-- ==============================================================================
-- FIN DEL SCRIPT
-- ==============================================================================
-- NOTA IMPORTANTE:
-- Las políticas de Storage (storage.objects) NO se pueden crear aquí si no eres
-- owner de la tabla. Debes crearlas desde la UI de Supabase:
-- Storage → Buckets → archivos → Configuration → Policies
-- 
-- Consulta el archivo SUPABASE-STORAGE-POLICIES.md para los pasos detallados.
-- ==============================================================================
