/**
 * 🎨 PWA UI CONTROLLER - OurCorner
 * Interfaz de usuario discreta y elegante para instalación y notificaciones Web Push.
 * Respeta 100% la identidad visual de OurCorner (tonos rosa, corazones, tipografía romántica).
 */

(function () {
    'use strict';

    class PWAUI {
        constructor() {
            this.installBtn = null;
            this.iosModal = null;
            this.init();
        }

        init() {
            this.injectStyles();
            this.createInstallButton();
            this.createIOSModal();
            this.setupEventListeners();
            this.setupPushNotificationUI();
        }

        /**
         * Inyecta estilos CSS para la UI de PWA sin afectar otros componentes
         */
        injectStyles() {
            const styleId = 'pwa-ui-styles';
            if (document.getElementById(styleId)) return;

            const style = document.createElement('style');
            styleId && (style.id = styleId);
            style.textContent = `
                /* Botón flotante elegante de instalación */
                .pwa-install-pill {
                    position: fixed;
                    bottom: 24px;
                    left: 24px;
                    z-index: 9999;
                    background: linear-gradient(135deg, #ec6090, #bf376d);
                    color: #ffffff;
                    border: none;
                    border-radius: 99px;
                    padding: 10px 18px;
                    font-family: 'Plus Jakarta Sans', sans-serif;
                    font-size: 0.88rem;
                    font-weight: 700;
                    box-shadow: 0 8px 24px rgba(191, 55, 109, 0.35);
                    cursor: pointer;
                    display: none;
                    align-items: center;
                    gap: 8px;
                    transition: transform 0.25s ease, box-shadow 0.25s ease, opacity 0.25s ease;
                    backdrop-filter: blur(8px);
                }

                .pwa-install-pill:hover {
                    transform: translateY(-2px) scale(1.02);
                    box-shadow: 0 12px 28px rgba(191, 55, 109, 0.45);
                }

                .pwa-install-pill:active {
                    transform: translateY(0);
                }

                .pwa-install-pill .pill-icon {
                    font-size: 1.15rem;
                }

                /* Modal de ayuda para instalación en iOS */
                .pwa-ios-modal-overlay {
                    display: none;
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100%;
                    height: 100%;
                    background: rgba(52, 35, 48, 0.6);
                    backdrop-filter: blur(4px);
                    z-index: 10000;
                    align-items: center;
                    justify-content: center;
                    padding: 16px;
                    animation: pwaFadeIn 0.3s ease;
                }

                .pwa-ios-modal {
                    background: #ffffff;
                    border-radius: 24px;
                    max-width: 380px;
                    width: 100%;
                    padding: 26px 22px;
                    box-shadow: 0 20px 50px rgba(117, 48, 83, 0.25);
                    border: 1px solid rgba(236, 96, 144, 0.2);
                    text-align: center;
                    font-family: 'Plus Jakarta Sans', sans-serif;
                    position: relative;
                }

                .pwa-ios-modal h3 {
                    color: #bf376d;
                    font-size: 1.25rem;
                    margin-bottom: 12px;
                    font-weight: 800;
                }

                .pwa-ios-modal p {
                    color: #554450;
                    font-size: 0.9rem;
                    line-height: 1.5;
                    margin-bottom: 18px;
                }

                .pwa-ios-steps {
                    text-align: left;
                    background: #fff5f8;
                    border-radius: 14px;
                    padding: 14px 16px;
                    margin-bottom: 20px;
                    font-size: 0.85rem;
                    color: #342330;
                }

                .pwa-ios-steps ol {
                    margin-left: 20px;
                }

                .pwa-ios-steps li {
                    margin-bottom: 8px;
                }

                .pwa-ios-close {
                    background: #f0dfe8;
                    color: #bf376d;
                    border: none;
                    border-radius: 99px;
                    padding: 10px 22px;
                    font-weight: 700;
                    font-size: 0.88rem;
                    cursor: pointer;
                    transition: background 0.2s;
                }

                .pwa-ios-close:hover {
                    background: #ffd8e7;
                }

                @keyframes pwaFadeIn {
                    from { opacity: 0; }
                    to { opacity: 1; }
                }
            `;
            document.head.appendChild(style);
        }

        /**
         * Crea el botón discreto de instalación
         */
        createInstallButton() {
            if (document.getElementById('pwaInstallPill')) return;

            const btn = document.createElement('button');
            btn.id = 'pwaInstallPill';
            btn.className = 'pwa-install-pill';
            btn.setAttribute('aria-label', 'Instalar OurCorner en tu dispositivo');
            btn.innerHTML = `
                <span class="pill-icon">📲</span>
                <span class="pill-text">Instalar OurCorner</span>
            `;

            btn.addEventListener('click', async () => {
                if (window.pwaManager) {
                    if (window.pwaManager.isIOS) {
                        this.showIOSModal();
                        return;
                    }
                    const result = await window.pwaManager.promptInstall();
                    if (result && result.success) {
                        btn.style.display = 'none';
                    }
                }
            });

            document.body.appendChild(btn);
            this.installBtn = btn;

            // Si es iOS y no está en modo standalone, mostrar la opción discretamente
            if (window.pwaManager && window.pwaManager.isIOS && !window.pwaManager.isInstalled) {
                btn.style.display = 'inline-flex';
            }
        }

        /**
         * Crea el modal con instrucciones amigables para iOS (Safari)
         */
        createIOSModal() {
            if (document.getElementById('pwaIosModalOverlay')) return;

            const overlay = document.createElement('div');
            overlay.id = 'pwaIosModalOverlay';
            overlay.className = 'pwa-ios-modal-overlay';
            overlay.innerHTML = `
                <div class="pwa-ios-modal">
                    <h3>📲 Instalar OurCorner en tu iPhone / iPad</h3>
                    <p>Agrega la aplicación a tu pantalla de inicio para disfrutarla a pantalla completa y sin barras de navegación.</p>
                    <div class="pwa-ios-steps">
                        <ol>
                            <li>Toca el botón <strong>Compartir</strong> <span style="font-size:1.1rem">📤</span> en la barra de Safari.</li>
                            <li>Baja y pulsa en <strong>"Agregar a pantalla de inicio"</strong> <span style="font-size:1.1rem">➕</span>.</li>
                            <li>Toca <strong>"Agregar"</strong> arriba a la derecha.</li>
                        </ol>
                    </div>
                    <button class="pwa-ios-close" id="pwaIosCloseBtn">Entendido</button>
                </div>
            `;

            overlay.querySelector('#pwaIosCloseBtn').addEventListener('click', () => {
                overlay.style.display = 'none';
            });

            overlay.addEventListener('click', (e) => {
                if (e.target === overlay) overlay.style.display = 'none';
            });

            document.body.appendChild(overlay);
            this.iosModal = overlay;
        }

        showIOSModal() {
            if (this.iosModal) {
                this.iosModal.style.display = 'flex';
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
         * Configura el botón de Web Push en el dropdown de usuario o en el panel de notificaciones
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
                            <span style="font-size: 0.76rem; color: #554450; font-weight: 600;">Notificaciones en el móvil:</span>
                            <button id="pwaPushToggleBtn" style="font-size: 0.72rem; color: #bf376d; font-weight: 700; background: #ffeef4; border: 1px solid rgba(236,96,144,0.3); border-radius: 20px; padding: 4px 10px; cursor: pointer;">
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
                    pushItem.innerHTML = '🔔 Activar Notificaciones';

                    const existingSub = await window.pushService.getExistingSubscription();
                    if (existingSub) {
                        pushItem.innerHTML = '🔕 Desactivar Notificaciones';
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
                btn.textContent = '✅ Activadas (Pausar)';
                btn.style.color = '#1b873f';
                btn.style.background = '#e7f7ed';
            } else {
                btn.textContent = '🔔 Activar avisos';
                btn.style.color = '#bf376d';
                btn.style.background = '#ffeef4';
            }
        }

        async handlePushToggle(btn, isDropdown = false) {
            btn.disabled = true;
            btn.textContent = 'Procesando...';

            const sub = await window.pushService.getExistingSubscription();
            if (sub) {
                // Desactivar
                const res = await window.pushService.unsubscribe();
                if (res.success) {
                    if (isDropdown) {
                        btn.innerHTML = '🔔 Activar Notificaciones';
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
                        btn.innerHTML = '🔕 Desactivar Notificaciones';
                    } else {
                        await this.updatePushToggleButton(btn);
                    }
                    if (window.syncService) window.syncService.showToast('¡Notificaciones push activadas con éxito! 💕', 'success');
                } else {
                    alert(res.error || 'No se pudieron activar las notificaciones');
                    if (isDropdown) {
                        btn.innerHTML = '🔔 Activar Notificaciones';
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
