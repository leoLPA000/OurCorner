# 📝 Sistema de Firmas Sincronizadas con JSONBin.io

## 🔑 Credenciales

**API Key (X-Master-Key):**
```
$2a$10$CEizI6AbZejb3vGYqCZ6v.pOnwA3rIk.LyY4B.zzDSCkYgtWKJjWG
```

**Dashboard:** https://jsonbin.io/app/dashboard
**Email registrado:** Tu email de registro

---

## 📚 ¿Qué es JSONBin.io?

JSONBin.io es un servicio gratuito que permite almacenar archivos JSON en la nube y accederlos mediante API REST.

**Plan Gratuito:**
- ✅ 10,000 requests/mes
- ✅ Almacenamiento ilimitado de bins
- ✅ Sin tarjeta de crédito
- ✅ API key permanente

---

## 🎯 Caso de Uso: Firmas Sincronizadas

### Problema Resuelto
Las firmas/dedicatorias en la libreta se guardaban en `localStorage`, lo que significa que:
- ❌ Solo el usuario que escribió podía ver su firma
- ❌ No se sincronizaban entre dispositivos
- ❌ Otras personas no podían ver las firmas

### Solución con JSONBin
Con JSONBin, las firmas se guardan en un archivo JSON en la nube:
- ✅ Todos los usuarios ven las mismas firmas
- ✅ Sincronización automática cada 30 segundos
- ✅ Backup en localStorage por si falla la conexión

---

## 🛠️ Implementación Técnica

### Archivo de Configuración
**Ubicación:** `assets/js/config/jsonbin.js`

```javascript
const JSONBIN_CONFIG = {
  masterKey: '$2a$10$CEizI6AbZejb3vGYqCZ6v.pOnwA3rIk.LyY4B.zzDSCkYgtWKJjWG',
  binId: null,
  apiUrl: 'https://api.jsonbin.io/v3'
};
```

### Estructura de Datos
```json
{
  "evento1": "Texto de la firma para Calendario de Adviento",
  "evento2": "Texto de la firma para Fuegos Artificiales",
  "evento3": "Texto de la firma para Atardecer Estrellado",
  "evento4": "Texto de la firma para Próximamente"
}
```

### Funciones Principales

**1. Crear Bin (primera vez)**
```javascript
await FirmasSync.crearBin();
```

**2. Cargar Firmas**
```javascript
const firmas = await FirmasSync.cargarFirmas();
// Retorna: { evento1: "texto", evento2: "texto", ... }
```

**3. Guardar Firma Individual**
```javascript
await FirmasSync.guardarFirmaIndividual('evento1', 'Mi firma aquí');
// Guarda con debounce de 2 segundos
```

**4. Guardar Todas las Firmas**
```javascript
await FirmasSync.guardarFirmas({
  evento1: "Firma 1",
  evento2: "Firma 2",
  evento3: "Firma 3",
  evento4: "Firma 4"
});
```

---

## 🔄 Flujo de Sincronización

### Al Abrir la Libreta
1. Se carga el archivo jsonbin.js
2. Se intenta cargar las firmas desde JSONBin
3. Si falla, se usa localStorage como fallback
4. Las firmas se muestran en los textareas

### Al Escribir una Firma
1. Se guarda inmediatamente en localStorage (backup)
2. Se espera 2 segundos después de que el usuario deje de escribir
3. Se envía la actualización a JSONBin
4. Se confirma en consola: `✅ Firma evento1 sincronizada`

### Actualización Automática
- Cada 30 segundos se consulta JSONBin por cambios
- Si hay cambios y el usuario NO está escribiendo, se actualiza
- Se muestra en consola: `🔄 Firma evento1 actualizada desde el servidor`

---

## 📊 API Endpoints Usados

### 1. Crear Bin (POST)
```
POST https://api.jsonbin.io/v3/b
Headers:
  Content-Type: application/json
  X-Master-Key: $2a$10$CE...

Body:
{
  "evento1": "",
  "evento2": "",
  "evento3": "",
  "evento4": ""
}
```

### 2. Leer Bin (GET)
```
GET https://api.jsonbin.io/v3/b/{binId}/latest
Headers:
  X-Master-Key: $2a$10$CE...
```

### 3. Actualizar Bin (PUT)
```
PUT https://api.jsonbin.io/v3/b/{binId}
Headers:
  Content-Type: application/json
  X-Master-Key: $2a$10$CE...

Body:
{
  "evento1": "Nueva firma",
  "evento2": "Otra firma",
  ...
}
```

---

## 💡 Cómo Re-implementar en el Futuro

### 1. Agregar Script en HTML
```html
<script src="../assets/js/config/jsonbin.js"></script>
```

### 2. HTML de las Firmas
```html
<div class="firma-section">
  <label class="firma-label">💝 Tu firma o dedicatoria:</label>
  <textarea class="firma-input" rows="2" placeholder="Escribe aquí..."></textarea>
</div>
```

### 3. JavaScript para Sincronización
```javascript
$('.firma-input').each(function(index) {
  const eventoId = `evento${index + 1}`;
  const $textarea = $(this);
  
  // Cargar firmas al iniciar
  FirmasSync.cargarFirmas().then(firmas => {
    if (firmas && firmas[eventoId]) {
      $textarea.val(firmas[eventoId]);
    }
  });
  
  // Guardar al escribir
  $textarea.on('input', function() {
    const texto = $(this).val();
    localStorage.setItem(`firma-${eventoId}`, texto);
    FirmasSync.guardarFirmaIndividual(eventoId, texto);
  });
});

// Auto-actualización cada 30s
setInterval(async () => {
  const firmas = await FirmasSync.cargarFirmas();
  if (firmas) {
    $('.firma-input').each(function(index) {
      const eventoId = `evento${index + 1}`;
      if (!$(this).is(':focus') && firmas[eventoId]) {
        $(this).val(firmas[eventoId]);
      }
    });
  }
}, 30000);
```

---

## 🚀 Ventajas

1. **Sincronización en tiempo real** - Todos ven lo mismo
2. **Sin base de datos** - Solo archivos JSON
3. **Gratis para siempre** - 10,000 requests/mes
4. **Fácil de implementar** - Solo 3 líneas de código
5. **Compatible con GitHub Pages** - 100% frontend
6. **Backup automático** - localStorage como fallback

---

## ⚠️ Limitaciones

- Solo para datos pequeños (textos, no archivos grandes)
- No es una base de datos relacional (no hay consultas complejas)
- Límite de 10,000 requests/mes (más que suficiente para uso personal)

---

## 🔒 Seguridad

**IMPORTANTE:** La API key está expuesta en el código JavaScript del cliente. Esto está bien para este proyecto porque:

1. ✅ Es un proyecto personal/romántico (bajo riesgo)
2. ✅ Solo guarda firmas/dedicatorias (no datos sensibles)
3. ✅ JSONBin permite revocar y regenerar la key si es necesario
4. ✅ El plan gratuito tiene límite de requests (protección contra abuso)

Para proyectos más grandes, considera usar un backend que oculte la API key.

---

## 📖 Referencias

- **Sitio oficial:** https://jsonbin.io
- **Documentación API:** https://jsonbin.io/api-reference
- **Dashboard:** https://jsonbin.io/app/dashboard

---

## 🎓 Alternativas Similares

Si necesitas otras opciones en el futuro:

1. **GitHub Gists API** - Gratis, usa tu cuenta de GitHub
2. **Supabase Storage** - Ya lo tienes configurado, almacenamiento de archivos
3. **Firebase Realtime Database** - Sincronización en tiempo real
4. **localStorage + P2P** - Con WebRTC para sincronizar entre dispositivos

---

**Documentado:** 28 de enero de 2026  
**Estado:** Implementado y probado ✅  
**Archivo de código:** `assets/js/config/jsonbin.js`
