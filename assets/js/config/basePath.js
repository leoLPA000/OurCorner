/**
 * 📍 Detector automático de base path
 * Funciona en: localhost, GitHub Pages (/OurCorner/) y Vercel (sin /OurCorner/)
 */

const BASE_PATH = (() => {
    const hostname = window.location.hostname;
    const pathname = window.location.pathname;

    // ✅ Vercel (nuestronidito-dud56to3h...vercel.app)
    if (hostname.includes('vercel.app')) {
        return '';
    }

    // ✅ GitHub Pages (leolpa000.github.io/OurCorner/...)
    if (hostname.includes('github.io')) {
        return '/OurCorner';
    }

    // ✅ Localhost development
    if (hostname === 'localhost' || hostname === '127.0.0.1') {
        // Si está en http://localhost/OurCorner/
        if (pathname.includes('/OurCorner/')) {
            return '/OurCorner';
        }
        // Si está en http://localhost:3000/ (desarrollo directo)
        return '';
    }

    // 🔍 Por defecto, intenta detectar si /OurCorner está en el path
    return pathname.includes('/OurCorner/') ? '/OurCorner' : '';
})();

// Función helper para construir rutas
function getRoute(path) {
    if (path.startsWith('/')) {
        return BASE_PATH + path;
    }
    return BASE_PATH + '/' + path;
}

// Exportar para que sea accesible globalmente
window.BASE_PATH = BASE_PATH;
window.getRoute = getRoute;
