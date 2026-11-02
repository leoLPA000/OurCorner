/**
 * 🚀 SERVICE WORKER - OurCorner PWA
 * Versión: 1.0.0
 * 
 * Estrategias implementadas:
 * - Network First con fallback a offline.html para documentos HTML.
 * - Cache First para recursos estáticos versionados (imágenes, CSS, JS locales).
 * - Stale While Revalidate para CDNs y fuentes externas seguras.
 * - Exclusión estricta de peticiones sensibles (Supabase Auth, REST, Storage privado y WebSockets).
 * - Gestión de eventos Web Push y Notification Click.
 */

const CACHE_VERSION = 'ourcorner-v1.0.0';
const STATIC_CACHE = `ourcorner-static-${CACHE_VERSION}`;
const PAGES_CACHE = `ourcorner-pages-${CACHE_VERSION}`;
const ASSETS_CACHE = `ourcorner-assets-${CACHE_VERSION}`;

const CURRENT_CACHES = [STATIC_CACHE, PAGES_CACHE, ASSETS_CACHE];

// Archivos esenciales del "App Shell" para precachear en la instalación
const PRECACHE_URLS = [
    './',
    './index.html',
    './offline.html',
    './manifest.json',
    './assets/css/estilos.css',
    './assets/css/menu-flotante.css',
    './assets/css/boton-navidad.css',
    './assets/js/pwa/pwa.js',
    './assets/js/pwa/offlineDB.js',
    './assets/js/pwa/syncService.js',
    './assets/js/pwa/pushService.js',
    './assets/js/pwa/pwaUI.js',
    './assets/images/icons/icon-192.png',
    './assets/images/icons/icon-512.png',
    './assets/images/icons/icon-maskable-512.png',
    './assets/images/icons/favicon-64.png',
    './galeria/icono.png',
    './views/pizarra.html',
    './views/mis-mensajes.html',
    './views/mensajes.html',
    './views/calendario.html'
];

// Dominios o rutas que NUNCA deben almacenarse en la caché HTTP del SW
const EXCLUDED_HOSTS = [
    'supabase.co'
];

// ============================================================================
// 1. INSTALACIÓN
// ============================================================================
self.addEventListener('install', (event) => {
    console.log('[SW] Instalando Service Worker versión:', CACHE_VERSION);

    event.waitUntil(
        caches.open(STATIC_CACHE)
            .then(async (cache) => {
                console.log('[SW] Precargando App Shell esencial...');
                // Usar Promise.allSettled para que si un recurso falla no aborte toda la instalación
                const results = await Promise.allSettled(
                    PRECACHE_URLS.map(async (url) => {
                        try {
                            const response = await fetch(url, { cache: 'no-cache' });
                            if (response && response.ok) {
                                return await cache.put(url, response);
                            }
                        } catch (err) {
                            console.warn('[SW] No se pudo precachear:', url, err.message);
                        }
                    })
                );
                console.log('[SW] Precarga completada.');
            })
            .then(() => self.skipWaiting())
    );
});

// ============================================================================
// 2. ACTIVACIÓN Y LIMPIEZA DE CACHÉS ANTIGUAS
// ============================================================================
self.addEventListener('activate', (event) => {
    console.log('[SW] Activando nueva versión:', CACHE_VERSION);

    event.waitUntil(
        caches.keys()
            .then((keys) => {
                return Promise.all(
                    keys.map((key) => {
                        if (!CURRENT_CACHES.includes(key)) {
                            console.log('[SW] Eliminando caché obsoleta:', key);
                            return caches.delete(key);
                        }
                    })
                );
            })
            .then(() => self.clients.claim())
    );
});

// ============================================================================
// 3. ESTRATEGIAS DE FETCH
// ============================================================================
self.addEventListener('fetch', (event) => {
    const { request } = event;
    const url = new URL(request.url);

    // 1. Ignorar métodos no GET
    if (request.method !== 'GET') {
        return;
    }

    // 2. Ignorar protocolos no HTTP/HTTPS (ej. chrome-extension://)
    if (!url.protocol.startsWith('http')) {
        return;
    }

    // 3. SEGURIDAD: Excluir Supabase Auth, REST API y Storage privado
    // Las peticiones autenticadas nunca deben compartirse ni guardarse en el SW cache
    const isSupabaseRequest = EXCLUDED_HOSTS.some(host => url.hostname.includes(host));
    if (isSupabaseRequest) {
        // Petición directa a la red sin interceptar ni almacenar en caché
        return;
    }

    // 4. ESTRATEGIA A: Documentos HTML / Navegación (Network First -> Cache -> offline.html)
    if (request.mode === 'navigate' || request.destination === 'document') {
        event.respondWith(networkFirstNavigation(request));
        return;
    }

    // 5. ESTRATEGIA B: Fuentes y CDNs externos (Stale While Revalidate)
    const isCDN = url.hostname.includes('googleapis.com') ||
                  url.hostname.includes('gstatic.com') ||
                  url.hostname.includes('jsdelivr.net') ||
                  url.hostname.includes('cdnjs.cloudflare.com');

    if (isCDN) {
        event.respondWith(staleWhileRevalidate(request, ASSETS_CACHE));
        return;
    }

    // 6. ESTRATEGIA C: Recursos estáticos locales (Cache First -> Network)
    // Imágenes, CSS, JS locales, audio
    if (['style', 'script', 'image', 'font', 'audio'].includes(request.destination) ||
        url.pathname.includes('/assets/') ||
        url.pathname.includes('/galeria/')) {
        event.respondWith(cacheFirst(request, STATIC_CACHE));
        return;
    }

    // Por defecto: Network First
    event.respondWith(networkFirst(request, ASSETS_CACHE));
});

// ----------------------------------------------------------------------------
// Implementación de Estrategias
// ----------------------------------------------------------------------------

/**
 * Network First para navegación con respaldo de offline.html
 */
async function networkFirstNavigation(request) {
    try {
        const networkResponse = await fetch(request);
        if (networkResponse && networkResponse.status === 200) {
            const cache = await caches.open(PAGES_CACHE);
            cache.put(request, networkResponse.clone());
        }
        return networkResponse;
    } catch (error) {
        console.log('[SW] Fallo de red en navegación, buscando en caché:', request.url);
        const cachedResponse = await caches.match(request);
        if (cachedResponse) {
            return cachedResponse;
        }

        // Si la página específica no está en caché, servir la página offline
        console.log('[SW] Sirviendo página offline de respaldo');
        const offlinePage = await caches.match('./offline.html');
        return offlinePage || new Response('Sin conexión a Internet', {
            status: 503,
            statusText: 'Service Unavailable',
            headers: new Headers({ 'Content-Type': 'text/plain; charset=utf-8' })
        });
    }
}

/**
 * Cache First: busca en caché; si no está, pide a red y almacena
 */
async function cacheFirst(request, cacheName) {
    const cachedResponse = await caches.match(request);
    if (cachedResponse) {
        return cachedResponse;
    }

    try {
        const networkResponse = await fetch(request);
        if (networkResponse && networkResponse.status === 200) {
            const cache = await caches.open(cacheName);
            cache.put(request, networkResponse.clone());
        }
        return networkResponse;
    } catch (err) {
        // En caso de fallo de red para un recurso no en caché
        return new Response('', { status: 408, statusText: 'Request Timeout' });
    }
}

/**
 * Stale While Revalidate: sirve caché de inmediato y actualiza en segundo plano
 */
async function staleWhileRevalidate(request, cacheName) {
    const cache = await caches.open(cacheName);
    const cachedResponse = await cache.match(request);

    const networkFetch = fetch(request)
        .then((networkResponse) => {
            if (networkResponse && networkResponse.status === 200) {
                cache.put(request, networkResponse.clone());
            }
            return networkResponse;
        })
        .catch(() => null);

    return cachedResponse || networkFetch;
}

/**
 * Network First genérico
 */
async function networkFirst(request, cacheName) {
    try {
        const networkResponse = await fetch(request);
        if (networkResponse && networkResponse.status === 200) {
            const cache = await caches.open(cacheName);
            cache.put(request, networkResponse.clone());
        }
        return networkResponse;
    } catch (err) {
        const cachedResponse = await caches.match(request);
        if (cachedResponse) {
            return cachedResponse;
        }
        throw err;
    }
}

// ============================================================================
// 4. NOTIFICACIONES WEB PUSH
// ============================================================================
self.addEventListener('push', (event) => {
    console.log('[SW] Evento push recibido');

    let data = {
        title: 'OurCorner 💕',
        body: 'Tienes una nueva actualización en Nuestro Nidito',
        icon: './assets/images/icons/icon-192.png',
        badge: './assets/images/icons/favicon-64.png',
        url: './index.html',
        tag: 'ourcorner-general'
    };

    if (event.data) {
        try {
            const json = event.data.json();
            data = { ...data, ...json };
        } catch (e) {
            data.body = event.data.text() || data.body;
        }
    }

    const options = {
        body: data.body,
        icon: data.icon || './assets/images/icons/icon-192.png',
        badge: data.badge || './assets/images/icons/favicon-64.png',
        tag: data.tag || 'ourcorner-notification',
        renotify: true,
        vibrate: [100, 50, 100],
        data: {
            url: data.url || './index.html',
            timestamp: Date.now()
        },
        actions: data.actions || [
            { action: 'open', title: 'Abrir OurCorner' }
        ]
    };

    event.waitUntil(
        self.registration.showNotification(data.title, options)
    );
});

// Manejar clic en la notificación
self.addEventListener('notificationclick', (event) => {
    event.notification.close();

    const targetUrl = event.notification.data?.url || './index.html';

    event.waitUntil(
        clients.matchAll({ type: 'window', includeUncontrolled: true })
            .then((clientList) => {
                // Si ya hay una ventana abierta de OurCorner, enfocarla
                for (const client of clientList) {
                    if ('focus' in client) {
                        if (client.url.includes('OurCorner') || client.url.includes(self.registration.scope)) {
                            client.navigate(targetUrl);
                            return client.focus();
                        }
                    }
                }
                // Si no hay ventana abierta, abrir una nueva
                if (clients.openWindow) {
                    return clients.openWindow(targetUrl);
                }
            })
    );
});

// Sincronización en segundo plano (Background Sync API)
self.addEventListener('sync', (event) => {
    if (event.tag === 'sync-pending-operations') {
        console.log('[SW] Background sync activado para operaciones pendientes');
        event.waitUntil(
            self.clients.matchAll({ type: 'window' }).then((clients) => {
                clients.forEach((client) => {
                    client.postMessage({ type: 'BACKGROUND_SYNC_TRIGGERED' });
                });
            })
        );
    }
});

// Mensajería con clientes (páginas)
self.addEventListener('message', (event) => {
    if (event.data && event.data.type === 'SKIP_WAITING') {
        self.skipWaiting();
    }
});
