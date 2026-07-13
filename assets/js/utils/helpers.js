/**
 * 🛠️ Utilidades compartidas
 * - escapeHtml(): sanitiza texto antes de insertarlo con innerHTML
 * - appLog()/appWarn(): logging condicionado a entorno de desarrollo
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
     * console.log condicionado: solo imprime en localhost o con ?debug=1
     */
    function appLog(...args) {
        if (window.APP_DEBUG) console.log(...args);
    }

    window.escapeHtml = escapeHtml;
    window.appLog = appLog;
})();
