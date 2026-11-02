/**
 * 📱 PWA CORE MANAGER - OurCorner
 * Gestor centralizado del ciclo de vida PWA, Service Worker e instalación.
 * Compatible con GitHub Pages (subrutas /OurCorner/) y entornos locales (Laragon).
 */

(function () {
    'use strict';

    // Determinar la ruta relativa a la raíz del proyecto según la ubicación de la página actual
    function getRootRelativePath() {
        const path = window.location.pathname;
        if (path.includes('/views/login-Animation/') || 
            path.includes('/views/music-player/') || 
            path.includes('/views/menu/')) {
            return '../../';
        }
        if (path.includes('/views/')) {
            return '../';
        }
        return './';
    }

    const rootPrefix = getRootRelativePath();

    class PWAManager {
        constructor() {
            this.deferredPrompt = null;
            this.isInstalled = false;
            this.swRegistration = null;
            this.rootPrefix = rootPrefix;

            this.init();
        }

        init() {
            this.checkInstallationMode();
            this.registerServiceWorker();
            this.setupInstallPrompt();
            this.loadDependencies();
            this.setupAuthHooks();
        }

        async loadDependencies() {
            const modules = [
                'assets/js/pwa/offlineDB.js',
                'assets/js/pwa/syncService.js',
                'assets/js/pwa/pushService.js',
                'assets/js/pwa/pwaUI.js'
            ];

            for (const mod of modules) {
                const src = `${this.rootPrefix}${mod}`;
                await this.loadScript(src);
            }
        }

        loadScript(src) {
            return new Promise((resolve) => {
                if (document.querySelector(`script[src="${src}"]`)) {
                    return resolve();
                }
                const script = document.createElement('script');
                script.src = src;
                script.async = false;
                script.onload = () => resolve();
                script.onerror = () => {
                    // Silencioso si aún no se ha creado el archivo en la fase actual
                    resolve();
                };
                document.head.appendChild(script);
            });
        }

        setupAuthHooks() {
            // Escuchar cierre de sesión para purgar datos privados en IndexedDB
            let lastUserId = null;
            if (window.supabaseClient && window.supabaseClient.auth) {
                window.supabaseClient.auth.getSession().then(({ data: { session } }) => {
                    if (session?.user) lastUserId = session.user.id;
                });

                window.supabaseClient.auth.onAuthStateChange((event, session) => {
                    if (event === 'SIGNED_OUT' && lastUserId) {
                        console.log('🔒 [PWA] Cierre de sesión detectado, ejecutando purga segura');
                        if (window.offlineDB) {
                            window.offlineDB.limpiarDatosUsuario(lastUserId);
                        }
                        lastUserId = null;
                    } else if (session?.user) {
                        lastUserId = session.user.id;
                    }
                });
            }
        }

        // Comprueba si la aplicación se está ejecutando como PWA (standalone)
        checkInstallationMode() {
            const isStandalone = window.matchMedia('(display-mode: standalone)').matches ||
                                 window.navigator.standalone === true ||
                                 document.referrer.includes('android-app://');
            this.isInstalled = isStandalone;
            if (isStandalone) {
                console.log('📱 [PWA] Ejecutando en modo standalone (instalada)');
            }
        }

        get isIOS() {
            return /iPad|iPhone|iPod/.test(navigator.userAgent) && !window.MSStream;
        }

        // Registro del Service Worker
        async registerServiceWorker() {
            if (!('serviceWorker' in navigator)) {
                console.warn('⚠️ [PWA] Service Workers no soportados en este navegador');
                return;
            }

            try {
                // Registrar el Service Worker desde la raíz relativa
                const swUrl = `${this.rootPrefix}service-worker.js`;
                const registration = await navigator.serviceWorker.register(swUrl, {
                    scope: this.rootPrefix
                });

                this.swRegistration = registration;
                console.log('✅ [PWA] Service Worker registrado con éxito. Scope:', registration.scope);

                // Detectar actualización disponible
                registration.addEventListener('updatefound', () => {
                    const newWorker = registration.installing;
                    if (!newWorker) return;

                    newWorker.addEventListener('statechange', () => {
                        if (newWorker.state === 'installed' && navigator.serviceWorker.controller) {
                            console.log('🔄 [PWA] Nueva versión disponible');
                            window.dispatchEvent(new CustomEvent('pwa-update-available', {
                                detail: { registration }
                            }));
                        }
                    });
                });

            } catch (error) {
                console.error('❌ [PWA] Error al registrar Service Worker:', error);
            }
        }

        // Capturar evento beforeinstallprompt para instalación personalizada
        setupInstallPrompt() {
            window.addEventListener('beforeinstallprompt', (e) => {
                // Prevenir el banner automático intrusivo del navegador
                e.preventDefault();
                this.deferredPrompt = e;
                console.log('💡 [PWA] Evento beforeinstallprompt capturado');

                // Notificar a la UI que la app es instalable
                window.dispatchEvent(new CustomEvent('pwa-installable', {
                    detail: { prompt: e }
                }));
            });

            window.addEventListener('appinstalled', () => {
                this.deferredPrompt = null;
                this.isInstalled = true;
                console.log('🎉 [PWA] Aplicación instalada exitosamente');
                window.dispatchEvent(new CustomEvent('pwa-installed'));
            });
        }

        // Disparar el diálogo de instalación nativo
        async promptInstall() {
            if (!this.deferredPrompt) {
                if (this.isIOS) {
                    return {
                        success: false,
                        isIOS: true,
                        message: 'En iOS, pulsa el botón Compartir y selecciona "Agregar a pantalla de inicio"'
                    };
                }
                return {
                    success: false,
                    message: 'La instalación no está disponible en este momento'
                };
            }

            try {
                this.deferredPrompt.prompt();
                const { outcome } = await this.deferredPrompt.userChoice;
                console.log(`[PWA] Respuesta del usuario al instalar: ${outcome}`);
                this.deferredPrompt = null;
                return {
                    success: outcome === 'accepted',
                    outcome
                };
            } catch (err) {
                console.error('Error al solicitar instalación:', err);
                return { success: false, error: err };
            }
        }
    }

    // Exponer globalmente
    window.pwaManager = new PWAManager();
})();
