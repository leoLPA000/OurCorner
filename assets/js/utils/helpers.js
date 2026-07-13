/**
 * 🛠️ Utilidades compartidas
 * - escapeHtml(): sanitiza texto antes de insertarlo con innerHTML
 * - appLog(): logging condicionado a entorno de desarrollo (localhost)
 * - requireLogin(): gate de "debes iniciar sesión" reutilizado por varios controllers
 *
 * Cargar este script ANTES que cualquier otro script de assets/js.
 */

(function () {
    'use strict';

    // Entorno de desarrollo: solo localhost/127.0.0.1 (no activable desde producción)
    const isDev = ['localhost', '127.0.0.1', ''].includes(window.location.hostname);

    window.APP_DEBUG = isDev;

    /**
     * Escapa caracteres HTML especiales para prevenir XSS al usar innerHTML
     * con datos que vienen del usuario o de la base de datos.
     */
    function escapeHtml(value) {
        if (value === null || value === undefined) return '';
        return String(value)
            .replace(/&/g, '&amp;')
            .replace(/</g, '&lt;')
            .replace(/>/g, '&gt;')
            .replace(/"/g, '&quot;')
            .replace(/'/g, '&#39;');
    }

    /**
     * console.log condicionado: solo imprime en localhost
     */
    function appLog(...args) {
        if (window.APP_DEBUG) console.log(...args);
    }

    /**
     * Gate reutilizable: si no hay sesión iniciada, muestra `mensaje` y redirige
     * a login (conservando la página actual como `return`). Devuelve true si
     * el usuario ya está autenticado, false si se disparó la redirección.
     *
     * Sustituye el bloque que se repetía igual en varios controllers:
     *   if (!window.authService || !window.authService.isAuthenticated()) {
     *       alert(mensaje);
     *       window.location.href = '/OurCorner/views/login.html?return=' + ...;
     *       return; // o throw, según el llamador
     *   }
     */
    function requireLogin(mensaje) {
        if (window.authService && window.authService.isAuthenticated()) {
            return true;
        }
        alert(mensaje);
        window.location.href = '/OurCorner/views/login.html?return=' + encodeURIComponent(window.location.pathname);
        return false;
    }

    window.escapeHtml = escapeHtml;
    window.appLog = appLog;
    window.requireLogin = requireLogin;
})();
