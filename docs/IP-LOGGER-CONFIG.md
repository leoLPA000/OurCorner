# Configuración del Sistema IP Logger

## 🔐 Seguridad

### Clave Secreta
**IMPORTANTE**: Cambia estas claves por valores únicos y seguros.

```php
// En archivosPHP/ip-logger.php (línea 10)
define('SECRET_KEY', 'cambiar_por_clave_segura_' . md5(__FILE__));
```

```javascript
// En views/ip-logger-panel.html (línea 339)
const SECRET_KEY = 'cambiar_por_clave_segura_aqui';
```

### Generar Clave Segura

```javascript
// Ejecuta esto en la consola del navegador para generar una clave:
Array.from(crypto.getRandomValues(new Uint8Array(32)))
  .map(b => b.toString(16).padStart(2, '0'))
  .join('');
```

O usa este generador online: https://generate-random.org/encryption-key-generator

## 📁 Estructura de Archivos

```
OurCorner/
├── archivosPHP/
│   └── ip-logger.php              # Backend de captura
├── assets/
│   ├── js/
│   │   └── ip-tracker.js          # Cliente JavaScript
│   └── data/
│       └── visitor-logs.json      # Base de datos (auto-creado)
├── views/
│   ├── ip-logger-panel.html       # Panel de control
│   └── ip-logger-demo.html        # Página de demostración
└── docs/
    ├── IP-LOGGER-DOCS.md          # Documentación completa
    └── IP-LOGGER-CONFIG.md        # Este archivo
```

## 🚀 Configuración Rápida

### Paso 1: Configurar Clave Secreta

1. Abre `archivosPHP/ip-logger.php`
2. En la línea 10, cambia: `'tu_clave_secreta_aqui_'` por tu clave
3. Abre `views/ip-logger-panel.html`
4. En la línea 339, cambia: `'tu_clave_secreta_aqui_'` por la MISMA clave

### Paso 2: Verificar Permisos

```bash
# Linux/Mac
chmod 777 assets/data/
chmod 666 assets/data/visitor-logs.json

# Windows (Laragon)
# Los permisos suelen estar bien por defecto
```

### Paso 3: Probar el Sistema

1. Visita: `http://localhost/OurCorner/views/ip-logger-demo.html`
2. Espera 2-3 segundos
3. Abre el panel: `http://localhost/OurCorner/views/ip-logger-panel.html`
4. Deberías ver tu visita registrada

## ⚙️ Opciones de Configuración

### Límite de Registros

Cambia cuántos registros guardar:

```php
// En ip-logger.php línea 227
if (count($logs) > 1000) {  // Cambia 1000 por tu límite
    $logs = array_slice($logs, -1000);
}
```

### Delay de Inicio del Tracker

Cambia cuándo se activa el rastreo:

```javascript
// En ip-tracker.js línea 294
setTimeout(() => {
    const tracker = new IPTracker();
    tracker.iniciar();
}, 1000);  // Cambia 1000 (1 segundo) por el delay que quieras
```

### Auto-actualización del Panel

```javascript
// En ip-logger-panel.html línea 347
setInterval(cargarLogs, 30000);  // Cambia 30000 (30 seg) por tu intervalo
```

### API de Geolocalización

Por defecto usa `ip-api.com` (gratis, 45 req/min)

Para cambiar a otra API, edita en `ip-logger.php` línea 48:

```php
// Alternativa 1: ipapi.co (1000/día gratis)
$url = "https://ipapi.co/{$ip}/json/";

// Alternativa 2: ipstack.com (requiere API key)
$api_key = 'TU_API_KEY';
$url = "http://api.ipstack.com/{$ip}?access_key={$api_key}";

// Alternativa 3: ipinfo.io
$token = 'TU_TOKEN';
$url = "https://ipinfo.io/{$ip}?token={$token}";
```

## 📊 Configurar Base de Datos

### Por defecto: JSON

El sistema usa archivos JSON. No requiere configuración.

### Migrar a MySQL (Opcional)

Si necesitas más rendimiento, puedes migrar a MySQL:

```sql
CREATE TABLE visitor_logs (
    id VARCHAR(50) PRIMARY KEY,
    timestamp DATETIME,
    ip_publica VARCHAR(45),
    pais VARCHAR(100),
    ciudad VARCHAR(100),
    navegador VARCHAR(100),
    sistema_operativo VARCHAR(100),
    datos_completos JSON,
    INDEX idx_timestamp (timestamp),
    INDEX idx_ip (ip_publica)
);
```

Luego modifica `ip-logger.php` para usar PDO en lugar de archivos.

## 🎨 Personalización del Panel

### Cambiar Colores

```css
/* En ip-logger-panel.html, dentro de <style> */

/* Gradiente principal */
body {
    background: linear-gradient(135deg, #TU_COLOR1 0%, #TU_COLOR2 100%);
}

/* Color de estadísticas */
.stat-number {
    color: #TU_COLOR_PRINCIPAL;
}

/* Encabezados de tabla */
.log-table th {
    background: #TU_COLOR_PRINCIPAL;
}
```

### Agregar Logo

```html
<!-- En ip-logger-panel.html, dentro de .header -->
<div class="header">
    <img src="../assets/images/tu-logo.png" alt="Logo" style="height: 50px;">
    <h1>Tu Título Personalizado</h1>
</div>
```

## 🔧 Integración con el Proyecto

### Opción 1: Global (Todas las páginas)

Agrega al final de cada HTML:

```html
<script src="/assets/js/ip-tracker.js"></script>
</body>
</html>
```

### Opción 2: Solo páginas específicas

```html
<!-- Solo en las páginas que quieras rastrear -->
<?php if ($rastrear_visitante): ?>
    <script src="/assets/js/ip-tracker.js"></script>
<?php endif; ?>
```

### Opción 3: Condicional

```javascript
// Solo rastrear si cumple condiciones
if (window.location.hostname !== 'localhost') {
    const script = document.createElement('script');
    script.src = '/assets/js/ip-tracker.js';
    document.body.appendChild(script);
}
```

## 🛡️ Configuración de Privacidad

### Modo Anónimo

Para no guardar IPs reales:

```php
// En ip-logger.php, función obtenerIPReal()
function obtenerIPReal() {
    // ... código existente ...
    
    // Anonimizar IP (ocultar últimos octetos)
    $ip = $_SERVER['REMOTE_ADDR'] ?? 'desconocida';
    $partes = explode('.', $ip);
    return $partes[0] . '.' . $partes[1] . '.' . $partes[2] . '.0';
}
```

### Respetar Do Not Track

```javascript
// En ip-tracker.js, función iniciar()
async iniciar() {
    // Respetar Do Not Track
    if (navigator.doNotTrack === '1') {
        console.log('Do Not Track activado, no rastrear');
        return;
    }
    
    // ... resto del código ...
}
```

## 📝 Política de Privacidad

**IMPORTANTE**: Si usas esto en producción, DEBES informar a los usuarios.

Ejemplo de texto para política de privacidad:

```
RECOPILACIÓN DE DATOS

Este sitio web recopila automáticamente cierta información técnica
con fines de análisis y seguridad, incluyendo:
- Dirección IP
- Información del navegador y dispositivo
- Ubicación aproximada (país/ciudad)
- Datos técnicos del sistema

Esta información se utiliza únicamente para:
- Análisis de tráfico web
- Seguridad y prevención de fraude
- Mejora de la experiencia del usuario

No vendemos ni compartimos esta información con terceros.
Puedes solicitar eliminación de tus datos en: [tu-email]
```

## 🔍 Debugging

### Ver datos en consola

```javascript
// En el navegador, presiona F12 y escribe:
window.__tracker.obtenerDatos().then(d => console.log(d));
```

### Ver logs en servidor

```bash
# Ver últimas 10 entradas
tail -n 10 assets/data/visitor-logs.json

# Ver en tiempo real
tail -f assets/data/visitor-logs.json
```

### Probar endpoint directamente

```bash
# GET simple
curl http://localhost/OurCorner/archivosPHP/ip-logger.php

# Ver estadísticas
curl "http://localhost/OurCorner/archivosPHP/ip-logger.php?action=stats&key=TU_CLAVE"

# Ver todos los logs
curl "http://localhost/OurCorner/archivosPHP/ip-logger.php?action=view&key=TU_CLAVE"
```

## 🚨 Troubleshooting

### Error: No se guardan los datos

1. Verifica permisos de carpeta `assets/data/`
2. Comprueba que el archivo JSON existe y es escribible
3. Revisa errores PHP en: `c:\laragon\logs\apache_error.log`

### Error: Panel no muestra datos

1. Verifica que las claves secretas coincidan
2. Abre la consola del navegador (F12) y busca errores
3. Comprueba la URL del API_ENDPOINT

### Error: CORS

Si usas subdominios o dominios diferentes:

```php
// En ip-logger.php después de la línea 7
header('Access-Control-Allow-Origin: https://tu-dominio.com');
header('Access-Control-Allow-Methods: POST, GET, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');
```

### Rendimiento lento

Si tienes miles de registros:

1. Aumenta memoria PHP: `memory_limit = 256M` en php.ini
2. Considera migrar a base de datos MySQL
3. Implementa paginación en el panel
4. Archiva logs antiguos periódicamente

## 📦 Backup y Mantenimiento

### Backup automático

```bash
# Script de backup (Linux/Mac)
#!/bin/bash
DATE=$(date +%Y%m%d)
cp assets/data/visitor-logs.json backups/visitor-logs-$DATE.json
```

```powershell
# Script de backup (Windows)
$fecha = Get-Date -Format "yyyyMMdd"
Copy-Item "assets\data\visitor-logs.json" "backups\visitor-logs-$fecha.json"
```

### Limpiar logs antiguos

```php
// Agregar en ip-logger.php
function limpiarLogsAntiguos($dias = 30) {
    $logs = json_decode(file_get_contents(LOG_FILE), true);
    $limite = time() - ($dias * 24 * 60 * 60);
    
    $logs = array_filter($logs, function($log) use ($limite) {
        return $log['timestamp_unix'] > $limite;
    });
    
    file_put_contents(LOG_FILE, json_encode($logs, JSON_PRETTY_PRINT));
}
```

## 🌐 Despliegue en Producción

### Lista de verificación:

- [ ] Cambiar SECRET_KEY por una clave segura
- [ ] Configurar HTTPS (SSL)
- [ ] Actualizar política de privacidad
- [ ] Configurar backups automáticos
- [ ] Limitar acceso al panel (autenticación)
- [ ] Configurar rate limiting en el servidor
- [ ] Probar en diferentes navegadores
- [ ] Verificar compatibilidad móvil
- [ ] Configurar monitoreo de errores
- [ ] Documentar para tu equipo

### .htaccess para proteger datos

```apache
# Proteger archivos sensibles
<Files "visitor-logs.json">
    Order Allow,Deny
    Deny from all
</Files>

# Proteger el panel
<Files "ip-logger-panel.html">
    AuthType Basic
    AuthName "Área Restringida"
    AuthUserFile /ruta/completa/.htpasswd
    Require valid-user
</Files>
```

## 📞 Soporte

Si tienes problemas:

1. Lee la [documentación completa](IP-LOGGER-DOCS.md)
2. Revisa la consola del navegador (F12)
3. Verifica logs de PHP en Laragon
4. Prueba en modo incógnito del navegador

---

**Recuerda**: Usa este sistema de forma ética y responsable. Siempre respeta la privacidad de los usuarios.

*Última actualización: 28 de enero de 2026*
