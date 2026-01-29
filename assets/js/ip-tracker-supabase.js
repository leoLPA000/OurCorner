/**
 * IP Tracker con Supabase
 * Versión completa para GitHub Pages + Supabase
 * Captura información detallada y la almacena en la nube
 */

class IPTrackerSupabase {
    constructor() {
        this.datos = {};
        this.supabase = null;
        this.initialized = false;
    }

    // Inicializar conexión a Supabase
    async init() {
        // Esperar a que Supabase esté disponible
        if (typeof window.supabaseClient !== 'undefined' && window.supabaseClient) {
            this.supabase = window.supabaseClient;
            this.initialized = true;
            return true;
        }
        
        // Reintentar hasta 5 veces
        for (let i = 0; i < 5; i++) {
            await this.sleep(500);
            if (typeof window.supabaseClient !== 'undefined' && window.supabaseClient) {
                this.supabase = window.supabaseClient;
                this.initialized = true;
                return true;
            }
        }
        
        console.error('Supabase no disponible');
        return false;
    }

    // Iniciar captura completa
    async iniciar() {
        try {
            // Inicializar Supabase
            const supabaseOK = await this.init();
            if (!supabaseOK) {
                console.warn('No se pudo conectar a Supabase. Datos no se guardarán.');
                return null;
            }

            // Recopilar todos los datos
            await this.recopilarDatos();
            
            // Guardar en Supabase
            const resultado = await this.guardarEnSupabase();
            
            // También guardar copia local por si acaso
            this.guardarLocal();
            
            return resultado;
        } catch (error) {
            console.debug('Error en tracker:', error);
            return null;
        }
    }

    // Recopilar toda la información del visitante
    async recopilarDatos() {
        const id = this.generarID();
        
        // 1. IP y Geolocalización
        const geoData = await this.obtenerIPyGeo();
        
        // 2. Información del navegador
        const browserData = this.obtenerInfoNavegador();
        
        // 3. Hardware
        const hardwareData = this.obtenerInfoHardware();
        
        // 4. Fingerprints
        const fingerprints = await this.obtenerFingerprints();
        
        // 5. IP Local
        const ipLocal = await this.obtenerIPLocal();
        
        this.datos = {
            visitor_id: id,
            timestamp: new Date().toISOString(),
            ...geoData,
            ...browserData,
            ...hardwareData,
            ...fingerprints,
            ip_local: ipLocal,
            datos_completos: null // Se llenará con todos los datos
        };
        
        // Guardar datos completos en JSON
        this.datos.datos_completos = { ...this.datos };
        
        return this.datos;
    }

    // Obtener IP + Geolocalización
    async obtenerIPyGeo() {
        try {
            // Intentar ipapi.co primero (más completo)
            const response = await fetch('https://ipapi.co/json/');
            const data = await response.json();
            
            return {
                ip_publica: data.ip,
                pais: data.country_name,
                codigo_pais: data.country_code,
                region: data.region,
                ciudad: data.city,
                codigo_postal: data.postal,
                latitud: data.latitude,
                longitud: data.longitude,
                zona_horaria: data.timezone,
                isp: data.org,
                asn: data.asn
            };
        } catch (e) {
            // Fallback a ip-api.com
            try {
                const ipRes = await fetch('https://api.ipify.org?format=json');
                const ipData = await ipRes.json();
                const ip = ipData.ip;
                
                const geoRes = await fetch(`http://ip-api.com/json/${ip}`);
                const geoData = await geoRes.json();
                
                return {
                    ip_publica: ip,
                    pais: geoData.country,
                    codigo_pais: geoData.countryCode,
                    region: geoData.regionName,
                    ciudad: geoData.city,
                    latitud: geoData.lat,
                    longitud: geoData.lon,
                    zona_horaria: geoData.timezone,
                    isp: geoData.isp,
                    asn: geoData.as
                };
            } catch (err) {
                return {
                    ip_publica: 'No disponible',
                    pais: 'Desconocido'
                };
            }
        }
    }

    // Información del navegador
    obtenerInfoNavegador() {
        const ua = navigator.userAgent;
        
        return {
            navegador: this.detectarNavegador(ua),
            sistema_operativo: this.detectarSO(ua),
            plataforma: navigator.platform,
            tipo_dispositivo: this.detectarDispositivo(ua),
            es_movil: /mobile/i.test(ua),
            user_agent: ua,
            idioma: navigator.language,
            idiomas: navigator.languages || [],
            cookies_habilitadas: navigator.cookieEnabled,
            dnt: navigator.doNotTrack || '0',
            url_actual: window.location.href,
            url_referrer: document.referrer || 'Directo'
        };
    }

    // Información de hardware
    obtenerInfoHardware() {
        return {
            resolucion_pantalla: `${screen.width}x${screen.height}`,
            profundidad_color: screen.colorDepth,
            nucleos_cpu: navigator.hardwareConcurrency || null,
            memoria: navigator.deviceMemory ? `${navigator.deviceMemory}GB` : null
        };
    }

    // Obtener fingerprints
    async obtenerFingerprints() {
        const canvas = await this.canvasFingerprint();
        const webgl = this.webglFingerprint();
        
        return {
            canvas_fp: canvas,
            webgl_vendor: webgl.vendor,
            webgl_renderer: webgl.renderer,
            fingerprint_unico: this.generarFingerprintUnico()
        };
    }

    // Canvas fingerprint
    async canvasFingerprint() {
        try {
            const canvas = document.createElement('canvas');
            const ctx = canvas.getContext('2d');
            ctx.textBaseline = 'top';
            ctx.font = '14px Arial';
            ctx.fillStyle = '#f60';
            ctx.fillRect(125, 1, 62, 20);
            ctx.fillStyle = '#069';
            ctx.fillText('Canvas Fingerprint', 2, 15);
            return canvas.toDataURL().slice(-50);
        } catch (e) {
            return null;
        }
    }

    // WebGL fingerprint
    webglFingerprint() {
        try {
            const canvas = document.createElement('canvas');
            const gl = canvas.getContext('webgl') || canvas.getContext('experimental-webgl');
            const debugInfo = gl.getExtension('WEBGL_debug_renderer_info');
            return {
                vendor: gl.getParameter(debugInfo.UNMASKED_VENDOR_WEBGL),
                renderer: gl.getParameter(debugInfo.UNMASKED_RENDERER_WEBGL)
            };
        } catch (e) {
            return { vendor: null, renderer: null };
        }
    }

    // Obtener IP local (WebRTC)
    async obtenerIPLocal() {
        return new Promise((resolve) => {
            try {
                const pc = new RTCPeerConnection({ iceServers: [] });
                pc.createDataChannel('');
                pc.createOffer().then(offer => pc.setLocalDescription(offer));
                
                const timeout = setTimeout(() => {
                    pc.close();
                    resolve(null);
                }, 2000);
                
                pc.onicecandidate = (ice) => {
                    if (!ice || !ice.candidate) return;
                    const ipMatch = /([0-9]{1,3}\.){3}[0-9]{1,3}/.exec(ice.candidate.candidate);
                    if (ipMatch) {
                        clearTimeout(timeout);
                        pc.close();
                        resolve(ipMatch[0]);
                    }
                };
            } catch (e) {
                resolve(null);
            }
        });
    }

    // Guardar en Supabase
    async guardarEnSupabase() {
        if (!this.supabase) {
            console.warn('Supabase no disponible');
            return null;
        }

        try {
            const { data, error } = await this.supabase
                .from('visitor_logs')
                .insert([this.datos])
                .select();

            if (error) {
                console.error('Error guardando en Supabase:', error);
                return null;
            }

            console.debug('✅ Datos guardados en Supabase:', data);
            return data;
        } catch (error) {
            console.error('Error en guardarEnSupabase:', error);
            return null;
        }
    }

    // Guardar copia local (backup)
    guardarLocal() {
        try {
            let logs = JSON.parse(localStorage.getItem('visitor_logs_backup') || '[]');
            logs.push({
                timestamp: this.datos.timestamp,
                ip: this.datos.ip_publica,
                ciudad: this.datos.ciudad,
                dispositivo: this.datos.tipo_dispositivo
            });
            
            // Mantener últimos 20
            if (logs.length > 20) {
                logs = logs.slice(-20);
            }
            
            localStorage.setItem('visitor_logs_backup', JSON.stringify(logs));
        } catch (e) {
            // Silencioso
        }
    }

    // Utilidades
    detectarNavegador(ua) {
        if (ua.includes('Firefox')) return 'Firefox';
        if (ua.includes('Edg')) return 'Edge';
        if (ua.includes('Chrome')) return 'Chrome';
        if (ua.includes('Safari') && !ua.includes('Chrome')) return 'Safari';
        if (ua.includes('Opera') || ua.includes('OPR')) return 'Opera';
        return 'Desconocido';
    }

    detectarSO(ua) {
        if (ua.includes('Windows NT 10')) return 'Windows 10/11';
        if (ua.includes('Windows')) return 'Windows';
        if (ua.includes('Mac OS X')) return 'macOS';
        if (ua.includes('Android')) return 'Android';
        if (ua.includes('iOS') || ua.includes('iPhone') || ua.includes('iPad')) return 'iOS';
        if (ua.includes('Linux')) return 'Linux';
        return 'Desconocido';
    }

    detectarDispositivo(ua) {
        if (/tablet|ipad/i.test(ua)) return 'Tablet';
        if (/mobile|android|iphone/i.test(ua)) return 'Móvil';
        return 'Desktop';
    }

    generarID() {
        return 'visitor_' + Date.now() + '_' + Math.random().toString(36).substr(2, 9);
    }

    generarFingerprintUnico() {
        const componentes = [
            navigator.userAgent,
            screen.width + 'x' + screen.height,
            screen.colorDepth,
            navigator.language,
            new Date().getTimezoneOffset(),
            navigator.platform,
            navigator.hardwareConcurrency || 0
        ].join('|');
        
        let hash = 0;
        for (let i = 0; i < componentes.length; i++) {
            hash = ((hash << 5) - hash) + componentes.charCodeAt(i);
            hash = hash & hash;
        }
        return Math.abs(hash).toString(36);
    }

    sleep(ms) {
        return new Promise(resolve => setTimeout(resolve, ms));
    }
}

// Auto-inicializar de forma silenciosa y discreta
(function() {
    // Esperar a que el DOM esté listo
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', iniciarTracking);
    } else {
        iniciarTracking();
    }

    function iniciarTracking() {
        // Delay de 1.5 segundos para ser discreto
        setTimeout(async () => {
            try {
                const tracker = new IPTrackerSupabase();
                const resultado = await tracker.iniciar();
                
                // Disponible globalmente para debugging (solo en desarrollo)
                if (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1') {
                    window.__tracker = tracker;
                    console.debug('🔍 Tracker activo (modo desarrollo)');
                }
            } catch (error) {
                // Falla silenciosamente en producción
                console.debug('Tracker error:', error);
            }
        }, 1500);
    }
})();

// Exportar para uso manual
if (typeof module !== 'undefined' && module.exports) {
    module.exports = IPTrackerSupabase;
}
