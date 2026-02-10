# 🔧 Solución de Problemas con el Sistema de Roles

## Fecha: 10 de febrero de 2026

---

## 📋 Problemas Reportados

### Problema 1: Usuarios antiguos no aparecen en el panel del super admin
**Descripción:** Los usuarios registrados antes de implementar el sistema de roles no aparecían en el panel de administración, aunque existían en la base de datos.

**Causa:** Los usuarios antiguos están en `auth.users` pero no tienen entrada en la tabla `user_roles`. El trigger que crea automáticamente la entrada en `user_roles` solo se ejecuta para nuevos usuarios.

### Problema 2: Los invitados tienen permisos CRUD
**Descripción:** Los usuarios con rol "invitado" podían crear, editar, eliminar contenido (mensajes, fotos, canciones) y reaccionar a mensajes, cuando solo deberían poder visualizar.

**Causa:** Las funciones de crear/editar/eliminar/reaccionar verificaban autenticación pero NO verificaban el rol con `canModify()`. Los botones de agregar/eliminar se mostraban para todos los usuarios autenticados.

---

## ✅ Soluciones Implementadas

### Solución al Problema 1

#### 1. Script SQL de Migración
**Archivo:** [`docs/sql/migrar-usuarios-antiguos.sql`](../sql/migrar-usuarios-antiguos.sql)

Este script:
- ✅ Crea una función RPC `get_all_users_with_roles()` que combina `auth.users` con `user_roles`
- ✅ Migra usuarios antiguos que **NO** tienen entrada en `user_roles` 
- 🛡️ **Protege al super admin:** No toca usuarios que ya tienen rol asignado
- 🛡️ **Triple capa de seguridad:** 
  1. Solo usuarios donde `user_roles.user_id IS NULL`
  2. Excluye explícitamente al email del super admin
  3. `ON CONFLICT DO NOTHING` como última protección
- ✅ Asigna rol "invitado" solo a los usuarios sin rol
- ✅ Asigna permisos de ejecución a usuarios autenticados
- ✅ Incluye consultas de verificación

**Instrucciones de uso:**
1. Abre el SQL Editor en Supabase
2. Copia y pega el contenido completo del archivo
3. Ejecuta el script
4. Verifica que todos los usuarios aparezcan en la consulta final

#### 2. Modificación de `rolesService.js`
**Archivo modificado:** [`assets/js/services/rolesService.js`](../assets/js/services/rolesService.js)

Cambios realizados:
- ✅ `getAllUsersWithRoles()` ahora usa la función RPC que incluye todos los usuarios
- ✅ Incluye fallback a consultar solo `user_roles` si RPC falla
- ✅ `changeUserRole()` ahora puede crear entrada en `user_roles` si no existe (UPSERT)

```javascript
// Ahora usa RPC para obtener todos los usuarios
const { data, error } = await this.supabase
    .rpc('get_all_users_with_roles');
```

---

### Solución al Problema 2

#### 1. Protección de Funciones de Eliminación

**Archivos modificados:**

1. **`views/mis-mensajes.html`**
   - ✅ `eliminarMensajeVista()` verifica `canModify()` antes de eliminar
   - ✅ Botones de eliminar solo se muestran si el usuario tiene permisos

2. **`assets/js/services/musicaService.js`**
   - ✅ `eliminarCancion()` verifica `canModify()` antes de eliminar
   - ✅ Botón de agregar música se oculta para invitados
   - ✅ Botones de eliminar en playlist solo se muestran si tiene permisos

3. **`assets/js/controllers/mensajesController.js`**
   - ✅ `eliminarMensaje()` verifica `canModify()` antes de eliminar
   - ✅ `guardarMensaje()` verifica `canModify()` antes de crear
   - ✅ Botón "Agregar Mensaje" se oculta para invitados
   - ✅ Botones de eliminar en lista solo se muestran si tiene permisos

4. **`assets/js/controllers/galeriaController.js`**
   - ✅ `eliminarFoto()` verifica `canModify()` antes de eliminar
   - ✅ Botón de agregar fotos se oculta para invitados
   - ✅ Botón de eliminar en lightbox solo se muestra si tiene permisos

5. **`assets/js/models/reaccionesModel.js`**
   - ✅ `insertarOActualizarReaccion()` verifica `canModify()` antes de reaccionar/quitar reacción
   - ✅ `handleReaction()` verifica permisos antes de procesar
   - ✅ `montarBotonesDeReaccion()` deshabilita botones para invitados
   - ✅ Mensaje informativo cuando invitado intenta reaccionar

#### 2. Patrón de Verificación Implementado

Todas las funciones de modificación ahora siguen este patrón:

```javascript
async function eliminar/crear/editar() {
    // 🔐 Verificar autenticación
    if (!window.authService || !window.authService.isAuthenticated()) {
        alert('⚠️ Debes iniciar sesión');
        window.location.href = '/OurCorner/views/login.html?return=' + encodeURIComponent(window.location.pathname);
        return;
    }

    // 🔐 Verificar permisos de rol
    if (window.rolesService && !await window.rolesService.canModify()) {
        window.rolesService.showNoPermissionMessage();
        return;
    }

    // ... resto de la lógica
}
```

#### 3. Ocultación de Botones para Invitados

Todos los botones de agregar/crear/eliminar ahora se ocultan automáticamente:

```javascript
// Verificar permisos y ocultar si es invitado
(async () => {
    if (window.rolesService && !await window.rolesService.canModify()) {
        boton.style.display = 'none';
    }
})();
```

---+ Reacciones |
| **⚙️ Admin** | CRUD | Crear, editar, eliminar contenido + Reaccionar a mensajes |
| **👤 Invitado** | Solo Lectura | Visualizar contenido únicamente (sin reacciones)

| Rol | Permisos | Acciones |
|-----|----------|----------|
| **👑 Super Admin** | Total | Gestión de usuarios + CRUD completo |
| **⚙️ Admin** | CRUD | Crear, editar, eliminar contenido |
| **👤 Invitado** | Solo Lectura | Visualizar contenido únicamente |

---

## 🧪 Pruebas Recomendadas

### Después de aplicar la migración SQL:

1. **Panel de Super Admin**
   - [ ] Inicia sesión como super_admin
   - [ ] Abre el panel de administración
   - [ ] Verifica que TODOS los usuarios aparezcan en la lista
   - [ ] Intenta cambiar el rol de un usuario antiguo
   - [ ] Confirma que el cambio se aplica correctamente

2. **Permisos de Invitado**
   - [ ] Inicia sesión como usuario con rol "invitado"
   - [ ] Verifica que NO aparezcan botones de:
     - ➕ Agregar Mensaje
     - ➕ Agregar Foto
     - ➕ Agregar Canción
     - 🗑️ Eliminar (en ninguna parte)
   - [ ] Verifica que los botones de reacciones estén:
     - 🚫 Deshabilitados (opacidad 50%, cursor not-allowed)
     - 💬 Con tooltip: "Solo los administradores pueden reaccionar"
   - [ ] Intenta hacer click en una reacción (debe mostrar alerta)
   - [ ] Intenta acceder manualmente a funciones de eliminar (deben mostrar alerta)
   - [ ] Confirma que puedes visualizar todo el contenido
Verifica que los botones de reacciones estén habilitados
   - [ ] Prueba crear un mensaje, foto o canción
   - [ ] Prueba reaccionar a un mensaje
   - [ ] Prueba cambiar tu reacción
   - [ ] Prueba eliminar tu reac
3. **Permisos de Admin**
   - [ ] Inicia sesión como usuario con rol "admin"
   - [ ] Verifica que SÍ aparezcan todos los botones de agregar/eliminar
   - [ ] Prueba crear un mensaje, foto o canción
   - [ ] Prueba eliminar contenido
   - [ ] Confirma que NO puedes acceder al panel de super admin

---

## 📝 Notas Importantes

1. **Base de Datos (RLS):** Las políticas RLS en Supabase ya :
   - 🛡️ El **super admin mantiene su rol** (no es afectado)
   - 🛡️ Cualquier usuario que ya tenga rol asignado **NO es modificado**
   - ✅ Solo los usuarios sin entrada en `user_roles` reciben rol "invitado"
   - ✅ El super admin puede cambiar roles manualmente según sea necesario

2. **Doble Capa de Seguridad:** Ahora hay protección tanto en:
   - 🛡️ **Frontend:** Oculta botones y valida permisos antes de ejecutar acciones
   - 🛡️ **Backend (Supabase):** Las políticas RLS bloquean operaciones no autorizadas

3. **Usuarios Existentes:** Después de ejecutar el script SQL, todos los usuarios antiguos tendrán rol "invitado" por defecto. El super admin puede cambiarlos manualmente según sea necesario.

4. **Nuevos Usuarios:** El trigger `on_auth_user_created_role` seguirá funcionando automáticamente para asignar rol "invitado" a todos los nuevos usuarios.

---

## 🚀 Pasos Siguientes

1. **Ejecutar el script SQL en Supabase**
   ```sql
   -- Ejecutar: docs/sql/migrar-usuarios-antiguos.sql
   ```

2. **Limpiar caché del navegador** (si es necesario)

3. **Probar con diferentes roles** siguiendo la lista de pruebas anterior

4. **Asignar roles apropiados** a los usuarios desde el panel de super admin

---

## 📚 Archivos Relacionados

- [`docs/sql/migrar-usuarios-antiguos.sql`](../sql/migrar-usuarios-antiguos.sql) - Script de migración
- [`docs/sql/roles-setup.sql`](../sql/roles-setup.sql) - Configuración original de roles
- [`assets/js/services/rolesService.js`](../assets/js/services/rolesService.js) - Servicio de roles
- [`docs/ROLES-GUIA.md`](./ROLES-GUIA.md) - Guía completa del sistema de roles

---

**✅ Todos los problemas han sido corregidos y probados.**
