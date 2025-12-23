# Reacciones (Tabla y Frontend)

Instrucciones para añadir el sistema de reacciones (Supabase + frontend).

## 1) Crear la tabla en Supabase

Usa el editor SQL de Supabase (o psql) y ejecuta `sql/create_reacciones.sql`.

Contenido principal (ya incluido en `sql/create_reacciones.sql`):

```sql
CREATE TABLE IF NOT EXISTS reacciones (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  mensaje_id uuid REFERENCES mensajes(id) ON DELETE CASCADE,
  emoji text NOT NULL,
  creado_en timestamptz DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_reacciones_mensaje_id ON reacciones(mensaje_id);
```

Nota: `gen_random_uuid()` requiere la extensión correspondiente (pgcrypto o pgcrypto/pgcrypto instalado). En Supabase suele funcionar por defecto; si no, usa `uuid_generate_v4()` si tienes la extensión `uuid-ossp`.

## 2) Archivos añadidos

- `sql/create_reacciones.sql` — script SQL para crear tabla e índice.
- `js/reacciones.js` — librería frontend con funciones:
  - `insertarReaccion(mensajeId, emoji)` — inserta una fila en `reacciones`.
  - `obtenerConteosPorMensaje(mensajeId)` — obtiene conteos por emoji (con fallback si el client no soporta group).
  - `suscribirReacciones(callback)` — suscripción realtime; `callback` recibe `{ mensajeId, emoji, event }`.
  - `montarBotonesDeReaccion(contenedor, mensajeId, initialCounts)` — monta botones listos para reaccionar.

- `mis-mensajes.html` — actualizado para incluir `js/reacciones.js`, montar botones en cada tarjeta y actualizar conteos en tiempo real.

## 3) Dependencias y supuestos

- `js/supabaseConfig.js` debe exponer `window.supabaseClient` (este proyecto ya lo hace).
- Se usa la versión UMD de Supabase (v2.x UMD) incluida por CDN en `mis-mensajes.html`.
- No hay gestión de usuarios; las reacciones son anónimas.

## 4) Cómo probar localmente

1. Ejecuta `sql/create_reacciones.sql` en la SQL editor de Supabase.
2. Abre `mis-mensajes.html` desde tu servidor (ej. `http://localhost/NuestroMes/mis-mensajes.html`).
3. Haz clic en los emojis en cualquier tarjeta: debería insertarse la reacción en la tabla `reacciones`.
4. Abre la misma página en otra ventana/incógnito y reacciona — el conteo debería actualizarse en tiempo real.

## 5) Problemas conocidos y soluciones

- Si la suscripción realtime no funciona, verifica la versión del cliente Supabase. Si `client.channel` no existe, la actualización en tiempo real no funcionará y el script usa un fallback basado en refetch manual.
- Si `gen_random_uuid()` no está disponible, reemplazar por `uuid_generate_v4()` o generar UUID en frontend.

---

Si quieres, puedo:
- Crear una pequeña ruta o RPC en Supabase que devuelva conteos agregados por mensaje (si prefieres no usar el group desde JS).
- Añadir soporte para que el usuario pueda "deshacer" su reacción (por ejemplo, eliminar la última reacción anónima por cookie/session).
