/**
 * PWA UI CONTROLLER - OurCorner
 * Interfaz de usuario discreta y elegante para instalación y notificaciones Web Push.
 * Usa exclusivamente iconos vectoriales SVG (sin emojis), instalación nativa directa,
 * opción de cerrar y postergar por 7 días, y detección de instalación/desinstalación.
 */

(function () {
    'use strict';

    // Constantes de almacenamiento local para persistencia entre sesiones
    const STORAGE_KEYS = {
        DISMISSED_UNTIL: 'ourcorner_pwa_dismissed_until',
        IS_INSTALLED: 'ourcorner_pwa_installed'
    };
    const SEVEN_DAYS_MS = 7 * 24 * 60 * 60 * 1000;

    // Iconos SVG limpios y consistentes con la paleta de OurCorner
    const ICONS = {
        download: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;margin-right:6px;"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>',
        close: '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;"><line x1="18" y1="6" x2="6" y2="18"/><line x1="6" y1="6" x2="18" y2="18"/></svg>',
        bell: '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;margin-right:6px;"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>',
        bellOff: '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;margin-right:6px;"><path d="M13.73 21a2 2 0 0 1-3.46 0"/><path d="M18.63 13A17.89 17.89 0 0 1 18 8"/><path d="M6.26 6.26A5.86 5.86 0 0 0 6 8c0 7-3 9-3 9h14"/><path d="M18 8a6 6 0 0 0-9.33-5"/><line x1="1" y1="1" x2="23" y2="23"/></svg>',
        check: '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;margin-right:4px;"><polyline points="20 6 9 17 4 12"/></svg>',
        info: '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;margin-right:6px;"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>'
    };

    class PWAUI {
        constructor() {
            this.installContainer = null;
            this.init();
        }

        init() {
            this.injectStyles();
            this.createInstallButton();
            this.setupEventListeners();
            this.setupPushNotificationUI();
        }

        /**
         * Verifica si el usuario pospuso la instalación y si aún está dentro de los 7 días
         */
        isDismissed() {
            const dismissedUntil = localStorage.getItem(STORAGE_KEYS.DISMISSED_UNTIL);
            if (!dismissedUntil) return false;

            const until = parseInt(dismissedUntil, 10);
            if (isNaN(until)) {
                localStorage.removeItem(STORAGE_KEYS.DISMISSED_UNTIL);
                return false;
            }

            if (Date.now() < until) {
                return true; // Período de 7 días activo
            }

            // Expiraron los 7 días: limpiar para que vuelva a mostrarse
            localStorage.removeItem(STORAGE_KEYS.DISMISSED_UNTIL);
            return false;
        }

        /**
         * Guarda el descarte durante N días (por defecto 7 días)
         */
        dismiss(days = 7) {
            const expireTime = Date.now() + (days * 24 * 60 * 60 * 1000);
            localStorage.setItem(STORAGE_KEYS.DISMISSED_UNTIL, expireTime.toString());

            if (this.installContainer) {
                this.installContainer.style.opacity = '0';
                this.installContainer.style.transform = 'translateX(-50%) translateY(12px) scale(0.95)';
                setTimeout(() => {
                    this.installContainer.style.display = 'none';
                }, 250);
            }

            if (window.syncService) {
                window.syncService.showToast('Recordatorio de instalación pospuesto por 7 días', 'info');
            }
        }

        /**
         * Inyecta estilos CSS para la UI de PWA
         */
        injectStyles() {
            const styleId = 'pwa-ui-styles';
            if (document.getElementById(styleId)) return;

            const style = document.createElement('style');
            style.id = styleId;
            style.textContent = `
                /* Contenedor flotante centrado de instalación con opción de cerrar */
                .pwa-install-container {
                    position: fixed;
                    bottom: 24px;
                    left: 50%;
                    transform: translateX(-50%);
                    z-index: 99999;
                    background: linear-gradient(135deg, #ec6090, #bf376d);
                    border-radius: 99px;
                    box-shadow: 0 10px 30px rgba(191, 55, 109, 0.4);
                    display: inline-flex;
                    align-items: center;
                    padding: 4px 6px 4px 18px;
                    backdrop-filter: blur(8px);
                    transition: transform 0.25s ease, box-shadow 0.25s ease, opacity 0.25s ease;
                    -webkit-tap-highlight-color: transparent;
                }

                .pwa-install-container:hover {
                    box-shadow: 0 14px 34px rgba(191, 55, 109, 0.5);
                }

                /* Botón principal de instalación directa */
                .pwa-install-action {
                    background: transparent;
                    border: none;
                    color: #ffffff;
                    font-family: 'Plus Jakarta Sans', sans-serif;
                    font-size: 0.90rem;
                    font-weight: 700;
                    letter-spacing: 0.02em;
                    cursor: pointer;
                    display: inline-flex;
                    align-items: center;
                    gap: 6px;
                    padding: 8px 10px 8px 0;
                    transition: opacity 0.2s ease, transform 0.2s ease;
                }

                .pwa-install-action:hover {
                    opacity: 0.95;
                    transform: scale(1.02);
                }

                .pwa-install-action:active {
                    transform: scale(0.98);
                }

                /* Separador visual sutil */
                .pwa-install-divider {
                    width: 1px;
                    height: 18px;
                    background: rgba(255, 255, 255, 0.35);
                    margin: 0 4px;
                }

                /* Botón de cerrar (X) */
                .pwa-install-close {
                    background: transparent;
                    border: none;
                    color: rgba(255, 255, 255, 0.85);
                    width: 28px;
                    height: 28px;
                    border-radius: 50%;
                    cursor: pointer;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    padding: 0;
                    transition: background-color 0.2s ease, color 0.2s ease, transform 0.2s ease;
                }

                .pwa-install-close:hover {
                    background-color: rgba(255, 255, 255, 0.25);
                    color: #ffffff;
                    transform: scale(1.1);
                }

                .pwa-install-close:active {
                    transform: scale(0.9);
                }
            `;
            document.head.appendChild(style);
        }

        /**
         * Crea el banner de instalación con botón directo y opción de cerrar por 7 días
         */
        createInstallButton() {
            if (document.getElementById('pwaInstallContainer')) return;

            const container = document.createElement('div');
            container.id = 'pwaInstallContainer';
            container.className = 'pwa-install-container';
            container.innerHTML = `
                <button id="pwaInstallAction" class="pwa-install-action" aria-label="Instalar OurCorner">
                    ${ICONS.download}
                    <span>Instalar OurCorner</span>
                </button>
                <div class="pwa-install-divider"></div>
                <button id="pwaInstallClose" class="pwa-install-close" aria-label="Cerrar aviso de instalación por 7 días" title="No instalar ahora (recordar en 7 días)">
                    ${ICONS.close}
                </button>
            `;

            const actionBtn = container.querySelector('#pwaInstallAction');
            const closeBtn = container.querySelector('#pwaInstallClose');

            // Clic para instalación nativa directa
                actionBtn.addEventListener('click', async () => {
                    // 1. Si tenemos el prompt de instalación nativo disponible, dispararlo de inmediato
                    if (window.pwaManager && window.pwaManager.deferredPrompt) {
                        const result = await window.pwaManager.promptInstall();
                        if (result && result.success) {
                            localStorage.setItem(STORAGE_KEYS.IS_INSTALLED, 'true');
                            localStorage.removeItem(STORAGE_KEYS.DISMISSED_UNTIL);
                            container.style.display = 'none';
                        }
                        return;
                    }

                    // 2. Si no está listo (ejemplo: pestaña en modo incógnito)
                    if (window.syncService) {
                        window.syncService.showToast(
                            'Para instalar con un clic, abre OurCorner en una pestaña normal (no de incógnito).',
                            'info'
                        );
                    }
                });

                // Clic para cerrar y postergar por 7 días
                closeBtn.addEventListener('click', (e) => {
                    e.stopPropagation();
                    this.dismiss(7);
                });

                    document.body.appendChild(container);
                    this.installContainer = container;

                    // Comprobar visibilidad inicial
                    this.updateVisibility();
                }

                /**
                 * Actualiza la visibilidad según si está instalada o si fue descartada
                 */
                updateVisibility() {
                    if (!this.installContainer) return;

                    const isInstalled = (window.pwaManager && window.pwaManager.isInstalled) ||
                        localStorage.getItem(STORAGE_KEYS.IS_INSTALLED) === 'true';

                    // Si está instalada o está dentro del período de 7 días descartados, ocultar
                    if (isInstalled || this.isDismissed()) {
                        this.installContainer.style.display = 'none';
                    } else {
                        this.installContainer.style.display = 'inline-flex';
                        this.installContainer.style.opacity = '1';
                        this.installContainer.style.transform = 'translateX(-50%) translateY(0) scale(1)';
                    }
                }

                setupEventListeners() {
                    // Cuando el navegador detecta que la aplicación es instalable (incluso si fue desinstalada previamente)
                    window.addEventListener('pwa-installable', () => {
                        // Si el navegador dispara beforeinstallprompt, significa que la app NO está instalada en este navegador
                        localStorage.removeItem(STORAGE_KEYS.IS_INSTALLED);
                        this.updateVisibility();
                    });

                    // Ocultar si la app ya fue instalada con éxito
                    window.addEventListener('pwa-installed', () => {
                            localStorage.setItem(STORAGE_KEYS.IS_INSTALLED, 'true');
                            localStorage.removeItem(STORAGE_KEYS.DISMISSED_UNTIL);
                            if (this.installContainer) {
                                this.installContainer.style.display = 'none';
                            }
                        });
                }

                /**
                 * Configura el botón de Web Push en el dropdown de usuario o en el panel de notificaciones con iconos vectoriales
                 */
                setupPushNotificationUI() {
                    const checkAndInject = async () => {
                        if (!window.pushService || !window.pushService.isSupported()) return;

                        // 1. Integrar botón en el panel de notificaciones (#notifPanel) si existe
                        const notifPanel = document.getElementById('notifPanel');
                        if (notifPanel && !document.getElementById('pwaPushToggleBtn')) {
                            const pushHeader = notifPanel.querySelector('div');
                            if (pushHeader) {
                                const pushRow = document.createElement('div');
                                pushRow.id = 'pwaPushToggleRow';
                                pushRow.style.cssText = 'padding: 8px 16px; background: #fff8fb; border-bottom: 1px solid #f0dfe8; display: flex; justify-content: space-between; align-items: center;';
                                pushRow.innerHTML = `
                            <span style="font-size: 0.76rem; color: #554450; font-weight: 600;">Notificaciones en el dispositivo:</span>
                            <button id="pwaPushToggleBtn" style="font-size: 0.72rem; color: #bf376d; font-weight: 700; background: #ffeef4; border: 1px solid rgba(236,96,144,0.3); border-radius: 20px; padding: 4px 10px; cursor: pointer; display: inline-flex; align-items: center;">
                                Comprobando...
                            </button>
                        `;
                                pushHeader.insertAdjacentElement('afterend', pushRow);

                                const toggleBtn = document.getElementById('pwaPushToggleBtn');
                                await this.updatePushToggleButton(toggleBtn);

                                toggleBtn.addEventListener('click', async () => {
                                    await this.handlePushToggle(toggleBtn);
                                });
                            }
                        }

                        // 2. Integrar botón en el dropdown de usuario (#userDropdown) si existe
                        const userDropdown = document.getElementById('userDropdown');
                        if (userDropdown && !document.getElementById('dropdownPushItem')) {
                            const pushItem = document.createElement('button');
                            pushItem.id = 'dropdownPushItem';
                            pushItem.className = 'dropdown-item';
                            pushItem.style.display = 'flex';
                            pushItem.style.alignItems = 'center';

                            const existingSub = await window.pushService.getExistingSubscription();
                            if (existingSub) {
                                pushItem.innerHTML = `${ICONS.bellOff}<span>Desactivar Notificaciones</span>`;
                            } else {
                                pushItem.innerHTML = `${ICONS.bell}<span>Activar Notificaciones</span>`;
                            }

                            pushItem.addEventListener('click', async (e) => {
                                e.stopPropagation();
                                await this.handlePushToggle(pushItem, true);
                            });

                            // Insertar antes de Cerrar Sesión si existe
                            const logoutBtn = userDropdown.querySelector('.dropdown-item.danger');
                            if (logoutBtn) {
                                userDropdown.insertBefore(pushItem, logoutBtn);
                            } else {
                                userDropdown.appendChild(pushItem);
                            }
                        }
                    };

                    // Intentar inyectar al cargar y tras cambios en sesión
                    setTimeout(checkAndInject, 1000);
                    window.addEventListener('load', checkAndInject);
                    window.addEventListener('storage', checkAndInject);
                }

        async updatePushToggleButton(btn) {
                    if (!btn) return;
                    const sub = await window.pushService.getExistingSubscription();
                    if (sub) {
                        btn.innerHTML = `${ICONS.check}<span>Activadas</span>`;
                        btn.style.color = '#1b873f';
                        btn.style.background = '#e7f7ed';
                    } else {
                        btn.innerHTML = `${ICONS.bell}<span>Activar avisos</span>`;
                        btn.style.color = '#bf376d';
                        btn.style.background = '#ffeef4';
                    }
                }

        async handlePushToggle(btn, isDropdown = false) {
                    btn.disabled = true;
                    btn.innerHTML = `<span>Procesando...</span>`;

                    const sub = await window.pushService.getExistingSubscription();
                    if (sub) {
                        // Desactivar
                        const res = await window.pushService.unsubscribe();
                        if (res.success) {
                            if (isDropdown) {
                                btn.innerHTML = `${ICONS.bell}<span>Activar Notificaciones</span>`;
                            } else {
                                await this.updatePushToggleButton(btn);
                            }
                            if (window.syncService) window.syncService.showToast('Notificaciones push desactivadas', 'info');
                        }
                    } else {
                        // Activar
                        const res = await window.pushService.subscribe();
                        if (res.success) {
                            if (isDropdown) {
                                btn.innerHTML = `${ICONS.bellOff}<span>Desactivar Notificaciones</span>`;
                            } else {
                                await this.updatePushToggleButton(btn);
                            }
                            if (window.syncService) window.syncService.showToast('Notificaciones push activadas con éxito', 'success');
                        } else {
                            if (window.syncService) {
                                window.syncService.showToast(res.error || 'No se pudieron activar las notificaciones', 'warning');
                            } else {
                                alert(res.error || 'No se pudieron activar las notificaciones');
                            }
                            if (isDropdown) {
                                btn.innerHTML = `${ICONS.bell}<span>Activar Notificaciones</span>`;
                            } else {
                                await this.updatePushToggleButton(btn);
                            }
                        }
                    }
                    btn.disabled = false;
                }
            }

    // Instanciar
    window.pwaUI = new PWAUI();
        })();
