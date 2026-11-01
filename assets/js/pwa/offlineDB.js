/**
 * 📦 OFFLINE DB SERVICE - OurCorner PWA
 * Gestión de base de datos local IndexedDB para funcionamiento offline avanzado.
 * 
 * Stores disponibles:
 * 1. `mensajes`: Mensajes de amor cacheados / guardados localmente.
 * 2. `eventos_calendario`: Recuerdos y eventos del calendario.
 * 3. `borradores`: Borradores de pizarra (Blush Board) y notas.
 * 4. `operaciones_pendientes`: Cola de sincronización fuera de línea (Outbox).
 * 5. `preferencias`: Ajustes y preferencias visuales de la aplicación.
 * 
 * Seguridad y aislamiento:
 * - Aislamiento estricto por `userId`.
 * - Sin almacenamiento de contraseñas ni tokens JWT.
 * - Limpieza controlada de datos privados al cerrar sesión.
 */

(function () {
    'use strict';

    const DB_NAME = 'OurCornerDB';
    const DB_VERSION = 1;

    class OfflineDB {
        constructor() {
            this.db = null;
            this.initPromise = this.openDB();
        }

        /**
         * Inicializa o actualiza la base de datos IndexedDB
         */
        openDB() {
            return new Promise((resolve, reject) => {
                if (!('indexedDB' in window)) {
                    console.warn('⚠️ [OfflineDB] IndexedDB no soportado en este navegador');
                    return resolve(null);
                }

                const request = indexedDB.open(DB_NAME, DB_VERSION);

                request.onupgradeneeded = (event) => {
                    const db = event.target.result;
                    console.log('📦 [OfflineDB] Creando o actualizando estructura de base de datos...');

                    // 1. Store: Mensajes
                    if (!db.objectStoreNames.contains('mensajes')) {
                        const store = db.createObjectStore('mensajes', { keyPath: 'id' });
                        store.createIndex('userId', 'userId', { unique: false });
                        store.createIndex('categoria', 'categoria', { unique: false });
                    }

                    // 2. Store: Eventos de Calendario
                    if (!db.objectStoreNames.contains('eventos_calendario')) {
                        const store = db.createObjectStore('eventos_calendario', { keyPath: 'id' });
                        store.createIndex('userId', 'userId', { unique: false });
                        store.createIndex('fecha', 'fecha', { unique: false });
                    }

                    // 3. Store: Borradores (Pizarra, mensajes en edición)
                    if (!db.objectStoreNames.contains('borradores')) {
                        const store = db.createObjectStore('borradores', { keyPath: 'id' });
                        store.createIndex('userId', 'userId', { unique: false });
                        store.createIndex('tipo', 'tipo', { unique: false });
                    }

                    // 4. Store: Operaciones Pendientes (Cola de sincronización)
                    if (!db.objectStoreNames.contains('operaciones_pendientes')) {
                        const store = db.createObjectStore('operaciones_pendientes', { keyPath: 'id' });
                        store.createIndex('userId', 'userId', { unique: false });
                        store.createIndex('status', 'status', { unique: false });
                        store.createIndex('clientTimestamp', 'clientTimestamp', { unique: false });
                    }

                    // 5. Store: Preferencias locales
                    if (!db.objectStoreNames.contains('preferencias')) {
                        db.createObjectStore('preferencias', { keyPath: 'key' });
                    }
                };

                request.onsuccess = (event) => {
                    this.db = event.target.result;
                    console.log('✅ [OfflineDB] Conexión abierta exitosamente');
                    resolve(this.db);
                };

                request.onerror = (event) => {
                    console.error('❌ [OfflineDB] Error al abrir base de datos:', event.target.error);
                    reject(event.target.error);
                };
            });
        }

        async getDB() {
            if (!this.db) {
                await this.initPromise;
            }
            return this.db;
        }

        /**
         * Obtiene el ID del usuario actual de forma segura
         */
        getCurrentUserId() {
            try {
                if (window.authService && window.authService.currentUser) {
                    return window.authService.currentUser.id;
                }
                const sessionRaw = localStorage.getItem('sb-lrjbpnzkvueralkqrsfd-auth-token');
                if (sessionRaw) {
                    const session = JSON.parse(sessionRaw);
                    return session?.user?.id || 'anonymous';
                }
            } catch (e) { }
            return 'anonymous';
        }

        // ====================================================================
        // OPERACIONES GENÉRICAS
        // ====================================================================

        async put(storeName, item) {
            const db = await this.getDB();
            if (!db) return null;

            return new Promise((resolve, reject) => {
                const tx = db.transaction([storeName], 'readwrite');
                const store = tx.objectStore(storeName);
                const req = store.put(item);

                req.onsuccess = () => resolve(req.result);
                req.onerror = () => reject(req.error);
            });
        }

        async get(storeName, key) {
            const db = await this.getDB();
            if (!db) return null;

            return new Promise((resolve, reject) => {
                const tx = db.transaction([storeName], 'readonly');
                const store = tx.objectStore(storeName);
                const req = store.get(key);

                req.onsuccess = () => resolve(req.result || null);
                req.onerror = () => reject(req.error);
            });
        }

        async delete(storeName, key) {
            const db = await this.getDB();
            if (!db) return null;

            return new Promise((resolve, reject) => {
                const tx = db.transaction([storeName], 'readwrite');
                const store = tx.objectStore(storeName);
                const req = store.delete(key);

                req.onsuccess = () => resolve(true);
                req.onerror = () => reject(req.error);
            });
        }

        async getAllByIndex(storeName, indexName, value) {
            const db = await this.getDB();
            if (!db) return [];

            return new Promise((resolve, reject) => {
                const tx = db.transaction([storeName], 'readonly');
                const store = tx.objectStore(storeName);
                const index = store.index(indexName);
                const req = index.getAll(value);

                req.onsuccess = () => resolve(req.result || []);
                req.onerror = () => reject(req.error);
            });
        }

        async getAll(storeName) {
            const db = await this.getDB();
            if (!db) return [];

            return new Promise((resolve, reject) => {
                const tx = db.transaction([storeName], 'readonly');
                const store = tx.objectStore(storeName);
                const req = store.getAll();

                req.onsuccess = () => resolve(req.result || []);
                req.onerror = () => reject(req.error);
            });
        }

        // ====================================================================
        // GESTIÓN DE BORRADORES (Pizarra, Notas)
        // ====================================================================

        /**
         * Guarda un borrador asignado al usuario actual
         * @param {string} tipo 'pizarra' | 'mensaje' | 'libreta'
         * @param {any} data Contenido del borrador
         */
        async guardarBorrador(tipo, data) {
            const userId = this.getCurrentUserId();
            const id = `draft_${tipo}_${userId}`;
            const item = {
                id,
                tipo,
                userId,
                data,
                updatedAt: new Date().toISOString()
            };
            await this.put('borradores', item);
            return item;
        }

        /**
         * Obtiene el borrador del usuario actual
         */
        async obtenerBorrador(tipo) {
            const userId = this.getCurrentUserId();
            const id = `draft_${tipo}_${userId}`;
            const draft = await this.get('borradores', id);
            return draft ? draft.data : null;
        }

        /**
         * Elimina un borrador específico
         */
        async eliminarBorrador(tipo) {
            const userId = this.getCurrentUserId();
            const id = `draft_${tipo}_${userId}`;
            return await this.delete('borradores', id);
        }

        // ====================================================================
        // GESTIÓN DE COLA DE OPERACIONES PENDIENTES (Outbox)
        // ====================================================================

        /**
         * Registra una operación que no pudo completarse por falta de red
         * @param {string} action 'INSERT_MENSAJE' | 'DELETE_MENSAJE' | 'INSERT_EVENTO' | 'DELETE_EVENTO' | 'SAVE_PIZARRA'
         * @param {string} targetTable 'mensajes' | 'calendario_eventos' | 'pizarras'
         * @param {object} payload Datos de la operación
         */
        async registrarOperacionPendiente(action, targetTable, payload) {
            const userId = this.getCurrentUserId();
            const id = 'op_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
            const operacion = {
                id,
                userId,
                action,
                targetTable,
                payload,
                clientTimestamp: new Date().toISOString(),
                retryCount: 0,
                status: 'pending',
                errorMessage: null
            };

            await this.put('operaciones_pendientes', operacion);
            console.log('📝 [OfflineDB] Operación registrada en cola pendiente:', action, id);

            // Disparar evento para que syncService intente sincronizar si hay red
            window.dispatchEvent(new CustomEvent('pwa-pending-op-added', { detail: operacion }));
            return operacion;
        }

        /**
         * Obtiene las operaciones pendientes del usuario actual
         */
        async obtenerOperacionesPendientes() {
            const userId = this.getCurrentUserId();
            const todas = await this.getAllByIndex('operaciones_pendientes', 'userId', userId);
            return todas.filter(op => op.status === 'pending');
        }

        /**
         * Actualiza el estado de una operación pendiente
         */
        async actualizarEstadoOperacion(id, status, errorMessage = null) {
            const op = await this.get('operaciones_pendientes', id);
            if (!op) return null;

            op.status = status;
            op.retryCount = (op.retryCount || 0) + 1;
            op.errorMessage = errorMessage;
            op.updatedAt = new Date().toISOString();

            await this.put('operaciones_pendientes', op);
            return op;
        }

        /**
         * Elimina una operación completada exitosamente de la cola
         */
        async eliminarOperacion(id) {
            return await this.delete('operaciones_pendientes', id);
        }

        // ====================================================================
        // GESTIÓN DE DATOS CACHEADOS (Mensajes, Calendario)
        // ====================================================================

        /**
         * Guarda en caché local los mensajes descargados de Supabase
         */
        async cachearMensajes(listaMensajes) {
            const userId = this.getCurrentUserId();
            for (const item of listaMensajes) {
                await this.put('mensajes', {
                    ...item,
                    userId: item.user_id || userId,
                    cachedAt: new Date().toISOString()
                });
            }
        }

        /**
         * Obtiene los mensajes locales aislados por usuario
         */
        async obtenerMensajesLocales() {
            const userId = this.getCurrentUserId();
            return await this.getAllByIndex('mensajes', 'userId', userId);
        }

        /**
         * Guarda en caché local los eventos del calendario
         */
        async cachearEventosCalendario(listaEventos) {
            const userId = this.getCurrentUserId();
            for (const evento of listaEventos) {
                await this.put('eventos_calendario', {
                    ...evento,
                    userId: evento.user_id || userId,
                    cachedAt: new Date().toISOString()
                });
            }
        }

        /**
         * Obtiene los eventos locales del calendario
         */
        async obtenerEventosCalendarioLocales() {
            const userId = this.getCurrentUserId();
            return await this.getAllByIndex('eventos_calendario', 'userId', userId);
        }

        // ====================================================================
        // POLÍTICA DE SEGURIDAD Y CIERRE DE SESIÓN
        // ====================================================================

        /**
         * Limpia datos sensibles de un usuario al cerrar sesión
         */
        async limpiarDatosUsuario(userId) {
            if (!userId) return;
            console.log('🔒 [OfflineDB] Limpiando datos privados locales del usuario:', userId);

            const stores = ['mensajes', 'eventos_calendario', 'borradores', 'operaciones_pendientes'];
            const db = await this.getDB();
            if (!db) return;

            for (const storeName of stores) {
                const items = await this.getAllByIndex(storeName, 'userId', userId);
                for (const item of items) {
                    await this.delete(storeName, item.id);
                }
            }
            console.log('✅ [OfflineDB] Datos privados locales purgados de forma segura.');
        }
    }

    // Instancia global
    window.offlineDB = new OfflineDB();
})();
