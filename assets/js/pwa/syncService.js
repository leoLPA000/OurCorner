/**
 * 🔄 SYNC SERVICE - OurCorner PWA
 * Gestión de sincronización automática de datos entre IndexedDB y Supabase.
 * 
 * Funcionalidades:
 * - Detección en tiempo real de conexión (online/offline).
 * - Procesamiento de cola de operaciones pendientes con Background Sync API y fallback.
 * - Idempotencia para evitar duplicados de mensajes y eventos.
 * - Resolución de conflictos con validación de sesión activa y timestamps.
 * - Notificaciones discretas de sincronización al usuario.
 */

(function () {
    'use strict';

    class SyncService {
        constructor() {
            this.isOnline = navigator.onLine;
            this.isSyncing = false;
            this.maxRetries = 3;

            this.init();
        }

        init() {
            // Eventos de conectividad del navegador
            window.addEventListener('online', () => this.handleOnline());
            window.addEventListener('offline', () => this.handleOffline());

            // Evento cuando se añade una nueva operación pendiente en IndexedDB
            window.addEventListener('pwa-pending-op-added', () => {
                if (this.isOnline) {
                    this.triggerSync();
                }
            });

            // Escuchar mensajes del Service Worker (Background Sync)
            if ('serviceWorker' in navigator) {
                navigator.serviceWorker.addEventListener('message', (event) => {
                    if (event.data && event.data.type === 'BACKGROUND_SYNC_TRIGGERED') {
                        console.log('🔄 [SyncService] Señal de Background Sync recibida desde el SW');
                        this.triggerSync();
                    }
                });
            }

            // Sincronizar al iniciar si hay internet
            if (this.isOnline) {
                // Esperar levemente a que Supabase y Auth terminen de cargar
                setTimeout(() => this.triggerSync(), 1500);
            }
        }

        handleOnline() {
            console.log('🌐 [SyncService] Conexión a Internet recuperada');
            this.isOnline = true;
            this.showToast('Conexión reestablecida. Sincronizando...', 'info');
            this.requestBackgroundSync();
            this.triggerSync();
        }

        handleOffline() {
            console.log('📡 [SyncService] Sin conexión a Internet');
            this.isOnline = false;
            this.showToast('Modo sin conexión activado', 'warning');
        }

        /**
         * Registra Background Sync en el navegador si es compatible
         */
        async requestBackgroundSync() {
            try {
                if ('serviceWorker' in navigator && 'SyncManager' in window) {
                    const registration = await navigator.serviceWorker.ready;
                    await registration.sync.register('sync-pending-operations');
                    console.log('✅ [SyncService] Background Sync registrado en el Service Worker');
                }
            } catch (err) {
                console.warn('⚠️ [SyncService] Background Sync no disponible, usando sincronización directa:', err);
            }
        }

        /**
         * Dispara la sincronización de la cola
         */
        async triggerSync() {
            if (!this.isOnline || this.isSyncing) return;
            await this.syncPendingOperations();
        }

        /**
         * Procesa todas las operaciones pendientes en IndexedDB
         */
        async syncPendingOperations() {
            if (!window.offlineDB) return;

            this.isSyncing = true;
            let syncCount = 0;
            let errorCount = 0;

            try {
                // 1. Verificar sesión activa de Supabase
                const sb = window.supabaseClient;
                if (!sb) {
                    console.warn('⚠️ [SyncService] Supabase client no disponible para sincronizar');
                    this.isSyncing = false;
                    return;
                }

                const { data: { session } } = await sb.auth.getSession();
                if (!session || !session.user) {
                    console.log('ℹ️ [SyncService] No hay sesión activa. Postergando sincronización.');
                    this.isSyncing = false;
                    return;
                }

                const currentUserId = session.user.id;

                // 2. Obtener operaciones pendientes del usuario actual
                const operaciones = await window.offlineDB.obtenerOperacionesPendientes();
                if (!operaciones || operaciones.length === 0) {
                    this.isSyncing = false;
                    return;
                }

                console.log(`🔄 [SyncService] Procesando ${operaciones.length} operación(es) pendiente(s)...`);

                for (const op of operaciones) {
                    // Verificar que la operación pertenece al usuario autenticado
                    if (op.userId !== currentUserId && op.userId !== 'anonymous') {
                        console.warn(`🔒 [SyncService] Operación ${op.id} omitida por pertenecer a otro usuario`);
                        continue;
                    }

                    try {
                        const success = await this.executeOperation(op, sb, currentUserId);
                        if (success) {
                            await window.offlineDB.eliminarOperacion(op.id);
                            syncCount++;
                        } else {
                            errorCount++;
                        }
                    } catch (err) {
                        console.error(`❌ [SyncService] Error al sincronizar operación ${op.id}:`, err);
                        errorCount++;
                        const retries = (op.retryCount || 0) + 1;
                        const status = retries >= this.maxRetries ? 'failed' : 'pending';
                        await window.offlineDB.actualizarEstadoOperacion(op.id, status, err.message);
                    }
                }

                if (syncCount > 0) {
                    console.log(`✅ [SyncService] Sincronizadas con éxito ${syncCount} operación(es)`);
                    this.showToast(`¡${syncCount} cambio(s) sincronizado(s) con éxito! 💕`, 'success');
                    window.dispatchEvent(new CustomEvent('pwa-sync-completed', { detail: { syncCount } }));
                }

            } catch (err) {
                console.error('❌ [SyncService] Error general durante la sincronización:', err);
            } finally {
                this.isSyncing = false;
            }
        }

        /**
         * Ejecuta una operación individual contra Supabase con idempotencia
         */
        async executeOperation(op, sb, userId) {
            const { action, targetTable, payload } = op;
            console.log(`🚀 [SyncService] Ejecutando: ${action} en tabla ${targetTable}`);

            switch (action) {
                case 'INSERT_MENSAJE': {
                    // Idempotencia: Verificar si ya existe por ID
                    if (payload.id) {
                        const { data: existing } = await sb
                            .from('mensajes')
                            .select('id')
                            .eq('id', payload.id)
                            .maybeSingle();

                        if (existing) {
                            console.log('ℹ️ [SyncService] Mensaje ya existía en servidor, omitiendo insert');
                            return true;
                        }
                    }

                    const record = { ...payload, user_id: userId };
                    const { error } = await sb.from('mensajes').insert([record]);
                    if (error) throw error;
                    return true;
                }

                case 'DELETE_MENSAJE': {
                    const messageId = payload.id;
                    const { error } = await sb.from('mensajes').delete().eq('id', messageId);
                    if (error) throw error;
                    return true;
                }

                case 'INSERT_EVENTO': {
                    // Idempotencia en eventos de calendario
                    if (payload.id) {
                        const { data: existing } = await sb
                            .from('calendario_eventos')
                            .select('id')
                            .eq('id', payload.id)
                            .maybeSingle();

                        if (existing) {
                            console.log('ℹ️ [SyncService] Evento de calendario ya existía, omitiendo insert');
                            return true;
                        }
                    }

                    const eventRecord = { ...payload, owner_id: userId };
                    const { error } = await sb.from('calendario_eventos').insert([eventRecord]);
                    if (error) throw error;
                    return true;
                }

                case 'DELETE_EVENTO': {
                    const eventId = payload.id;
                    const { error } = await sb.from('calendario_eventos').delete().eq('id', eventId);
                    if (error) throw error;
                    return true;
                }

                case 'SAVE_PIZARRA': {
                    // Blush Board - Pizarras guardadas en nube
                    const boardRecord = {
                        user_id: userId,
                        titulo: payload.titulo || 'Mi Dibujo',
                        board_data: payload.objects || payload.board_data,
                        es_publica: payload.es_publica || false,
                        updated_at: new Date().toISOString()
                    };

                    if (payload.id) {
                        const { error } = await sb.from('pizarras').upsert({ id: payload.id, ...boardRecord });
                        if (error) throw error;
                    } else {
                        const { error } = await sb.from('pizarras').insert([boardRecord]);
                        if (error) throw error;
                    }
                    return true;
                }

                default:
                    console.warn('⚠️ [SyncService] Acción desconocida:', action);
                    return false;
            }
        }

        /**
         * Muestra una notificación toast discreta en pantalla
         */
        showToast(message, type = 'info') {
            const existing = document.querySelector('.pwa-sync-toast');
            if (existing) existing.remove();

            const toast = document.createElement('div');
            toast.className = 'pwa-sync-toast';
            toast.innerHTML = `
                <span class="toast-icon">${type === 'success' ? '✅' : type === 'warning' ? '📡' : 'ℹ️'}</span>
                <span class="toast-text">${message}</span>
            `;

            // Estilos discretos y elegantes
            Object.assign(toast.style, {
                position: 'fixed',
                bottom: '24px',
                right: '24px',
                background: type === 'warning' ? '#fff0f5' : '#ffffff',
                color: type === 'warning' ? '#bf376d' : '#342330',
                border: '1px solid rgba(236, 96, 144, 0.25)',
                padding: '10px 18px',
                borderRadius: '99px',
                boxShadow: '0 8px 24px rgba(117, 48, 83, 0.16)',
                display: 'flex',
                alignItems: 'center',
                gap: '8px',
                fontSize: '0.85rem',
                fontWeight: '600',
                zIndex: '99999',
                fontFamily: "'Plus Jakarta Sans', sans-serif",
                transition: 'opacity 0.3s ease, transform 0.3s ease',
                opacity: '0',
                transform: 'translateY(10px)'
            });

            document.body.appendChild(toast);

            // Animar entrada
            requestAnimationFrame(() => {
                toast.style.opacity = '1';
                toast.style.transform = 'translateY(0)';
            });

            // Ocultar y remover a los 3.5 segundos
            setTimeout(() => {
                toast.style.opacity = '0';
                toast.style.transform = 'translateY(10px)';
                setTimeout(() => toast.remove(), 350);
            }, 3500);
        }
    }

    // Instancia global
    window.syncService = new SyncService();
})();
