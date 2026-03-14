# 🔍 Sistema de IP Logger - Documentación Completa

## 📋 Descripción General

Sistema profesional de rastreo y análisis de visitantes web que captura información detallada de forma discreta y silenciosa. Diseñado para fines educativos y de análisis de seguridad.

## ⚠️ AVISO LEGAL IMPORTANTE

Este sistema debe usarse ÚNICAMENTE para:
- ✅ Análisis de tu propio sitio web
- ✅ Fines educativos y de aprendizaje
- ✅ Enseñar sobre seguridad y privacidad
- ✅ Debugging y análisis de tráfico legítimo

**NUNCA para:**
- ❌ Doxxing o acoso
- ❌ Rastreo sin consentimiento con fines maliciosos
- ❌ Ataques o vulneración de privacidad
- ❌ Violación de leyes de protección de datos

## 🏗️ Arquitectura del Sistema

### Componentes Principales

```
Sistema IP Logger
├── Backend (PHP)
│   └── ip-logger.php          # Servidor de captura y almacenamiento
├── Frontend (JavaScript)
│   └── ip-tracker.js          # Cliente de recopilación de datos
├── Panel de Control
│   └── ip-logger-panel.html   # Dashboard de visualización
└── Almacenamiento
    └── visitor-logs.json      # Base de datos JSON
```

## 📦 Instalación

### 1. Copiar archivos al proyecto

Los archivos ya están en su lugar:
- `/archivosPHP/ip-logger.php`
- `/assets/js/ip-tracker.js`
- `/views/ip-logger-panel.html`

### 2. Configurar permisos

```bash
# En Linux/Mac
chmod 777 assets/data/

# En Windows con Laragon, los permisos ya están configurados
```

### 3. Configurar clave secreta

Edita `ip-logger.php` línea 10:
```php
define('SECRET_KEY', 'TU_CLAVE_SUPER_SECRETA_123');
```

Y en `ip-logger-panel.html` línea 339:
```javascript
const SECRET_KEY = 'TU_CLAVE_SUPER_SECRETA_123';
```

## 🚀 Uso

### Implementación Básica (Automática)

Simplemente incluye el script en cualquier página HTML:

```html
<!DOCTYPE html>
<html>
<head>
    <title>Mi Página</title>
</head>
<body>
    <h1>Contenido normal</h1>
    
    <!-- Tracker silencioso al final del body -->
    <script src="/assets/js/ip-tracker.js"></script>
</body>
</html>
```

El tracker se ejecutará automáticamente 1 segundo después de que cargue la página, de forma completamente invisible.

### Implementación Manual

```javascript
// Crear instancia manualmente
const tracker = new IPTracker('/archivosPHP/ip-logger.php');

// Iniciar captura
tracker.iniciar();

// O solo obtener datos sin enviar
const datos = await tracker.obtenerDatos();
console.log(datos);
```

### Acceder al Panel de Control

1. Navega a: `http://localhost/OurCorner/views/ip-logger-panel.html`
2. El panel se cargará automáticamente con estadísticas
3. Actualización automática cada 30 segundos

## 📊 Datos Capturados

### Categoría: Red
- ✓ IP Pública
- ✓ IP Local (WebRTC)
- ✓ Hostname
- ✓ ISP (Proveedor de Internet)
- ✓ Organización/AS Number

### Categoría: Geolocalización
- ✓ País (código y nombre)
- ✓ Región/Estado
- ✓ Ciudad
- ✓ Código postal
- ✓ Coordenadas GPS (lat/lon)
- ✓ Zona horaria

### Categoría: Dispositivo
- ✓ Tipo (Móvil/Desktop/Tablet)
- ✓ Navegador y versión
- ✓ Sistema operativo
- ✓ Plataforma
- ✓ User Agent completo
- ✓ Detección de bots

### Categoría: Hardware
- ✓ Resolución de pantalla
- ✓ Profundidad de color
- ✓ Orientación de pantalla
- ✓ Soporte táctil
- ✓ Zoom/DPI
- ✓ Núcleos de CPU
- ✓ Memoria RAM
- ✓ Nivel de batería

### Categoría: Capacidades
- ✓ Plugins instalados
- ✓ Fuentes del sistema
- ✓ Cookies habilitadas
- ✓ Do Not Track
- ✓ Idiomas del navegador
- ✓ Tipo de conexión
- ✓ Velocidad de conexión

### Categoría: Fingerprints
- ✓ Canvas Fingerprint
- ✓ WebGL Vendor
- ✓ WebGL Renderer
- ✓ Audio Fingerprint
- ✓ Fingerprint único combinado

### Categoría: Navegación
- ✓ URL actual
- ✓ Referrer (de dónde vino)
- ✓ Protocolo HTTP
- ✓ Método de petición
- ✓ Puerto remoto

## 🎯 Funcionalidades del Panel

### Estadísticas en Tiempo Real
- Total de visitas
- Visitas de hoy
- IPs únicas
- Número de países

### Filtros Avanzados
- Por IP específica
- Por país
- Por tipo de dispositivo
- Búsqueda en tiempo real

### Visualización Detallada
- Tabla ordenada por fecha
- Vista detallada por visitante
- Todos los datos técnicos organizados

### Exportación
- Descarga CSV con todos los datos
- Compatible con Excel y Google Sheets

## 🛡️ Seguridad

### Protección del Panel

El panel está protegido con:
1. **Clave secreta**: Solo quien la conozca puede ver los datos
2. **Ubicación oculta**: No está en el index principal
3. **Sin enlaces públicos**: No aparece en navegación

### Recomendaciones

```php
// Agrega autenticación adicional si lo deseas
if (!isset($_SESSION['admin']) || $_SESSION['admin'] !== true) {
    die('Acceso denegado');
}
```

### Datos Sensibles

Los logs se guardan en:
```
/assets/data/visitor-logs.json
```

**Importante:**
- No compartas este archivo
- Añádelo a `.gitignore`
- Haz backups periódicos

## 🔧 Configuración Avanzada

### Cambiar límite de registros

En `ip-logger.php` línea 227:
```php
// Mantener solo los últimos 1000 registros
if (count($logs) > 1000) {
    $logs = array_slice($logs, -1000);
}
```

### Cambiar delay de inicio

En `ip-tracker.js` línea 294:
```javascript
setTimeout(() => {
    const tracker = new IPTracker();
    tracker.iniciar();
}, 1000); // 1000ms = 1 segundo
```

### Cambiar auto-actualización del panel

En `ip-logger-panel.html` línea 347:
```javascript
// Auto-actualizar cada 30 segundos
setInterval(cargarLogs, 30000); // 30000ms = 30 segundos
```

## 🎨 Personalización

### Cambiar colores del panel

```css
/* En ip-logger-panel.html */
body {
    background: linear-gradient(135deg, #tu_color1 0%, #tu_color2 100%);
}

.stat-number {
    color: #tu_color_principal;
}
```

### Agregar más estadísticas

```javascript
// En ip-logger-panel.html, función actualizarEstadisticas()
const navegadoresTop = {};
logsData.forEach(log => {
    navegadoresTop[log.navegador] = (navegadoresTop[log.navegador] || 0) + 1;
});
```

## 🧪 Testing

### Probar captura de datos

1. Abre cualquier página con el tracker
2. Abre la consola del navegador (F12)
3. Escribe:
```javascript
window.__tracker.obtenerDatos().then(d => console.log(d));
```

### Verificar almacenamiento

```bash
# Ver el archivo de logs
cat assets/data/visitor-logs.json

# O en Windows
type assets\data\visitor-logs.json
```

### Endpoint de prueba

```bash
# Hacer petición manual
curl http://localhost/OurCorner/archivosPHP/ip-logger.php

# Ver estadísticas
curl "http://localhost/OurCorner/archivosPHP/ip-logger.php?action=stats&key=TU_CLAVE"
```

## 📱 Uso desde otras páginas

### En tu proyecto principal

```html
<!-- En index.html -->
<script src="/assets/js/ip-tracker.js"></script>
```

### En subdirectorios

```html
<!-- En views/cualquier-pagina.html -->
<script src="../assets/js/ip-tracker.js"></script>
```

## 🔍 Detección y Contramedidas

### Cómo puede ser detectado:

1. **Revisar Network tab**: Se ve la petición POST
2. **Leer el código fuente**: El script es visible
3. **Analizar tráfico**: Las peticiones son visibles
4. **Extensiones de privacidad**: Pueden bloquear fingerprinting

### Hacerlo más discreto:

```javascript
// Minificar el código
// Usar nombres de variables ofuscados
// Hacer la petición parecer legítima (analytics, etc.)
```

### Contramedidas del usuario:

- VPN/Proxy oculta IP real
- Extensiones anti-fingerprinting
- Navegador Tor
- Bloqueadores de scripts
- Configuraciones de privacidad estrictas

## 🌐 APIs Externas Utilizadas

### IP-API.com
- **Endpoint**: `http://ip-api.com/json/{ip}`
- **Límite**: 45 peticiones/minuto
- **Datos**: Geolocalización completa
- **Gratis**: Sí (con límites)

### Alternativas (si necesitas más peticiones):

1. **ipapi.co** - 1,000/día gratis
2. **ipstack.com** - 100/mes gratis
3. **ipinfo.io** - 50,000/mes gratis

## 📈 Métricas y Analytics

### Datos útiles para análisis:

```javascript
// Dispositivos más usados
// Países con más visitas
// Horas pico de tráfico
// Navegadores más comunes
// ISPs de los visitantes
```

### Generar reportes:

El panel permite exportar a CSV para análisis en Excel o herramientas de BI.

## 🐛 Troubleshooting

### El tracker no captura datos

```javascript
// Verificar en consola
console.log(window.__tracker);
```

### El panel no muestra datos

1. Verificar que la clave secreta coincida
2. Comprobar que el archivo JSON existe
3. Ver errores en consola del navegador

### Errores de CORS

```php
// Ya incluido en ip-logger.php
header('Access-Control-Allow-Origin: *');
```

### Permisos de escritura

```bash
# Linux/Mac
chmod 777 assets/data/
chmod 666 assets/data/visitor-logs.json

# Windows: Click derecho > Propiedades > Seguridad > Permisos completos
```

## 🎓 Casos de Uso Educativos

### Enseñar sobre privacidad

Muestra a amigos/familiares cuánta información pueden capturar los sitios web.

### Demostrar fingerprinting

Explica cómo los sitios pueden rastrear sin cookies usando fingerprints únicos.

### Análisis de seguridad

Identifica qué información de tu red es visible públicamente.

### Concienciación

Ayuda a otros a:
- Usar VPNs
- Configurar privacidad en navegadores
- Entender riesgos de phishing/catfishing
- Ser más cuidadosos online

## 📚 Recursos Adicionales

### Documentación Técnica
- [Canvas Fingerprinting](https://browserleaks.com/canvas)
- [WebRTC Leaks](https://browserleaks.com/webrtc)
- [Device Fingerprinting](https://fingerprintjs.com/blog/)

### Privacidad y Protección
- [Privacy Badger](https://privacybadger.org/)
- [uBlock Origin](https://ublockorigin.com/)
- [Tor Browser](https://www.torproject.org/)

### Herramientas de Testing
- [BrowserLeaks](https://browserleaks.com/)
- [AmIUnique](https://amiunique.org/)
- [Cover Your Tracks](https://coveryourtracks.eff.org/)

## 🔮 Mejoras Futuras

- [ ] Base de datos MySQL/PostgreSQL
- [ ] Autenticación de usuarios
- [ ] Dashboard con gráficos (Chart.js)
- [ ] Alertas en tiempo real
- [ ] Integración con Google Analytics
- [ ] API REST completa
- [ ] Modo incógnito/anónimo
- [ ] Geolocalización en mapa interactivo
- [ ] Reportes automatizados por email

## 🤝 Contribuciones

Este es un proyecto educativo. Úsalo responsablemente y siempre respeta la privacidad de los demás.

---

**Recuerda**: Con gran poder viene gran responsabilidad. Usa este conocimiento para educar, no para dañar.

## 📄 Licencia

MIT - Uso educativo y ético únicamente.

---

*Última actualización: 28 de enero de 2026*
