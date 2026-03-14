# 🚀 IP Tracker con GitHub Pages + Supabase
## Guía de Instalación Completa

## ✅ Lo que acabas de obtener

Un sistema **profesional** de rastreo de visitantes que:

✅ Funciona en **GitHub Pages** (dominio público, no localhost)
✅ Guarda datos en **Supabase** (persistencia real en la nube)
✅ Panel accesible desde **cualquier dispositivo**
✅ Captura **máxima información posible**
✅ **100% discreto y silencioso**
✅ **Gratis para siempre**

---

## 📋 Paso 1: Configurar Supabase

### 1.1 Crear la tabla en Supabase

1. Ve a tu proyecto Supabase: https://supabase.com/dashboard
2. Selecciona tu proyecto `OurCorner`
3. Ve a **SQL Editor** (icono de base de datos)
4. Copia y pega TODO el contenido de este archivo:
   ```
   docs/sql/visitor-logs-setup.sql
   ```
5. Haz clic en **Run** (▶️)
6. Deberías ver: ✅ **Success. No rows returned**

### 1.2 Verificar que se creó la tabla

1. Ve a **Table Editor** (icono de tabla)
2. Deberías ver una nueva tabla llamada: `visitor_logs`
3. Haz clic en ella, estará vacía (aún no hay visitas)

### 1.3 Verificar políticas de seguridad (RLS)

1. En la tabla `visitor_logs`, ve a la pestaña **RLS** (Row Level Security)
2. Deberías ver 2 políticas activas:
   - ✅ `Permitir insertar logs públicamente`
   - ✅ `Permitir leer logs públicamente`

Si no aparecen, vuelve a ejecutar el SQL.

---

## 📤 Paso 2: Subir a GitHub

```bash
# Abre PowerShell en la carpeta del proyecto
cd c:\laragon\www\OurCorner

# Verificar archivos nuevos
git status

# Agregar todo
git add .

# Commit
git commit -m "Agregar IP Tracker con Supabase - Captura completa de visitantes"

# Subir a GitHub
git push origin main
```

### Esperar deployment

GitHub Pages tarda **1-2 minutos** en actualizar. Puedes ver el progreso en:
```
https://github.com/leolpa000/OurCorner/actions
```

---

## 🧪 Paso 3: Probar el Sistema

### 3.1 Probar desde tu PC (localhost) primero

1. Abre: `http://localhost/OurCorner/index.html`
2. Espera 2-3 segundos (el tracker se ejecuta automáticamente)
3. Abre la consola (F12) y deberías ver:
   ```
   🔍 Tracker activo (modo desarrollo)
   ✅ Datos guardados en Supabase
   ```

4. Ve a Supabase > Table Editor > `visitor_logs`
5. Deberías ver **tu primera visita registrada** con TODA tu información

### 3.2 Ver en el Panel

1. Abre: `http://localhost/OurCorner/views/ip-tracker-supabase-panel.html`
2. Deberías ver:
   - Estadísticas actualizadas
   - Tu visita en la tabla
   - Todos tus datos (IP, ubicación, dispositivo, etc.)

---

## 📱 Paso 4: Probar desde tu Celular

### 4.1 Abrir desde el celular

**IMPORTANTE:** Usa **datos móviles**, no WiFi de tu casa (para que la IP sea diferente)

1. Desde tu celular, abre:
   ```
   https://leolpa000.github.io/OurCorner/index.html
   ```

2. Navega normal, el tracker es **completamente invisible**
3. No verás NADA, trabaja en silencio

### 4.2 Ver los datos capturados

Desde cualquier dispositivo (PC, otro celular, tablet), abre:

```
https://leolpa000.github.io/OurCorner/views/ip-tracker-supabase-panel.html
```

**¡Deberías ver la visita desde tu celular!** Con:
- ✅ IP de tu operador móvil (Movistar, Claro, etc.)
- ✅ Tu ubicación (ciudad, coordenadas GPS)
- ✅ Modelo de celular (detectado)
- ✅ Android/iOS
- ✅ Navegador (Chrome, Safari)
- ✅ Resolución de pantalla
- ✅ ISP (proveedor)
- ✅ Fingerprints únicos
- ✅ Y mucho más...

---

## 📊 Información que Captura

### Categoría 1: Red
```
✓ IP Pública (tu IP de internet)
✓ IP Local (IP de tu WiFi/router)
✓ ISP (Movistar, Claro, Entel, etc.)
✓ ASN (Número de Sistema Autónomo)
```

### Categoría 2: Geolocalización
```
✓ País (ej: Perú)
✓ Código de país (PE)
✓ Región/Estado
✓ Ciudad exacta
✓ Código postal
✓ Coordenadas GPS (latitud, longitud)
✓ Zona horaria
```

### Categoría 3: Dispositivo
```
✓ Tipo: Móvil / Desktop / Tablet
✓ Navegador: Chrome, Firefox, Safari, etc.
✓ Sistema Operativo: Windows, Android, iOS, etc.
✓ Plataforma técnica
✓ User Agent completo
✓ Es móvil: Sí/No
```

### Categoría 4: Hardware
```
✓ Resolución de pantalla (ej: 1920x1080)
✓ Profundidad de color (ej: 24 bits)
✓ Núcleos de CPU (ej: 8 cores)
✓ Memoria RAM (ej: 8GB)
```

### Categoría 5: Configuración
```
✓ Idioma del navegador
✓ Todos los idiomas configurados
✓ Cookies habilitadas: Sí/No
✓ Do Not Track: activado/desactivado
✓ Zona horaria del sistema
```

### Categoría 6: Fingerprints (Únicos)
```
✓ Canvas Fingerprint (huella gráfica)
✓ WebGL Vendor (tarjeta gráfica)
✓ WebGL Renderer (modelo GPU)
✓ Fingerprint único combinado
```

### Categoría 7: Navegación
```
✓ URL actual (la página que visitó)
✓ URL Referrer (de dónde vino)
✓ Timestamp exacto (fecha y hora)
```

---

## 🎯 Comparación: Antes vs Ahora

| Característica | Versión PHP | Versión Supabase |
|----------------|-------------|------------------|
| **Funciona en GitHub Pages** | ❌ No | ✅ Sí |
| **Persistencia de datos** | Solo con backend | ✅ Supabase |
| **Ver desde cualquier dispositivo** | Solo con servidor | ✅ Sí |
| **Panel centralizado** | Requiere PHP | ✅ Sí |
| **Captura de información** | ✅ Completa | ✅ Completa |
| **Totalmente gratis** | Solo local | ✅ Sí |
| **Escalable** | Limitado | ✅ Miles de visitas |

---

## 🔐 Seguridad y Privacidad

### Políticas Configuradas

La tabla `visitor_logs` tiene políticas RLS configuradas para:

1. **Inserción pública:** Cualquiera puede registrar una visita (necesario para el tracker)
2. **Lectura pública:** Cualquiera puede ver los logs (para el panel)

### 🔒 Para Proteger el Panel (Opcional)

Si NO quieres que el panel sea público, modifica el SQL:

```sql
-- Eliminar la política pública
DROP POLICY "Permitir leer logs públicamente" ON visitor_logs;

-- Crear política solo para usuarios autenticados
CREATE POLICY "Permitir leer logs a usuarios autenticados" 
ON visitor_logs
FOR SELECT 
TO authenticated
USING (true);
```

Luego, en el panel HTML, agrega autenticación:

```javascript
// Verificar que el usuario esté logueado
const { data: { user } } = await supabase.auth.getUser();
if (!user) {
    window.location.href = '../views/login.html';
}
```

### Discreto por Diseño

El tracker es **invisible** porque:

1. No muestra ningún elemento en pantalla
2. Se ejecuta 1.5 segundos después de cargar (no bloquea)
3. Falla silenciosamente si hay error
4. Solo muestra mensajes en desarrollo (localhost)
5. Usa `console.debug` en vez de `console.log`

---

## 📍 Usar el Panel desde Cualquier Lugar

### URLs importantes:

**Sitio principal (con tracker):**
```
https://leolpa000.github.io/OurCorner/index.html
```

**Panel de visitantes (ver datos):**
```
https://leolpa000.github.io/OurCorner/views/ip-tracker-supabase-panel.html
```

**Desde el celular:**
- Guarda el enlace del panel en favoritos
- Ábrelo cuando quieras ver quién ha visitado tu sitio
- Se actualiza cada 30 segundos automáticamente

**Desde cualquier dispositivo:**
- PC, Mac, tablet, celular
- Cualquier navegador
- Incluso en modo incógnito (para ver datos, no afecta la captura)

---

## 🎓 Casos de Uso

### 1. Educación sobre Privacidad

Comparte tu sitio con amigos/familiares y luego muéstrales cuánta información dejaron:

```
1. Envías: https://leolpa000.github.io/OurCorner/index.html
2. Ellos visitan (sin saber que se rastrea)
3. Les muestras el panel con TODA su info
4. Les enseñas sobre:
   - Importancia de VPN
   - Configurar privacidad en navegadores
   - Riesgos de phishing
   - Ser cuidadosos online
```

### 2. Análisis de Tráfico

Ver de dónde vienen tus visitantes:
- Países más comunes
- Dispositivos más usados
- Horas pico de visitas
- ISPs más frecuentes

### 3. Detección de Visitantes Específicos

Si alguien visita tu sitio, sabrás:
- Su IP exacta
- Su ubicación aproximada
- Qué dispositivo usa
- Cuándo visitó

---

## 🔧 Configuración Avanzada

### Aumentar límite de visitas

Por defecto, el panel carga las últimas 500 visitas. Para cambiar:

Edita `ip-tracker-supabase-panel.html`, línea 316:

```javascript
.limit(500); // Cambiar por 1000, 2000, etc.
```

### Auto-actualización del panel

Por defecto se actualiza cada 30 segundos. Para cambiar:

Línea 289:

```javascript
setInterval(cargarLogs, 30000); // 30000ms = 30 segundos
```

### Desactivar en localhost

Si quieres que solo funcione en producción:

En `ip-tracker-supabase.js`, línea 359:

```javascript
function iniciarTracking() {
    // Solo en producción
    if (window.location.hostname === 'localhost') {
        console.log('Tracker desactivado en localhost');
        return;
    }
    
    // ... resto del código
}
```

---

## 📊 Análisis con Supabase

### Ver estadísticas directamente en Supabase

```sql
-- Visitas por país
SELECT pais, COUNT(*) as total
FROM visitor_logs
GROUP BY pais
ORDER BY total DESC;

-- Visitas por dispositivo
SELECT tipo_dispositivo, COUNT(*) as total
FROM visitor_logs
GROUP BY tipo_dispositivo;

-- Visitas por hora
SELECT 
    EXTRACT(HOUR FROM timestamp) as hora,
    COUNT(*) as visitas
FROM visitor_logs
GROUP BY hora
ORDER BY hora;

-- ISPs más comunes
SELECT isp, COUNT(*) as total
FROM visitor_logs
WHERE isp IS NOT NULL
GROUP BY isp
ORDER BY total DESC
LIMIT 10;
```

---

## 🚨 Troubleshooting

### No se guardan los datos

**Verificar:**

1. Tabla creada en Supabase:
   ```sql
   SELECT * FROM visitor_logs LIMIT 1;
   ```

2. Políticas RLS activas:
   - Ir a Table Editor > visitor_logs > RLS
   - Debe haber 2 políticas activas

3. Conexión a Supabase:
   - F12 en el navegador
   - Buscar errores en consola
   - Verificar que `supabaseClient` esté definido

### Panel muestra "Desconectado"

**Solución:**

1. Verificar que `supabase.js` esté cargado:
   ```html
   <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js/dist/umd/supabase.min.js"></script>
   <script src="../assets/js/config/supabase.js"></script>
   ```

2. Verificar credenciales en `config/supabase.js`

### No captura IP local

Esto es normal en algunos casos:
- Navegadores con privacidad estricta
- Extensiones de privacidad activas
- VPN activo
- WebRTC bloqueado

**Solución:** No hay. Es una limitación del navegador por seguridad.

### El tracker no se ejecuta

**Verificar en consola (F12):**

```javascript
// Debe mostrar el tracker
window.__tracker

// Si está undefined, verificar que el script esté cargado
document.querySelector('script[src*="ip-tracker-supabase.js"]')
```

---

## 📈 Métricas y KPIs

### Dashboard personalizado en Supabase

Puedes crear vistas personalizadas:

```sql
-- Vista de visitas diarias
CREATE VIEW visitas_diarias AS
SELECT 
    DATE(timestamp) as fecha,
    COUNT(*) as total,
    COUNT(DISTINCT ip_publica) as ips_unicas
FROM visitor_logs
GROUP BY DATE(timestamp)
ORDER BY fecha DESC;

-- Vista de top países
CREATE VIEW top_paises AS
SELECT 
    pais,
    COUNT(*) as visitas,
    COUNT(DISTINCT ip_publica) as ips_unicas
FROM visitor_logs
GROUP BY pais
ORDER BY visitas DESC;
```

---

## 🎉 ¡Ya está Todo Listo!

### Resumen de lo que tienes:

✅ **Tracker instalado** en tu sitio
✅ **Supabase configurado** con tabla y políticas
✅ **Panel web hermoso** para ver datos
✅ **Funciona en GitHub Pages** (dominio público)
✅ **Accesible desde cualquier dispositivo**
✅ **Captura máxima información posible**
✅ **100% discreto e invisible**

### Próximos pasos:

1. ✅ Ejecutar SQL en Supabase
2. ✅ Hacer `git push` a GitHub
3. ✅ Probar desde tu celular
4. ✅ Ver datos en el panel
5. ✅ Compartir con amigos para educación

---

## 🎓 Responsabilidad y Ética

**Recuerda:**

✅ Usar SOLO para educación y seguridad
✅ Enseñar a otros sobre privacidad
✅ Respetar las leyes de protección de datos
✅ Incluir política de privacidad en tu sitio

❌ NUNCA para:
- Doxxing o acoso
- Rastreo malicioso
- Violación de privacidad
- Actividades ilegales

---

## 📞 Soporte

Si tienes problemas:

1. Verifica que todos los archivos estén en su lugar
2. Revisa la consola del navegador (F12)
3. Verifica logs en Supabase
4. Asegúrate de que GitHub Pages esté activo

---

**¡Disfruta tu sistema profesional de rastreo!** 🚀

*Con gran poder viene gran responsabilidad.*

---

*Última actualización: 28 de enero de 2026*
