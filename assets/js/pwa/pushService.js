/**
 * 🔔 PUSH SERVICE - OurCorner PWA
 * Gestión completa de Web Push API, suscripciones en Supabase y notificaciones remotas.
 * 
 * Funcionalidades:
 * - Verificación de compatibilidad con Push API y Notification API.
 * - Solicitud de permisos SOLO ante acción explícita del usuario.
 * - Creación y renovación de suscripciones con claves VAPID.
 * - Registro seguro en la tabla `push_subscriptions` en Supabase con RLS.
 * - Desactivación y revocación de suscripción.
 * - Invocación a Supabase Edge Function `send-push` para enviar notificaciones a la pareja.
 */

(function () {
    'use strict';

    // Clave VAPID pública generada para OurCorner (puede ser configurada o reemplazada)
    const DEFAULT_VAPID_PUBLIC_KEY = 'BDhAhaqa9rY6h_ezVlDlJjbiCs_TeDQ6G7CkAPyGjyxHydZZqRvWtAIfL6MRWKCHY_taSSOT54V22D9AK_UlYpM';

    // Conversión de clave VAPID base64url a Uint8Array
    function urlBase64ToUint8Array(base64String) {
        const padding = '='.repeat((4 - (base64String.length % 4)) % 4);
        const base64 = (base64String + padding)
            .replace(/\-/g, '+')
            .replace(/_/g, '/');

        const rawData = window.atob(base64);
        const outputArray = new Uint8Array(rawData.length);

        for (let i = 0; i < rawData.length; ++i) {
            outputArray[i] = rawData.charCodeAt(i);
        }
        return outputArray;
    }

    class PushService {
        constructor() {
            this.publicKey = window.OURCORNER_VAPID_PUBLIC_KEY || DEFAULT_VAPID_PUBLIC_KEY;
            this.subscription = null;
        }

        /**
         * Comprueba si el navegador y dispositivo soportan Web Push
         */
        isSupported() {
            return ('serviceWorker' in navigator &&
                    'PushManager' in window &&
                    'Notification' in window);
        }

        /**
         * Obtiene el estado actual del permiso ('default', 'granted', 'denied')
         */
        getPermissionState() {
            if (!('Notification' in window)) return 'unsupported';
            return Notification.permission;
        }

        /**
         * Obtiene la suscripción activa si existe
         */
        async getExistingSubscription() {
            if (!this.isSupported()) return null;
            try {
                const reg = await navigator.serviceWorker.ready;
                this.subscription = await reg.pushManager.getSubscription();
                return this.subscription;
            } catch (err) {
                console.error('Error al consultar suscripción push existente:', err);
                return null;
            }
        }

        /**
         * Solicita permiso y registra la suscripción en Supabase.
         * DEBE llamarse únicamente tras un clic voluntario del usuario.
         */
        async subscribe() {
            if (!this.isSupported()) {
                return {
                    success: false,
                    error: 'Este navegador o dispositivo no soporta notificaciones Web Push'
                };
            }

            try {
                // 1. Solicitar permiso explícito al usuario
                const permission = await Notification.requestPermission();
                if (permission !== 'granted') {
                    return {
                        success: false,
                        error: permission === 'denied'
                            ? 'Has bloqueado los permisos de notificaciones. Puedes activarlos desde los ajustes de tu navegador.'
                            : 'No se otorgaron permisos de notificación.'
                    };
                }

                // 2. Verificar sesión de usuario en Supabase
                const sb = window.supabaseClient;
                if (!sb) {
                    return { success: false, error: 'Cliente de Supabase no disponible' };
                }

                const { data: { session } } = await sb.auth.getSession();
                if (!session || !session.user) {
                    return {
                        success: false,
                        error: 'Debes iniciar sesión para activar las notificaciones de OurCorner'
                    };
                }

                const userId = session.user.id;

                // 3. Obtener Service Worker activo
                const registration = await navigator.serviceWorker.ready;

                // 4. Suscribirse a PushManager con la clave VAPID
                const convertedVapidKey = urlBase64ToUint8Array(this.publicKey);
                let subscription = await registration.pushManager.getSubscription();

                if (!subscription) {
                    subscription = await registration.pushManager.subscribe({
                        userVisibleOnly: true,
                        applicationServerKey: convertedVapidKey
                    });
                }

                this.subscription = subscription;

                // 5. Extraer claves de cifrado de la suscripción (p256dh y auth)
                const rawP256dh = subscription.getKey('p256dh');
                const rawAuth = subscription.getKey('auth');

                if (!rawP256dh || !rawAuth) {
                    throw new Error('No se pudieron obtener las claves criptográficas de la suscripción');
                }

                const p256dh = btoa(String.fromCharCode.apply(null, new Uint8Array(rawP256dh)));
                const auth = btoa(String.fromCharCode.apply(null, new Uint8Array(rawAuth)));
                const endpoint = subscription.endpoint;

                // 6. Guardar / Actualizar en Supabase (tabla push_subscriptions)
                const { error: dbError } = await sb
                    .from('push_subscriptions')
                    .upsert({
                        user_id: userId,
                        endpoint,
                        p256dh,
                        auth,
                        user_agent: navigator.userAgent.substring(0, 500)
                    }, { onConflict: 'endpoint' });

                if (dbError) {
                    console.error('❌ Error al guardar suscripción en Supabase:', dbError);
                    throw dbError;
                }

                console.log('✅ [PushService] Suscripción Web Push registrada con éxito en Supabase');
                window.dispatchEvent(new CustomEvent('pwa-push-subscribed', { detail: { endpoint } }));

                return {
                    success: true,
                    subscription
                };

            } catch (err) {
                console.error('❌ Error en PushService.subscribe:', err);
                return {
                    success: false,
                    error: err.message || 'Error al activar notificaciones'
                };
            }
        }

        /**
         * Cancela la suscripción Push y la elimina de Supabase
         */
        async unsubscribe() {
            try {
                const sub = await this.getExistingSubscription();
                if (!sub) return { success: true };

                const endpoint = sub.endpoint;

                // 1. Eliminar de Supabase
                const sb = window.supabaseClient;
                if (sb) {
                    await sb.from('push_subscriptions').delete().eq('endpoint', endpoint);
                }

                // 2. Anular en el navegador
                await sub.unsubscribe();
                this.subscription = null;

                console.log('✅ [PushService] Suscripción cancelada exitosamente');
                window.dispatchEvent(new CustomEvent('pwa-push-unsubscribed'));

                return { success: true };
            } catch (err) {
                console.error('❌ Error al cancelar suscripción push:', err);
                return { success: false, error: err.message };
            }
        }

        /**
         * Envía una notificación Web Push a través de la Edge Function `send-push`
         * @param {string} recipientId UUID del usuario que recibirá la notificación
         * @param {object} notification Objeto con title, body, url, etc.
         */
        async sendPushNotification(recipientId, notification) {
            const sb = window.supabaseClient;
            if (!sb) throw new Error('Supabase client no disponible');

            try {
                const { data, error } = await sb.functions.invoke('send-push', {
                    body: {
                        recipient_id: recipientId,
                        title: notification.title || 'OurCorner 💕',
                        body: notification.body || 'Tienes un nuevo mensaje',
                        url: notification.url || './index.html',
                        tag: notification.tag || 'ourcorner-message',
                        actions: notification.actions
                    }
                });

                if (error) throw error;
                return { success: true, data };
            } catch (err) {
                console.error('❌ Error invocando Edge Function send-push:', err);
                return { success: false, error: err.message };
            }
        }
    }

    // Instancia global
    window.pushService = new PushService();
})();
