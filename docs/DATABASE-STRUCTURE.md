# 📊 Estructura de Base de Datos - OurCorner

**Documentación completa de todas las entidades, atributos y relaciones**

**Fecha:** 2 de mayo 2026  
**Versión:** 2.0 (Sin IP Tracking)  
**Total de Entidades:** 7

---

## 📋 Tabla de Contenidos

1. [Resumen Ejecutivo](#resumen-ejecutivo)
2. [Diagrama de Relaciones](#diagrama-de-relaciones)
3. [Entidades Detalladas](#entidades-detalladas)
4. [Índices y Performance](#índices-y-performance)
5. [Funciones y Triggers](#funciones-y-triggers)
6. [Políticas RLS](#políticas-rls)

---

## 🎯 Resumen Ejecutivo

| Aspecto | Detalles |
|---------|----------|
| **Total de Tablas** | 7 tablas |
| **Total de Columnas** | 62 columnas |
| **Índices** | 21+ índices |
| **Funciones** | 3 funciones almacenadas |
| **Triggers** | 4 triggers activos |
| **RLS Habilitado** | 7/7 tablas ✅ |
| **Relaciones FK** | 4 relaciones |
| **Provedor** | Supabase (PostgreSQL 13+) |

---

## 📊 Diagrama de Relaciones

```
┌─────────────────────────────────────────────────────┐
│              auth.users (Supabase)                  │
│  (Tabla externa - autenticación)                    │
└────────┬────────────────────┬────────────┬──────────┘
         │                    │            │
         │ 1:1                │ 1:1        │ 1:N
         │                    │            │
    ┌────▼──────┐      ┌──────▼─────┐   ┌─▼──────────┐
    │user_roles │      │user_profiles    │ mensajes   │
    └───────────┘      └──────────────┘   └────────────┘
                                          │
                                          │ N:1
                                          │
                                        reacciones

TABLAS INDEPENDIENTES:
├── canciones (multimedia)
├── fotos (metadata imágenes)
└── regalos_navidad (adviento)
```

---

## 🔍 Entidades Detalladas

### 1️⃣ **TABLA: canciones**

**Propósito:** Almacenar información de canciones personalizadas  
**Privacidad:** Pública  
**RLS:** ✅ Habilitado

#### Columnas

| Columna | Tipo | Restricciones | Descripción |
|---------|------|---------------|-------------|
| `id` | UUID | PK, DEFAULT `gen_random_uuid()` | Identificador único |
| `titulo` | TEXT | NOT NULL | Nombre de la canción |
| `artista` | TEXT | NOT NULL | Nombre del artista/compositor |
| `url` | TEXT | NOT NULL | URL pública de acceso |
| `tipo` | TEXT | DEFAULT `'personalizada'` | Categoría: personalizada\|predeterminada\|romantica |
| `path` | TEXT | NULLABLE | Path en Storage (ej: canciones/mi-cancion.mp3) |
| `owner` | UUID | NULLABLE | ID usuario propietario |
| `publico` | BOOLEAN | DEFAULT `TRUE` | Visible públicamente |
| `creado_en` | TIMESTAMPTZ | DEFAULT `NOW()` | Timestamp de creación |

#### Índices

```sql
idx_canciones_owner         -- Búsquedas por propietario
idx_canciones_creado_en     -- Búsquedas por fecha (DESC)
idx_canciones_titulo        -- Búsquedas por título
```

#### Ejemplo de Datos

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "titulo": "Our Song",
  "artista": "Ed Sheeran",
  "url": "https://storage.googleapis.com/...",
  "tipo": "personalizada",
  "path": "canciones/our-song.mp3",
  "owner": "user-uuid-123",
  "publico": true,
  "creado_en": "2025-11-08T15:30:00Z"
}
```

---

### 2️⃣ **TABLA: fotos**

**Propósito:** Almacenar metadata e información de imágenes  
**Privacidad:** Pública (con control privado)  
**RLS:** ✅ Habilitado  
**Relación:** Linked con Storage

#### Columnas

| Columna | Tipo | Restricciones | Descripción |
|---------|------|---------------|-------------|
| `id` | UUID | PK, DEFAULT `gen_random_uuid()` | Identificador único |
| `titulo` | TEXT | NULLABLE | Título descriptivo |
| `descripcion` | TEXT | NULLABLE | Descripción detallada |
| `url` | TEXT | NOT NULL | URL pública (generada por Storage) |
| `path` | TEXT | NOT NULL | Path en bucket Storage |
| `tipo` | TEXT | DEFAULT `'foto'` | Categoría: foto\|imagen\|galeria\|portada |
| `owner` | UUID | NULLABLE | ID usuario propietario |
| `publico` | BOOLEAN | DEFAULT `TRUE` | Visible públicamente |
| `creado_en` | TIMESTAMPTZ | DEFAULT `NOW()` | Timestamp de creación |

#### Índices

```sql
idx_fotos_owner        -- Búsquedas por propietario
idx_fotos_creado_en    -- Búsquedas por fecha (DESC)
idx_fotos_tipo         -- Búsquedas por tipo
```

#### Ejemplo de Datos

```json
{
  "id": "660e8400-e29b-41d4-a716-446655440001",
  "titulo": "Atardecer Juntos",
  "descripcion": "Foto del atardecer que vimos juntos",
  "url": "https://supabase.../fotos/atardecer.jpg",
  "path": "fotos/2025-11-06_atardecer.jpg",
  "tipo": "foto",
  "owner": "user-uuid-123",
  "publico": true,
  "creado_en": "2025-11-06T18:45:00Z"
}
```

---

### 3️⃣ **TABLA: mensajes**

**Propósito:** Almacenar mensajes de texto entre usuarios  
**Privacidad:** Públicos (con opción privada)  
**RLS:** ✅ Habilitado  
**Relación:** FK a `auth.users` (1:N)

#### Columnas

| Columna | Tipo | Restricciones | Descripción |
|---------|------|---------------|-------------|
| `id` | UUID | PK, DEFAULT `gen_random_uuid()` | Identificador único |
| `autor` | UUID | NULLABLE | ID usuario autor (puede ser anónimo) |
| `user_id` | UUID | FK auth.users ON DELETE CASCADE | Referencia a usuario autenticado |
| `texto` | TEXT | NOT NULL | Contenido del mensaje (sin límite) |
| `privado` | BOOLEAN | DEFAULT `FALSE` | Solo visible para autor |
| `referencia_tipo` | TEXT | NULLABLE | Tipo: foto\|cancion\|regalo |
| `referencia_id` | UUID | NULLABLE | ID de elemento referenciado |
| `creado_en` | TIMESTAMPTZ | DEFAULT `NOW()` | Timestamp creación (auto) |
| `actualizado_en` | TIMESTAMPTZ | DEFAULT `NOW()` | Timestamp última actualización (trigger) |

#### Índices

```sql
idx_mensajes_user_id              -- Búsquedas por usuario
idx_mensajes_creado_en            -- Búsquedas por fecha (DESC)
idx_mensajes_referencia           -- Búsquedas por tipo+id
```

#### Triggers

```sql
update_mensajes_timestamp -- Actualiza actualizado_en automáticamente
```

#### Ejemplo de Datos

```json
{
  "id": "770e8400-e29b-41d4-a716-446655440002",
  "autor": "550e8400-e29b-41d4-a716-446655440000",
  "user_id": "550e8400-e29b-41d4-a716-446655440000",
  "texto": "Mi amor, cada día contigo es un regalo. Te amo infinitamente ❤️",
  "privado": false,
  "referencia_tipo": "foto",
  "referencia_id": "660e8400-e29b-41d4-a716-446655440001",
  "creado_en": "2025-11-08T10:20:00Z",
  "actualizado_en": "2025-11-08T10:20:00Z"
}
```

---

### 4️⃣ **TABLA: regalos_navidad**

**Propósito:** Calendario de adviento (24 regalos - 1-24 de diciembre)  
**Privacidad:** Pública  
**RLS:** ✅ Habilitado (solo admin puede editar)  
**Especial:** Día único con validación (1-24)

#### Columnas

| Columna | Tipo | Restricciones | Descripción |
|---------|------|---------------|-------------|
| `id` | UUID | PK, DEFAULT `gen_random_uuid()` | Identificador único |
| `dia` | INTEGER | UNIQUE, CHECK (1-24) | Día calendario (único, validado) |
| `titulo` | TEXT | NOT NULL | Título del regalo |
| `tipo` | TEXT | DEFAULT `'mensaje'` | Tipo: mensaje\|foto\|cancion\|mixto |
| `contenido` | TEXT | NULLABLE | Contenido texto |
| `foto_url` | TEXT | NULLABLE | URL de imagen asociada |
| `foto_path` | TEXT | NULLABLE | Path en Storage |
| `emoji` | TEXT | DEFAULT `'🎁'` | Emoji representativo |
| `desbloqueado` | BOOLEAN | DEFAULT `FALSE` | ¿Ya fue abierto? |
| `fecha_desbloqueo` | TIMESTAMPTZ | NULLABLE | Cuándo se desbloqueó |
| `creado_en` | TIMESTAMPTZ | DEFAULT `NOW()` | Timestamp creación |
| `actualizado_en` | TIMESTAMPTZ | DEFAULT `NOW()` | Timestamp actualización (trigger) |

#### Índices

```sql
idx_regalos_dia            -- Búsquedas por día
idx_regalos_desbloqueado   -- Filtrar regalos abiertos/cerrados
```

#### Triggers

```sql
update_regalos_timestamp   -- Actualiza actualizado_en automáticamente
```

#### Ejemplo de Datos

```json
{
  "id": "880e8400-e29b-41d4-a716-446655440003",
  "dia": 8,
  "titulo": "¡Nuestro Segundo Mes!",
  "tipo": "mixto",
  "contenido": "Hoy celebramos DOS MESES juntos. Cada día a tu lado es un regalo...",
  "foto_url": "https://storage.../regalos/8.jpg",
  "emoji": "🎂",
  "desbloqueado": true,
  "fecha_desbloqueo": "2025-12-08T00:00:00Z",
  "creado_en": "2025-11-01T12:00:00Z",
  "actualizado_en": "2025-12-08T15:30:00Z"
}
```

---

### 5️⃣ **TABLA: user_profiles**

**Propósito:** Perfiles de usuario con login por username  
**Privacidad:** Públicos (para login)  
**RLS:** ✅ Habilitado  
**Relación:** 1:1 con `auth.users`  
**Nota:** Permite login por username en lugar de solo email

#### Columnas

| Columna | Tipo | Restricciones | Descripción |
|---------|------|---------------|-------------|
| `id` | INTEGER | PK, AUTO_INCREMENT | ID auto-incremental |
| `user_id` | UUID | UNIQUE, FK auth.users(id) | Referencia a usuario (1:1) |
| `username` | VARCHAR(20) | UNIQUE, NOT NULL | Username único para login |
| `email` | VARCHAR(255) | NOT NULL | Email del usuario |
| `created_at` | TIMESTAMPTZ | DEFAULT `NOW()` | Timestamp creación |
| `updated_at` | TIMESTAMPTZ | DEFAULT `NOW()` | Timestamp actualización |

#### Índices

```sql
idx_user_profiles_username  (LOWER)  -- Búsquedas case-insensitive
idx_user_profiles_user_id             -- FK lookup
idx_user_profiles_email               -- Búsquedas por email
```

#### Ejemplo de Datos

```json
{
  "id": 1,
  "user_id": "550e8400-e29b-41d4-a716-446655440000",
  "username": "leonardo",
  "email": "leonardo@example.com",
  "created_at": "2025-11-01T10:00:00Z",
  "updated_at": "2025-11-08T12:30:00Z"
}
```

---

### 6️⃣ **TABLA: user_roles**

**Propósito:** Asignación de roles para control de permisos  
**Privacidad:** Protegida  
**RLS:** ✅ Habilitado  
**Relación:** 1:1 con `auth.users`  
**Roles Disponibles:**
- `super_admin` - Control total
- `admin` - Moderador
- `invitado` - Usuario normal (default)

#### Columnas

| Columna | Tipo | Restricciones | Descripción |
|---------|------|---------------|-------------|
| `id` | UUID | PK, DEFAULT `gen_random_uuid()` | Identificador único |
| `user_id` | UUID | UNIQUE, FK auth.users(id) | Referencia a usuario |
| `email` | TEXT | UNIQUE, NOT NULL | Email para referencia |
| `role` | TEXT | DEFAULT `'invitado'`, CHECK | Rol: super_admin\|admin\|invitado |
| `created_at` | TIMESTAMPTZ | DEFAULT `NOW()` | Timestamp creación |
| `updated_at` | TIMESTAMPTZ | DEFAULT `NOW()` | Timestamp actualización |
| `updated_by` | UUID | NULLABLE, FK auth.users(id) | Quién hizo último cambio |

#### Índices

```sql
idx_user_roles_user_id   -- Búsquedas por usuario
idx_user_roles_email     -- Búsquedas por email
idx_user_roles_role      -- Filtrar por rol
```

#### Ejemplo de Datos

```json
{
  "id": "990e8400-e29b-41d4-a716-446655440004",
  "user_id": "550e8400-e29b-41d4-a716-446655440000",
  "email": "leonardo@example.com",
  "role": "super_admin",
  "created_at": "2025-11-01T10:00:00Z",
  "updated_at": "2025-11-08T12:30:00Z",
  "updated_by": "550e8400-e29b-41d4-a716-446655440000"
}
```

---

### 7️⃣ **TABLA: reacciones**

**Propósito:** Reacciones (emojis) a mensajes  
**Privacidad:** Pública  
**RLS:** ✅ Habilitado  
**Nota:** Soporta usuarios anónimos y autenticados

#### Columnas

| Columna | Tipo | Restricciones | Descripción |
|---------|------|---------------|-------------|
| `id` | UUID | PK, DEFAULT `gen_random_uuid()` | Identificador único |
| `user_id` | UUID | NULLABLE, FK auth.users(id) | Usuario autenticado |
| `session_id` | TEXT | NULLABLE | Session ID para anónimos |
| `emoji` | TEXT | NOT NULL | El emoji (❤️, 😄, 🔥, 👍, etc) |
| `mensaje_id` | UUID | NULLABLE | ID del mensaje reaccionado |
| `creado_en` | TIMESTAMPTZ | DEFAULT `NOW()` | Timestamp creación |

#### Índices

```sql
idx_reacciones_user_id      -- Búsquedas por usuario
idx_reacciones_session_id   -- Búsquedas por sesión anónima
idx_reacciones_emoji        -- Filtrar por emoji
idx_reacciones_mensaje      -- Reacciones a mensaje específico
idx_reacciones_creado       -- Búsquedas por fecha (DESC)
```

#### Funciones Relacionadas

```sql
reacciones_conteo()  -- Retorna tabla (emoji, total)
                     -- Cuenta reacciones por emoji
```

#### Ejemplo de Datos

```json
{
  "id": "aa0e8400-e29b-41d4-a716-446655440005",
  "user_id": "550e8400-e29b-41d4-a716-446655440000",
  "session_id": null,
  "emoji": "❤️",
  "mensaje_id": "770e8400-e29b-41d4-a716-446655440002",
  "creado_en": "2025-11-08T11:45:00Z"
}
```

---

## ⚡ Índices y Performance

### Índices Totales: 21+

#### Búsquedas por Usuario
```sql
idx_user_profiles_user_id       -- user_profiles
idx_user_roles_user_id          -- user_roles
idx_mensajes_user_id            -- mensajes
idx_reacciones_user_id          -- reacciones
```

#### Búsquedas por Fecha (Descendente)
```sql
idx_fotos_creado_en             -- Fotos más recientes
idx_canciones_creado_en         -- Canciones más recientes
idx_mensajes_creado_en          -- Mensajes más recientes
idx_reacciones_creado           -- Reacciones más recientes
```

#### Búsquedas Especializadas
```sql
idx_user_profiles_username      -- LOWER() para case-insensitive
idx_canciones_titulo            -- Por título de canción
idx_fotos_tipo                  -- Por tipo de foto
idx_reacciones_emoji            -- Por emoji (likes, hearts, etc)
idx_regalos_dia                 -- Por día (1-24)
idx_regalos_desbloqueado        -- Abiertos vs cerrados
```

---

## 🔧 Funciones y Triggers

### Funciones Almacenadas

#### 1. `update_updated_at_column()`
```sql
RETURNS TRIGGER
LANGUAGE plpgsql

Propósito: Actualizar timestamp automáticamente
Triggers: 
  - update_mensajes_timestamp
  - update_regalos_timestamp
```

#### 2. `handle_new_user_role()`
```sql
RETURNS TRIGGER
LANGUAGE plpgsql SECURITY DEFINER

Propósito: Asignar rol 'invitado' automáticamente al registrarse
Triggers:
  - on_auth_user_created_role
Evento: AFTER INSERT ON auth.users
```

#### 3. `reacciones_conteo()`
```sql
RETURNS TABLE(emoji TEXT, total BIGINT)
LANGUAGE SQL SECURITY DEFINER

Propósito: Contar reacciones agrupadas por emoji
Uso: SELECT * FROM reacciones_conteo();

Ejemplo de resultado:
  emoji | total
  ------+-------
   ❤️   |   15
   😄   |    8
   🔥   |    5
```

### Triggers Activos: 4

| Trigger | Tabla | Evento | Función |
|---------|-------|--------|---------|
| `update_mensajes_timestamp` | mensajes | BEFORE UPDATE | update_updated_at_column |
| `update_regalos_timestamp` | regalos_navidad | BEFORE UPDATE | update_updated_at_column |
| `on_auth_user_created_role` | auth.users | AFTER INSERT | handle_new_user_role |
| (internal) | auth.users | AFTER INSERT | handle_new_user_role |

---

## 🔐 Políticas RLS

**Todas las 7 tablas tienen RLS habilitado**

### Políticas por Tabla

#### `canciones`
```
SELECT:    Públicas (true)
INSERT:    Usuarios autenticados (user_id = owner)
UPDATE:    Solo propietario
DELETE:    Solo propietario
```

#### `fotos`
```
SELECT:    Públicas (publico = true) + propias
INSERT:    Usuarios autenticados
UPDATE:    Solo propietario
DELETE:    Solo propietario
```

#### `mensajes`
```
SELECT:    Públicos (privado = false) + propios
INSERT:    Usuarios autenticados
UPDATE:    Solo autor
DELETE:    Solo autor
```

#### `regalos_navidad`
```
SELECT:    Públicos (true)
INSERT:    Super admins y admins
UPDATE:    Super admins y admins
DELETE:    Super admins (implícito)
```

#### `user_profiles`
```
SELECT:    Públicos (true) - para login
INSERT:    Usuario mismo (user_id = auth.uid())
UPDATE:    Usuario mismo
DELETE:    No permitido
```

#### `user_roles`
```
SELECT:    Usuario propio + super admins
INSERT:    Sistema (trigger)
UPDATE:    Super admins
DELETE:    Super admins
```

#### `reacciones`
```
SELECT:    Públicas (true)
INSERT:    Cualquiera (true)
UPDATE:    Cualquiera (true)
DELETE:    Cualquiera (true)
```

---

## 📈 Estadísticas

### Estructura General

```
Total Tablas:           7
Total Columnas:         62
Total Índices:          21+
Funciones:              3
Triggers:               4
RLS Policies:           25+
Foreign Keys:           4
Unique Constraints:     8
Check Constraints:      3
```

### Tabla Más Grande (Columnas)
`regalos_navidad` - 12 columnas

### Tabla Más Pequeña (Columnas)
`reacciones` - 6 columnas

### Funcionalidades Especiales

- ✅ Row Level Security (RLS) en todas las tablas
- ✅ Foreign Keys con ON DELETE CASCADE
- ✅ Timestamps automáticos (creado_en, actualizado_en)
- ✅ Índices para performance
- ✅ Funciones almacenadas
- ✅ Triggers automáticos
- ✅ Validaciones en nivel BD (CHECK constraints)

---

## 📚 Referencias y Documentación Adicional

Archivo SQL completo: [DATABASE-STRUCTURE.sql](DATABASE-STRUCTURE.sql)  
Guía de Autenticación: [AUTENTICACION.md](AUTENTICACION.md)  
Resumen de Limpieza: [CLEANUP-SUMMARY.md](CLEANUP-SUMMARY.md)

---

**Última actualización:** 2 de mayo 2026  
**Versión:** 2.0 (Sin IP Tracking/Geolocalización)
