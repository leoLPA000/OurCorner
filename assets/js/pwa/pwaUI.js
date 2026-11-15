/**
 * PWA UI CONTROLLER - OurCorner
 * Interfaz de usuario discreta y elegante para instalación y notificaciones Web Push.
 * Usa exclusivamente iconos vectoriales SVG (sin emojis) e instalación nativa directa.
 */

(function () {
    'use strict';

    // Iconos SVG limpios y consistentes con la paleta de OurCorner
    const ICONS = {
        download: '<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;margin-right:6px;"><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4"/><polyline points="7 10 12 15 17 10"/><line x1="12" y1="15" x2="12" y2="3"/></svg>',
        bell: '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;margin-right:6px;"><path d="M18 8A6 6 0 0 0 6 8c0 7-3 9-3 9h18s-3-2-3-9"/><path d="M13.73 21a2 2 0 0 1-3.46 0"/></svg>',
        bellOff: '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;margin-right:6px;"><path d="M13.73 21a2 2 0 0 1-3.46 0"/><path d="M18.63 13A17.89 17.89 0 0 1 18 8"/><path d="M6.26 6.26A5.86 5.86 0 0 0 6 8c0 7-3 9-3 9h14"/><path d="M18 8a6 6 0 0 0-9.33-5"/><line x1="1" y1="1" x2="23" y2="23"/></svg>',
        check: '<svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;margin-right:4px;"><polyline points="20 6 9 17 4 12"/></svg>',
        info: '<svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round" style="vertical-align:middle;margin-right:6px;"><circle cx="12" cy="12" r="10"/><line x1="12" y1="16" x2="12" y2="12"/><line x1="12" y1="8" x2="12.01" y2="8"/></svg>'
    };

    class PWAUI {
        constructor() {
            this.installBtn = null;
            this.init();
        }

        init() {
            this.injectStyles();
            this.createInstallButton();
            this.setupEventListeners();
            this.setupPushNotificationUI();
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
                /* Botón flotante centrado de instalación directa */
                .pwa-install-pill {
                    position: fixed;
                    bottom: 24px;
                    left: 50%;
                    transform: translateX(-50%);
                    z-index: 99999;
                    background: linear-gradient(135deg, #ec6090, #bf376d);
                    color: #ffffff;
                    border: none;
                    border-radius: 99px;
                    padding: 12px 26px;
                    font-family: 'Plus Jakarta Sans', sans-serif;
                    font-size: 0.92rem;
                    font-weight: 700;
                    letter-spacing: 0.02em;
                    box-shadow: 0 10px 30px rgba(191, 55, 109, 0.4);
                    cursor: pointer;
                    display: inline-flex;
                    align-items: center;
                    justify-content: center;
                    gap: 6px;
                    transition: transform 0.25s ease, box-shadow 0.25s ease, opacity 0.25s ease;
                    backdrop-filter: blur(8px);
                    -webkit-tap-highlight-color: transparent;
                }

                .pwa-install-pill:hover {
                    transform: translateX(-50%) translateY(-2px) scale(1.02);
                    box-shadow: 0 14px 34px rgba(191, 55, 109, 0.5);
                }

                .pwa-install-pill:active {
                    transform: translateX(-50%) translateY(0);
                }
            `;
            document.head.appendChild(style);
        }

        /**
         * Crea el botón de instalación directa (sin modales ni emojis)
         */
        createInstallButton() {
            if (document.getElementById('pwaInstallPill')) return;

            const btn = document.createElement('button');
            btn.id = 'pwaInstallPill';
            btn.className = 'pwa-install-pill';
            btn.setAttribute('aria-label', 'Instalar OurCorner');
            btn.innerHTML = `${ICONS.download}<span>Instalar OurCorner</span>`;

            // Clic para instalación nativa directa
            btn.addEventListener('click', async () => {
                // 1. Si tenemos el prompt de instalación nativo disponible, dispararlo directamente
                if (window.pwaManager && window.pwaManager.deferredPrompt) {
                    const result = await window.pwaManager.promptInstall();
                    if (result && result.success) {
                        btn.style.display = 'none';
                    }
                    return;
                }

                // 2. Si no está listo (ejemplo: pestaña en modo incógnito donde el navegador bloquea PWAs)
                if (window.syncService) {
                    window.syncService.showToast(
                        'Para instalar con un clic, abre OurCorner en una pestaña normal (no de incógnito).',
                        'info'
                    );
                }
            });

            document.body.appendChild(btn);
            this.installBtn = btn;

            // Ocultar si ya está en modo standalone instalada
            if (window.pwaManager && window.pwaManager.isInstalled) {
                btn.style.display = 'none';
            } else {
                btn.style.display = 'inline-flex';
            }
        }

        setupEventListeners() {
            // Mostrar botón cuando el navegador confirme que la app es instalable
            window.addEventListener('pwa-installable', () => {
                if (this.installBtn && (!window.pwaManager || !window.pwaManager.isInstalled)) {
                    this.installBtn.style.display = 'inline-flex';
                }
            });

            // Ocultar botón si la app ya fue instalada
            window.addEventListener('pwa-installed', () => {
                if (this.installBtn) {
                    this.installBtn.style.display = 'none';
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
