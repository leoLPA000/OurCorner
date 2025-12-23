# 💕 NuestroMes - Integración con Supabase

## ✅ Estado de la Integración

**¡Integración completada exitosamente!** 🎉

Todas las funcionalidades del sitio ahora están conectadas a Supabase para almacenamiento persistente y sincronización en la nube.

---

## 📋 Componentes Integrados

### 1. Sistema de Música (`js/musica.js`)
- ✅ Carga de playlist desde la tabla `canciones`
- ✅ Upload de archivos de audio al bucket `archivos`
- ✅ Inserción automática de metadata tras subir
- ✅ Eliminación de canciones (DB + Storage)
- ✅ Fallback a localStorage si Supabase no está disponible

### 2. Galería de Fotos (`js/galeria.js`)
- ✅ Carga de fotos desde la tabla `fotos`
- ✅ Upload de imágenes al bucket `archivos`
- ✅ Inserción automática de metadata tras subir
- ✅ Eliminación de fotos (DB + Storage)
- ✅ Fallback a localStorage si Supabase no está disponible

### 3. Base de Datos (Supabase)
- ✅ Tabla `canciones` (id, titulo, artista, url, path, tipo, owner, publico, creado_en)
- ✅ Tabla `fotos` (id, titulo, descripcion, url, path, tipo, owner, publico, creado_en)
- ✅ Tabla `mensajes` (id, autor, texto, privado, referencia_tipo, referencia_id, creado_en)
- ✅ Políticas RLS temporales para acceso anónimo (solo desarrollo)

### 4. Storage (Supabase)
- ✅ Bucket `archivos` (público)
- ✅ Estructura: `/musica/` y `/fotos/`
- ✅ Políticas: INSERT, SELECT, DELETE, UPDATE para rol `anon`
- ✅ Límite: 25MB por archivo
- ✅ Tipos MIME permitidos: audio/*, image/*, etc.

---

## 🚀 Cómo Usar

### Agregar Música
1. Haz clic en el botón `➕` del reproductor
2. Selecciona el archivo de audio (MP3, WAV, OGG, M4A)
3. Ingresa el título y artista
4. Haz clic en "Guardar Canción"
5. ✅ El archivo se sube a Supabase Storage y la metadata se guarda en la tabla `canciones`

### Agregar Fotos
1. Haz clic en el botón `➕` (botón flotante de administración)
2. Selecciona la imagen
3. Ingresa título, fecha y descripción
4. Haz clic en "Guardar Foto"
5. ✅ La imagen se sube a Supabase Storage y la metadata se guarda en la tabla `fotos`

### Eliminar Contenido
- **Música**: En la playlist, haz clic en 🗑️ junto a la canción personalizada
- **Fotos**: En la galería ampliada, haz clic en el botón "🗑️ Eliminar" (solo fotos personalizadas)

---

## 🔧 Configuración Actual

### Archivos de Configuración
- **`js/supabaseConfig.js`**: Credenciales y cliente Supabase
  - URL del proyecto: `https://lrjbpnzkvueralkqrsfd.supabase.co`
  - Anon key: configurada (no exponer en repos públicos)

### Políticas de Seguridad (Desarrollo)
⚠️ **IMPORTANTE**: Las políticas actuales permiten acceso anónimo completo.

```sql
-- Ejemplo de políticas actuales (temporales)
CREATE POLICY canciones_select_all ON public.canciones FOR SELECT USING (true);
CREATE POLICY canciones_insert_temp ON public.canciones FOR INSERT WITH CHECK (true);
CREATE POLICY canciones_delete_temp ON public.canciones FOR DELETE USING (true);

-- Storage: políticas similares para bucket 'archivos'
```

**Estas políticas son solo para pruebas** y no deben usarse en producción sin autenticación.

---

## ⚠️ Advertencias de Seguridad

### Para Uso Personal/Privado
Como esta es una web personal para ti y tu pareja (sin login), las políticas abiertas funcionan **PERO**:

1. **No subas `js/supabaseConfig.js` a GitHub públicamente** — añádelo a `.gitignore`
2. **Limita el acceso mediante URL oculta** — no compartas la URL públicamente
3. **Monitorea el uso en Supabase Console** — revisa regularmente Storage y Database
4. **Configura alertas de cuota** — en Supabase Console → Settings → Usage & Billing
5. **Considera autenticación simple** — incluso un password hardcodeado en el frontend es mejor que nada

### Para Migrar a Producción (futuro)
Si decides hacer el sitio público o más seguro:

1. **Implementa Supabase Auth**:
   ```javascript
   const { user, error } = await supabaseClient.auth.signUp({
     email: 'email@example.com',
     password: 'password'
   });
   ```

2. **Cambia las políticas RLS** para requerir autenticación:
   ```sql
   -- Solo usuarios autenticados
   CREATE POLICY canciones_insert_auth ON public.canciones
     FOR INSERT
     WITH CHECK (auth.role() = 'authenticated');
   
   -- Solo el owner puede eliminar
   CREATE POLICY canciones_delete_owner ON public.canciones
     FOR DELETE
     USING (owner::text = auth.uid());
   ```

3. **Usa service_role en backend** — mueve uploads a un endpoint PHP/Node que valide y use la service_role key

---

## 📂 Estructura de Archivos

```
nuestroMes/
├── js/
│   ├── supabaseConfig.js       # Configuración y cliente Supabase
│   ├── musica.js                # Reproductor con integración Supabase
│   └── galeria.js               # Galería con integración Supabase
├── supabase-setup.sql           # Script SQL para crear tablas y políticas
├── SUPABASE-STORAGE-POLICIES.md # Guía de configuración de Storage
├── test-supabase.html           # Página de prueba de conexión
└── README-SUPABASE.md           # Este archivo
```

---

## 🧪 Pruebas y Verificación

### Test Rápido de Conexión
Abre `http://localhost/pro/nuestroMes/test-supabase.html` para verificar:
- ✅ Cliente Supabase inicializado
- ✅ Inserción en tabla `canciones`
- ✅ Upload a bucket `archivos`
- ✅ Inserción de metadata

### Test en Consola del Navegador
```javascript
// Verificar cliente
console.log('Cliente:', !!window.supabaseClient);

// Listar canciones
await window.supabaseClient.from('canciones').select('*');

// Listar fotos
await window.supabaseClient.from('fotos').select('*');

// Listar buckets
await window.supabaseClient.storage.listBuckets();
```

---

## 🐛 Solución de Problemas

### Error: "new row violates row-level security policy"
- **Causa**: Políticas de Storage no configuradas
- **Solución**: Sigue la guía en `SUPABASE-STORAGE-POLICIES.md`

### Error: "supabaseClient is not defined"
- **Causa**: Orden incorrecto de scripts en HTML
- **Solución**: Asegúrate de cargar en este orden:
  1. `supabase.min.js` (CDN)
  2. `js/supabaseConfig.js`
  3. `js/musica.js` / `js/galeria.js`

### Las fotos/canciones no aparecen
- **Causa**: Error de carga desde Supabase
- **Solución**: Abre consola (F12) y revisa errores; verifica las políticas RLS

### Archivos muy grandes no se suben
- **Causa**: Límite de 25MB por archivo
- **Solución**: Reduce el tamaño del archivo o ajusta el límite en Storage → Buckets → archivos → Settings

---

## 📊 Monitoreo y Mantenimiento

### Revisar Uso de Supabase
1. Ve a [Supabase Console](https://supabase.com/dashboard)
2. Selecciona tu proyecto
3. Ve a "Settings" → "Usage & Billing"
4. Revisa:
   - Database size
   - Storage size
   - API requests
   - Bandwidth

### Limpiar Archivos de Prueba
```javascript
// En consola del navegador (http://localhost/pro/nuestroMes/)

// Listar archivos en /pruebas/
const { data } = await window.supabaseClient.storage.from('archivos').list('pruebas');
console.log(data);

// Eliminar archivos de prueba
await window.supabaseClient.storage.from('archivos').remove(['pruebas/test-....txt']);
```

### Backup de Base de Datos
- Supabase ofrece backups automáticos diarios
- Para backup manual: Database → Backups → Create Backup

---

## 🎉 ¡Listo para Usar!

Tu sitio "NuestroMes" ahora está completamente integrado con Supabase. Disfruta de:

- ✅ Almacenamiento en la nube
- ✅ Sincronización automática
- ✅ Sin límites de localStorage
- ✅ Acceso desde cualquier dispositivo
- ✅ Fallback local si hay problemas de conexión

**¡Que disfruten su sitio romántico!** 💕🎵📸

---

## 📞 Soporte

- **Documentación Supabase**: https://supabase.com/docs
- **Supabase Storage**: https://supabase.com/docs/guides/storage
- **Supabase Database**: https://supabase.com/docs/guides/database

---

*Última actualización: 6 de noviembre de 2025*
