# 📱 Documentación de Implementación PWA — OurCorner

Esta guía técnica detalla la conversión integral de **OurCorner** en una **Progressive Web App (PWA) Premium**, instalable en Android, iOS y computadoras, con funcionamiento fuera de línea mediante IndexedDB, sincronización automática y notificaciones Web Push reales.

---

## 1. 📁 Resumen de Archivos Creados y Modificados

### Archivos Nuevos
| Archivo | Propósito |
| :--- | :--- |
| [`manifest.json`](file:///c:/laragon/www/OurCorner/manifest.json) | Manifiesto de la aplicación PWA con start_url y scope relativos para compatibilidad universal. |
| [`offline.html`](file:///c:/laragon/www/OurCorner/offline.html) | Página de respaldo fuera de línea con diseño romántico y autoreconexión al evento `online`. |
| [`service-worker.js`](file:///c:/laragon/www/OurCorner/service-worker.js) | Service Worker con precarga del App Shell, estrategias de caché diferenciadas y receptor Push. |
| [`assets/images/icons/icon-192.png`](file:///c:/laragon/www/OurCorner/assets/images/icons/icon-192.png) | Icono PWA estándar (192 × 192 px). |
| [`assets/images/icons/icon-512.png`](file:///c:/laragon/www/OurCorner/assets/images/icons/icon-512.png) | Icono PWA estándar de alta definición (512 × 512 px). |
| [`assets/images/icons/icon-maskable-512.png`](file:///c:/laragon/www/OurCorner/assets/images/icons/icon-maskable-512.png) | Icono PWA maskable (512 × 512 px) con zona de seguridad del 72% y fondo de relleno romántico. |
| [`assets/images/icons/favicon-64.png`](file:///c:/laragon/www/OurCorner/assets/images/icons/favicon-64.png) | Favicon de 64 × 64 px. |
| [`assets/js/pwa/pwa.js`](file:///c:/laragon/www/OurCorner/assets/js/pwa/pwa.js) | Núcleo del ciclo de vida PWA, registro del SW y carga modular asíncrona. |
| [`assets/js/pwa/offlineDB.js`](file:///c:/laragon/www/OurCorner/assets/js/pwa/offlineDB.js) | Almacén IndexedDB con aislamiento por usuario, borradores y cola de sincronización diferida. |
| [`assets/js/pwa/syncService.js`](file:///c:/laragon/www/OurCorner/assets/js/pwa/syncService.js) | Servicio de sincronización automática, Background Sync, reintentos e idempotencia. |
| [`assets/js/pwa/pushService.js`](file:///c:/laragon/www/OurCorner/assets/js/pwa/pushService.js) | Gestión de suscripciones Web Push, claves VAPID y despacho de alertas. |
| [`assets/js/pwa/pwaUI.js`](file:///c:/laragon/www/OurCorner/assets/js/pwa/pwaUI.js) | Interfaz visual (botón flotante de instalación, modal paso a paso para iOS y controles push). |
| [`supabase/migrations/create_push_subscriptions.sql`](file:///c:/laragon/www/OurCorner/supabase/migrations/create_push_subscriptions.sql) | Script SQL para crear la tabla de suscripciones con RLS y cascada. |
| [`docs/sql/create_push_subscriptions.sql`](file:///c:/laragon/www/OurCorner/docs/sql/create_push_subscriptions.sql) | Copia documentada de la migración SQL en la carpeta de documentación. |
| [`supabase/functions/send-push/index.ts`](file:///c:/laragon/www/OurCorner/supabase/functions/send-push/index.ts) | Edge Function de Supabase en Deno para emitir Web Push con firma VAPID y purga automática de endpoints muertos. |

### Archivos Modificados
* [`index.html`](file:///c:/laragon/www/OurCorner/index.html): Inyección de metadatos móviles, manifest, apple-touch-icon y `pwa.js`.
* [`views/calendario.html`](file:///c:/laragon/www/OurCorner/views/calendario.html): Metadatos PWA y respaldo de recuerdos en IndexedDB.
* [`views/pizarra.html`](file:///c:/laragon/www/OurCorner/views/pizarra.html): Metadatos PWA y auto-guardado de borradores de Blush Board en IndexedDB.
* [`views/mis-mensajes.html`](file:///c:/laragon/www/OurCorner/views/mis-mensajes.html): Metadatos PWA, cacheo de mensajes en IndexedDB y visualización offline amigable.
* [`views/login-Animation/login.html`](file:///c:/laragon/www/OurCorner/views/login-Animation/login.html): Metadatos PWA y scripts relativos `../../`.
* [`views/mensajes.html`](file:///c:/laragon/www/OurCorner/views/mensajes.html), [`views/Libreta.html`](file:///c:/laragon/www/OurCorner/views/Libreta.html), [`views/admin-panel.html`](file:///c:/laragon/www/OurCorner/views/admin-panel.html), [`views/sanvalentin.html`](file:///c:/laragon/www/OurCorner/views/sanvalentin.html), [`views/calendario-adviento.html`](file:///c:/laragon/www/OurCorner/views/calendario-adviento.html), [`views/Atardecer_Estrellado.html`](file:///c:/laragon/www/OurCorner/views/Atardecer_Estrellado.html), [`views/fuegos-artificiales.html`](file:///c:/laragon/www/OurCorner/views/fuegos-artificiales.html), [`views/music-player/index.html`](file:///c:/laragon/www/OurCorner/views/music-player/index.html): Metadatos e inicializador PWA.
* [`assets/js/controllers/mensajesController.js`](file:///c:/laragon/www/OurCorner/assets/js/controllers/mensajesController.js): Soporte para guardado sin conexión y encolado en `operaciones_pendientes`.

---

## 2. ⚙️ Configuración del Manifiesto PWA (`manifest.json`)

El manifiesto está configurado en la raíz con rutas relativas:
```json
{
  "name": "OurCorner",
  "short_name": "OurCorner",
  "description": "Página web romántica e interactiva con mensajes de amor, calendario compartido, reproductor de música y pizarra creativa para Rocío & Leo.",
  "lang": "es",
  "start_url": "./index.html",
  "scope": "./",
  "display": "standalone",
  "orientation": "portrait-primary",
  "background_color": "#fffafc",
  "theme_color": "#e63946",
  "icons": [
    { "src": "assets/images/icons/icon-192.png", "sizes": "192x192", "type": "image/png", "purpose": "any" },
    { "src": "assets/images/icons/icon-512.png", "sizes": "512x512", "type": "image/png", "purpose": "any" },
    { "src": "assets/images/icons/icon-maskable-512.png", "sizes": "512x512", "type": "image/png", "purpose": "maskable" }
  ]
}
```
* **Compatibilidad de Subrutas:** Al usar `./` en `start_url` y `scope`, funciona de manera idéntica tanto en `http://localhost/OurCorner/` (Laragon) como en `https://leolpa000.github.io/OurCorner/` (GitHub Pages) sin provocar errores 404.

---

## 3. 🛡️ Estrategias de Caché y Seguridad en el Service Worker

El Service Worker implementa 3 estrategias diferenciadas:
1. **Network First con fallback a `offline.html` (Navegación / Documentos HTML):**
   * Prioriza la versión más reciente desde la red.
   * Si la red falla, consulta la versión cacheada.
   * Si no existe en caché, devuelve `offline.html`.
2. **Cache First (Recursos Estáticos Locales):**
   * Para imágenes (`/assets/images/`, `/galeria/`), CSS y JavaScript local. Devuelve la versión en caché inmediatamente para máxima velocidad.
3. **Stale While Revalidate (CDNs y Fuentes Externas):**
   * Google Fonts, Bootstrap y Font Awesome se sirven al instante desde caché mientras se verifica en segundo plano si hay actualizaciones.
4. **Exclusión de Seguridad (Supabase Auth / REST / WebSockets):**
   * Cualquier petición a `*.supabase.co` o métodos `POST/PUT/DELETE` bypassan el Service Worker y viajan directos a la red. Nunca se almacenan tokens JWT ni datos privados en la caché HTTP del SW.

---

## 4. 🔑 Claves VAPID y Configuración de Supabase Secrets

### Par de Claves Criptográficas (P-256)
* **VAPID Public Key:**
  ```text
  BDhAhaqa9rY6h_ezVlDlJjbiCs_TeDQ6G7CkAPyGjyxHydZZqRvWtAIfL6MRWKCHY_taSSOT54V22D9AK_UlYpM
  ```
* **VAPID Private Key (Confidencial):**
  ```text
  r2Y34rFwxdCfQoLrRxPpfcqDrtojM3ql8ODfVb2EJIg
  ```

### Configuración en Supabase Secrets
Ejecuta el siguiente comando en tu terminal con Supabase CLI, o agrégalos en el panel web (**Settings > Edge Functions > Secrets**):

```bash
npx supabase secrets set VAPID_PUBLIC_KEY="BDhAhaqa9rY6h_ezVlDlJjbiCs_TeDQ6G7CkAPyGjyxHydZZqRvWtAIfL6MRWKCHY_taSSOT54V22D9AK_UlYpM"
npx supabase secrets set VAPID_PRIVATE_KEY="r2Y34rFwxdCfQoLrRxPpfcqDrtojM3ql8ODfVb2EJIg"
npx supabase secrets set VAPID_SUBJECT="mailto:ourcorner@love.local"
```

---

## 5. 🗄️ Aplicación de la Migración SQL en Supabase

Abre el **SQL Editor** de tu proyecto en el panel de Supabase y ejecuta el script contenido en [docs/sql/create_push_subscriptions.sql](file:///c:/laragon/www/OurCorner/docs/sql/create_push_subscriptions.sql):

```sql
CREATE TABLE IF NOT EXISTS public.push_subscriptions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    endpoint TEXT NOT NULL UNIQUE,
    p256dh TEXT NOT NULL,
    auth TEXT NOT NULL,
    user_agent TEXT,
    created_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now()),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT timezone('utc'::text, now())
);

ALTER TABLE public.push_subscriptions ENABLE ROW LEVEL SECURITY;

CREATE POLICY "push_subscriptions_select_own" ON public.push_subscriptions FOR SELECT TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "push_subscriptions_insert_own" ON public.push_subscriptions FOR INSERT TO authenticated WITH CHECK (auth.uid() = user_id);
CREATE POLICY "push_subscriptions_update_own" ON public.push_subscriptions FOR UPDATE TO authenticated USING (auth.uid() = user_id);
CREATE POLICY "push_subscriptions_delete_own" ON public.push_subscriptions FOR DELETE TO authenticated USING (auth.uid() = user_id);
```

---

## 6. 🚀 Despliegue de la Edge Function `send-push`

Si gestionas tu proyecto mediante Supabase CLI:

```bash
# Iniciar sesión en Supabase CLI (si no lo has hecho)
npx supabase login

# Vincular al proyecto remoto
npx supabase link --project-ref lrjbpnzkvueralkqrsfd

# Desplegar la función
npx supabase functions deploy send-push
```

---

## 7. 🌐 Despliegue en GitHub Pages

Para publicar la PWA en GitHub Pages:
1. Asegúrate de hacer commit y push a la rama principal:
   ```bash
   git add .
   git commit -m "feat: implementacion completa de PWA Premium, offline y Web Push"
   git push origin main
   ```
2. En GitHub: ve a **Settings > Pages > Source**:
   * Branch: `main` (o la rama de despliegue).
   * Folder: `/(root)`.
3. Guarda los cambios. En 1-2 minutos la PWA estará disponible bajo:
   `https://leolpa000.github.io/OurCorner/`

---

## 8. 🧪 Guía de Pruebas

### 8.1. Pruebas de Instalación
* **En Chrome / Edge (Escritorio o Android):**
  1. Abre la aplicación.
  2. Observa el botón flotante rosa en la esquina inferior izquierda: **"📲 Instalar OurCorner"**.
  3. Haz clic en el botón. Aparecerá el diálogo nativo de instalación.
  4. Pulsa "Instalar". La app se abrirá en su propia ventana sin barras del navegador.
  5. Comprueba que el botón desaparece una vez instalada.
* **En Safari (iOS - iPhone / iPad):**
  1. Abre la web en Safari.
  2. Pulsa el botón "📲 Instalar OurCorner".
  3. Se abrirá el modal explicativo indicando tocar el icono **Compartir** 📤 y luego **"Agregar a pantalla de inicio"** ➕.

### 8.2. Pruebas Fuera de Línea (Offline)
1. Con la aplicación abierta, abre las herramientas de desarrollo (**F12 > Network** o **Red**).
2. Marca la casilla **Offline** (o desconecta el Wi-Fi de tu equipo).
3. Navega a `views/pizarra.html`: dibuja trazos y comprueba que se guardan en el borrador local de IndexedDB.
4. Navega a `views/mis-mensajes.html`: comprueba que los mensajes previamente descargados se muestran con el distintivo:
   `📡 Modo sin conexión: Mostrando mensajes guardados localmente`.
5. Intenta abrir una vista no cacheada: el navegador servirá de respaldo [offline.html](file:///c:/laragon/www/OurCorner/offline.html).
6. Desmarca **Offline**: observa cómo aparece el aviso flotante *"Conexión reestablecida. Sincronizando..."* y la página se actualiza automáticamente.

### 8.3. Pruebas de Notificaciones Web Push
1. Inicia sesión con tu usuario.
2. Abre la campana de notificaciones o el menú de usuario.
3. Pulsa **"🔔 Activar avisos"**.
4. Acepta el permiso del navegador cuando lo solicite.
5. Comprueba en Supabase (**Table Editor > push_subscriptions**) que se ha creado un nuevo registro con tu `user_id`, `endpoint`, `p256dh` y `auth`.
6. Para enviar una notificación de prueba desde consola o mediante la Edge Function:
   ```javascript
   await window.pushService.sendPushNotification(window.authService.currentUser.id, {
       title: '¡Te amo! 💕',
       body: 'Probando notificación Web Push desde OurCorner',
       url: './views/mensajes.html'
   });
   ```
7. Cierra la pestaña o minimiza el navegador: la notificación llegará al centro de notificaciones de Windows, Android o macOS. Al hacer clic, enfocará o abrirá OurCorner.

---

## 9. 🔄 Actualización de la PWA

Cuando realices cambios futuros en el código:
1. Incrementa la constante `CACHE_VERSION` en [service-worker.js](file:///c:/laragon/www/OurCorner/service-worker.js):
   ```javascript
   const CACHE_VERSION = 'ourcorner-v1.0.1';
   ```
2. Al desplegar, el navegador detectará la nueva versión, la precargará en segundo plano y activará el Service Worker eliminando las cachés obsoletas mediante `clients.claim()`.

---

## 10. ❓ Solución de Errores Frecuentes

| Problema | Causa | Solución |
| :--- | :--- | :--- |
| El botón de instalar no aparece en escritorio. | La app ya está instalada o estás en modo incógnito. | Abre en una ventana normal de Chrome/Edge o desinstala la versión anterior desde los ajustes de aplicaciones del navegador. |
| Error al registrar suscripción Push: *"No se otorgaron permisos"*. | El usuario bloqueó las notificaciones en el navegador. | Haz clic en el candado junto a la URL en la barra del navegador, cambia Notificaciones a "Permitir" y recarga. |
| La Edge Function responde error 500: *"Configuración incompleta: VAPID..."*. | No se han configurado los secretos en Supabase. | Ejecuta `npx supabase secrets set VAPID_PUBLIC_KEY="..." VAPID_PRIVATE_KEY="..."`. |
| La página no carga sin conexión en GitHub Pages. | La URL base contiene subrutas absolutas (`/`). | Todas las rutas en `manifest.json`, `pwa.js` y `service-worker.js` usan rutas relativas (`./` o `../`), lo cual previene este error. |
