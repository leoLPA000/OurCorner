# 📸 SOLUCIÓN: Error RLS al Subir Fotos en Galería

**Fecha:** 23 de mayo de 2026  
**Estado:** ✅ RESUELTO  
**Usuario Reportante:** Leonardo Peña Añez  

---

## 🔴 Problema Original

Cuando un usuario **super_admin o admin** intentaba subir una foto a la galería, obtenía estos errores:

```
POST https://lrjbpnzkvueralkqrsfd.supabase.co/storage/v1/object/archivos/fotos/... 400 (Bad Request)

Error en upload: 
{statusCode: '403', error: 'Unauthorized', message: 'new row violates row-level security policy'}
```

**Síntomas:**
- ❌ Super admin (`leonardopenaanez@gmail.com`) NO podía subir fotos
- ❌ Admins (`rociomilagros268@gmail.com`, `clientebot6001@gmail.com`) NO podían subir fotos
- ❌ Error 403 de RLS en base de datos
- ✅ La autenticación funcionaba correctamente
- ✅ Los usuarios invitados tenían acceso denegado correctamente (sin errores)

---

## 🔍 Causa Raíz

El problema tenía **DOS capas**:

### 1️⃣ **Tabla `fotos` - Políticas Mixtas**
La tabla `fotos` tenía políticas antiguas y nuevas simultáneamente:
- Políticas antiguas con validaciones `auth.uid() = owner` que fallaban
- Nuevas políticas (`fotos_insert_admin`) que también estaban presentes
- El controlador NO enviaba el campo `owner`, causando fallos

### 2️⃣ **Storage `archivos` - Políticas Restringidas**
El bucket de Storage tenía políticas que **solo permitían a usuarios autenticados** genéricos, sin verificar si eran admin/superadmin:
```sql
"Usuarios autenticados pueden subir archivos"
```
Esta política era demasiado restrictiva para el contexto de RLS.

---

## ✅ Solución Implementada

### **PARTE 1: Limpiar Tabla `fotos`**

#### Paso 1.1 - Eliminar todas las políticas antiguas/duplicadas

```sql
-- Eliminar TODAS las políticas viejas
DROP POLICY IF EXISTS "fotos_select_all" ON public.fotos;
DROP POLICY IF EXISTS "fotos_select_owner" ON public.fotos;
DROP POLICY IF EXISTS "fotos_insert_auth" ON public.fotos;
DROP POLICY IF EXISTS "fotos_update_owner" ON public.fotos;
DROP POLICY IF EXISTS "fotos_delete_owner" ON public.fotos;
DROP POLICY IF EXISTS "Fotos - SELECT público" ON public.fotos;
DROP POLICY IF EXISTS "Fotos - INSERT autenticado" ON public.fotos;
DROP POLICY IF EXISTS "Solo admins pueden actualizar fotos" ON public.fotos;
DROP POLICY IF EXISTS "Solo admins pueden eliminar fotos" ON public.fotos;
DROP POLICY IF EXISTS "Solo admins pueden insertar fotos" ON public.fotos;
DROP POLICY IF EXISTS "Todos pueden leer fotos" ON public.fotos;
DROP POLICY IF EXISTS "fotos_delete_admin" ON public.fotos;
DROP POLICY IF EXISTS "fotos_insert_admin" ON public.fotos;
DROP POLICY IF EXISTS "fotos_select_admin" ON public.fotos;
DROP POLICY IF EXISTS "fotos_select_public" ON public.fotos;
DROP POLICY IF EXISTS "fotos_update_admin" ON public.fotos;
```

#### Paso 1.2 - Crear 5 nuevas políticas correctas

```sql
-- 1️⃣ SELECT: Todos pueden leer fotos públicas
CREATE POLICY "fotos_select_public" ON public.fotos
    FOR SELECT
    USING (publico = true);

-- 2️⃣ SELECT: Admins pueden ver todas las fotos
CREATE POLICY "fotos_select_admin" ON public.fotos
    FOR SELECT
    TO authenticated
    USING (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    ));

-- 3️⃣ INSERT: Solo admin/superadmin pueden insertar
CREATE POLICY "fotos_insert_admin" ON public.fotos
    FOR INSERT
    TO authenticated
    WITH CHECK (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    ));

-- 4️⃣ UPDATE: Solo admin/superadmin pueden actualizar
CREATE POLICY "fotos_update_admin" ON public.fotos
    FOR UPDATE
    TO authenticated
    USING (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    ))
    WITH CHECK (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    ));

-- 5️⃣ DELETE: Solo admin/superadmin pueden eliminar
CREATE POLICY "fotos_delete_admin" ON public.fotos
    FOR DELETE
    TO authenticated
    USING (EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    ));
```

#### Paso 1.3 - Verificar resultado

```sql
SELECT policyname FROM pg_policies WHERE tablename = 'fotos' ORDER BY policyname;
```

**Debe mostrar exactamente 5 políticas:**
- fotos_delete_admin
- fotos_insert_admin
- fotos_select_admin
- fotos_select_public
- fotos_update_admin

---

### **PARTE 2: Reparar Políticas del Storage**

#### Paso 2.1 - Eliminar políticas antiguas del bucket

```sql
-- Eliminar las políticas restrictivas en español
DROP POLICY IF EXISTS "Usuarios autenticados pueden actualizar archivos" ON storage.objects;
DROP POLICY IF EXISTS "Usuarios autenticados pueden eliminar archivos" ON storage.objects;
DROP POLICY IF EXISTS "Usuarios autenticados pueden subir archivos" ON storage.objects;
```

#### Paso 2.2 - Crear nuevas políticas con validación de roles

```sql
-- Política INSERT: Solo admin/superadmin pueden subir
CREATE POLICY "Admin puede subir al bucket archivos"
ON storage.objects
FOR INSERT
TO authenticated
WITH CHECK (
    bucket_id = 'archivos' AND
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    )
);

-- Política UPDATE: Solo admin/superadmin pueden actualizar
CREATE POLICY "Admin puede actualizar en bucket archivos"
ON storage.objects
FOR UPDATE
TO authenticated
USING (
    bucket_id = 'archivos' AND
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    )
);

-- Política DELETE: Solo admin/superadmin pueden eliminar
CREATE POLICY "Admin puede eliminar en bucket archivos"
ON storage.objects
FOR DELETE
TO authenticated
USING (
    bucket_id = 'archivos' AND
    EXISTS (
        SELECT 1 FROM public.user_roles
        WHERE user_id = auth.uid() AND role IN ('super_admin', 'admin')
    )
);

-- Política SELECT: Lectura pública
CREATE POLICY "Lectura pública de archivos"
ON storage.objects
FOR SELECT
USING (bucket_id = 'archivos');
```

---

### **PARTE 3: Actualizar Código del Controlador**

#### Archivo: `assets/js/controllers/galeriaController.js`

**Cambio en la línea ~373:**

Se agregó la captura del `user.id` y su asignación al insertar:

```javascript
// Obtener el user_id actual para asignar como owner
const { data: { user }, error: userError } = await window.supabaseClient.auth.getUser();

if (userError || !user) {
    throw new Error('No se pudo obtener el usuario actual');
}

// Insertar metadatos en la tabla fotos con owner asignado
const { data: insertData, error: insertError } = await window.supabaseClient
    .from('fotos')
    .insert([{ 
        titulo, 
        descripcion, 
        url: publicURL, 
        tipo: 'foto', 
        path,
        owner: user.id,      // ← AGREGADO
        publico: true        // ← AGREGADO
    }])
    .select();
```

---

## 📋 Checklist de Verificación

- ✅ Tabla `fotos` tiene exactamente 5 políticas RLS
- ✅ Storage bucket `archivos` tiene 4 políticas (INSERT, UPDATE, DELETE, SELECT)
- ✅ Ambas políticas validan rol en `user_roles`
- ✅ Super admin `leonardopenaanez@gmail.com` tiene rol `super_admin`
- ✅ Controlador envía `owner` y `publico` al insertar
- ✅ Se pueden subir fotos correctamente

---

## 🧪 Cómo Probar

1. **Iniciar sesión con super_admin:** `leonardopenaanez@gmail.com`
2. **Ir a la página principal**
3. **Hacer clic en botón "Agregar foto" (➕)**
4. **Rellenar formulario y subir una imagen**
5. **Verificar en consola (F12):**
   - ✅ "Archivo subido:" - Storage OK
   - ✅ "Metadata insertada:" - Base de datos OK

---

## 📝 Cambios en el Proyecto

### Archivos Modificados:
1. **`assets/js/controllers/galeriaController.js`**
   - Línea ~373: Agregar `owner` y `publico` al insertar

### Scripts SQL Creados:
1. **`docs/sql/fix-fotos-rls-admin.sql`**
   - Políticas limpias y correctas para tabla `fotos`

### Notas en Documentación:
- Este documento de solución

---

## 🔐 Seguridad Implementada

✅ **Solo admin/superadmin pueden:**
- Subir fotos
- Editar fotos
- Eliminar fotos

✅ **Todos pueden:**
- Ver fotos públicas (`publico = true`)

✅ **Admins pueden:**
- Ver fotos no públicas

---

## 🚀 Próximos Pasos (Recomendaciones)

1. **Documentar en README** que solo admins pueden subir fotos
2. **Considerar agregar más tipos de contenido** (videos, documentos) con las mismas políticas
3. **Crear interfaz de administración** para gestionar fotos (editar, eliminar)
4. **Agregar log de auditoría** de quién subió cada foto y cuándo

---

## 📞 Contacto / Dudas

Si el problema vuelve a ocurrir, revisar:
1. Que el usuario tenga rol `super_admin` o `admin` en tabla `user_roles`
2. Las políticas no se hayan duplicado nuevamente
3. El Storage bucket `archivos` exista y esté habilitado

---

**Solución realizada por:** GitHub Copilot  
**Última actualización:** 23 de mayo de 2026
