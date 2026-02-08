# 🎵 Solución de Problemas: Subida de Audio

## 📱 Error al subir archivos M4A desde celular

### Causas comunes y soluciones

#### 1️⃣ **No has iniciado sesión**
**Síntoma:** Error de autenticación al intentar subir
**Solución:** 
- Haz clic en el botón 🔐 "Iniciar Sesión" 
- Ingresa con tu cuenta
- Vuelve a intentar subir el archivo

#### 2️⃣ **Archivo muy grande**
**Síntoma:** Error después de seleccionar el archivo
**Solución:** 
- Tamaño máximo permitido: **50MB**
- Verifica el tamaño del archivo antes de subirlo
- Si es muy grande, usa una app para comprimirlo

#### 3️⃣ **Formato no reconocido**
**Síntoma:** El archivo no se acepta o da error de tipo MIME
**Solución:**
- Formatos permitidos: **MP3, WAV, OGG, M4A**
- Para M4A: el sistema detecta automáticamente el tipo correcto
- Si persiste el error, intenta convertir a MP3

#### 4️⃣ **Problemas de conexión**
**Síntoma:** Error de timeout o "no se pudo conectar"
**Solución:**
- Verifica tu conexión a internet
- Si usas datos móviles, asegúrate de tener buena señal
- Intenta nuevamente en unos minutos

#### 5️⃣ **Políticas de Supabase Storage**
**Síntoma:** Error "permission denied" o "policy violation"
**Solución:**
- Asegúrate de estar autenticado
- Verifica que las políticas de storage estén configuradas correctamente
- Ver: [storage-policies.sql](sql/storage-policies.sql)

---

## 🔧 Verificación técnica

### Tipos MIME aceptados para M4A:
- `audio/mp4` (estándar)
- `audio/x-m4a` (alternativo)
- `audio/m4a` (alternativo)

El sistema automáticamente detecta y asigna el tipo correcto.

### Configuración del bucket en Supabase:

```sql
-- El bucket debe permitir subida de archivos de usuarios autenticados
CREATE POLICY "Usuarios autenticados pueden subir archivos"
ON storage.objects FOR INSERT
TO authenticated
WITH CHECK (bucket_id = 'archivos');
```

---

## 📊 Logs útiles para debugging

Abre la consola del navegador (F12) y busca estos mensajes:

### ✅ Subida exitosa:
```
📤 Iniciando subida de archivo: cancion.m4a Tipo: audio/mp4 Tamaño: 3.5MB
📁 Path generado: musica/1234567890_cancion.m4a
📝 Content-Type: audio/mp4
✅ Archivo subido
🔗 URL pública: https://...
✅ Metadata insertada
```

### ❌ Error de autenticación:
```
❌ Error: JWT expired
🔐 Debes iniciar sesión para subir canciones
```

### ❌ Error de tamaño:
```
❌ El archivo es muy grande (75.5MB). Máximo: 50MB
```

---

## 🆘 Si nada funciona

1. **Cierra sesión** y vuelve a iniciar
2. **Limpia la caché** del navegador
3. **Intenta desde otro navegador** o dispositivo
4. **Verifica la consola** (F12) para ver el error exacto
5. **Contacta al administrador** con una captura del error

---

## ✨ Consejos para mejor experiencia

### Para archivos M4A en iPhone/iPad:
- Los archivos de voz de WhatsApp están en formato M4A ✅
- Las grabaciones de Notas de Voz de iOS están en M4A ✅
- La música de Apple Music puede estar protegida ❌

### Conversión de archivos:
Si necesitas convertir archivos, usa:
- **Online:** [CloudConvert](https://cloudconvert.com/) (gratis)
- **Android:** "Media Converter" app
- **iOS:** "Audio Converter" app
- **PC:** Audacity (gratis)

### Compresión de archivos:
Si tu archivo es muy grande:
- Reduce el bitrate a 128kbps o 192kbps
- Usa formato MP3 en lugar de WAV
- Los archivos M4A ya son comprimidos (similar a MP3)

---

## 📝 Registro de cambios

**v1.0** (8 Feb 2026)
- ✅ Soporte completo para M4A
- ✅ Validación de tamaño (máx 50MB)
- ✅ Detección automática de tipo MIME
- ✅ Mensajes de error descriptivos
- ✅ Vista previa de tamaño y duración
