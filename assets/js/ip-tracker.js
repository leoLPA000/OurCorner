/**
 * IP Tracker - Cliente JavaScript
 * Captura información detallada del dispositivo de forma silenciosa
 */

class IPTracker {
    constructor(endpoint = '/archivosPHP/ip-logger.php') {
        this.endpoint = endpoint;
        this.datos = {};
        this.inicializado = false;
    }

    // Inicializar captura automática
    async iniciar() {
        if (this.inicializado) return;
        this.inicializado = true;

        try {
            await this.recopilarDatos();
            await this.enviarDatos();
        } catch (error) {
            // Falla silenciosamente
            console.debug('Tracker:', error);
        }
    }

    // Recopilar toda la información del cliente
    async recopilarDatos() {
        this.datos = {
            // Información básica del navegador
            pantalla: this.obtenerInfoPantalla(),
            idioma: navigator.language || navigator.userLanguage,
            idiomas: navigator.languages,
            zona_horaria: Intl.DateTimeFormat().resolvedOptions().timeZone,
            plataforma: navigator.platform,
            cookies_habilitadas: navigator.cookieEnabled,
            dnt: navigator.doNotTrack,
            
            // Información de hardware
            nucleos_cpu: navigator.hardwareConcurrency || 'No disponible',
            memoria: navigator.deviceMemory ? `${navigator.deviceMemory}GB` : 'No disponible',
            
            // Información de navegación
            url_actual: window.location.href,
            referrer: document.referrer || 'Directo',
            
            // Plugins y capacidades
            plugins: this.obtenerPlugins(),
            fuentes: await this.detectarFuentes(),
            
            // Fingerprints avanzados
            canvas_fingerprint: await this.obtenerCanvasFingerprint(),
            webgl_vendor: this.obtenerWebGLVendor(),
            webgl_renderer: this.obtenerWebGLRenderer(),
            audio_fingerprint: await this.obtenerAudioFingerprint(),
            
            // Información de red y conexión
            conexion: this.obtenerInfoConexion(),
            ip_local: await this.obtenerIPLocal(),
            
            // Batería (si está disponible)
            bateria: await this.obtenerInfoBateria(),
            
            // Fingerprint único combinado
            fingerprint: await this.generarFingerprint(),
            
            // Timestamp
            timestamp_cliente: new Date().toISOString()
        };

        return this.datos;
    }

    // Obtener información de pantalla
    obtenerInfoPantalla() {
        return {
            resolucion: `${screen.width}x${screen.height}`,
            profundidad_color: screen.colorDepth,
            profundidad_pixel: screen.pixelDepth,
            resolucion_disponible: `${screen.availWidth}x${screen.availHeight}`,
            orientacion: screen.orientation?.type || 'No disponible',
            touch_support: 'ontouchstart' in window || navigator.maxTouchPoints > 0,
            zoom: window.devicePixelRatio
        };
    }

    // Obtener plugins instalados
    obtenerPlugins() {
        const plugins = [];
        for (let i = 0; i < navigator.plugins.length; i++) {
            plugins.push({
                nombre: navigator.plugins[i].name,
                descripcion: navigator.plugins[i].description
            });
        }
        return plugins;
    }

    // Detectar fuentes instaladas
    async detectarFuentes() {
        const fuentesBase = [
            'Arial', 'Verdana', 'Times New Roman', 'Courier New',
            'Georgia', 'Palatino', 'Garamond', 'Comic Sans MS',
            'Trebuchet MS', 'Impact', 'Arial Black', 'Tahoma',
            'Lucida Console', 'Monaco', 'Helvetica', 'Calibri'
        ];
        
        const fuentesDetectadas = [];
        const canvas = document.createElement('canvas');
        const ctx = canvas.getContext('2d');
        
        const textoBase = 'mmmmmmmmmmlli';
        const baseline = ctx.measureText(textoBase).width;
        
        for (const fuente of fuentesBase) {
            ctx.font = `72px "${fuente}", monospace`;
            const ancho = ctx.measureText(textoBase).width;
            if (ancho !== baseline) {
                fuentesDetectadas.push(fuente);
            }
        }
        
        return fuentesDetectadas;
    }

    // Canvas Fingerprint
    async obtenerCanvasFingerprint() {
        try {
            const canvas = document.createElement('canvas');
            const ctx = canvas.getContext('2d');
            
            ctx.textBaseline = 'top';
            ctx.font = '14px Arial';
            ctx.textBaseline = 'alphabetic';
            ctx.fillStyle = '#f60';
            ctx.fillRect(125, 1, 62, 20);
            ctx.fillStyle = '#069';
            ctx.fillText('🎨 Canvas Fingerprint 🔒', 2, 15);
            ctx.fillStyle = 'rgba(102, 204, 0, 0.7)';
            ctx.fillText('Canvas 123 !@#', 4, 17);
            
            return canvas.toDataURL().slice(-50); // Solo últimos 50 caracteres
        } catch (e) {
            return null;
        }
    }

    // WebGL Vendor
    obtenerWebGLVendor() {
        try {
            const canvas = document.createElement('canvas');
            const gl = canvas.getContext('webgl') || canvas.getContext('experimental-webgl');
            const debugInfo = gl.getExtension('WEBGL_debug_renderer_info');
            return gl.getParameter(debugInfo.UNMASKED_VENDOR_WEBGL);
        } catch (e) {
            return 'No disponible';
        }
    }

    // WebGL Renderer
    obtenerWebGLRenderer() {
        try {
            const canvas = document.createElement('canvas');
            const gl = canvas.getContext('webgl') || canvas.getContext('experimental-webgl');
            const debugInfo = gl.getExtension('WEBGL_debug_renderer_info');
            return gl.getParameter(debugInfo.UNMASKED_RENDERER_WEBGL);
        } catch (e) {
            return 'No disponible';
        }
    }

    // Audio Fingerprint
    async obtenerAudioFingerprint() {
        try {
            const context = new (window.AudioContext || window.webkitAudioContext)();
            const oscillator = context.createOscillator();
            const analyser = context.createAnalyser();
            const gainNode = context.createGain();
            const scriptProcessor = context.createScriptProcessor(4096, 1, 1);
            
            gainNode.gain.value = 0; // Silencioso
            oscillator.connect(analyser);
            analyser.connect(scriptProcessor);
            scriptProcessor.connect(gainNode);
            gainNode.connect(context.destination);
            
            oscillator.start(0);
            
            return new Promise(resolve => {
                scriptProcessor.onaudioprocess = function(event) {
                    const output = event.outputBuffer.getChannelData(0);
                    let sum = 0;
                    for (let i = 0; i < output.length; i++) {
                        sum += Math.abs(output[i]);
                    }
                    oscillator.stop();
                    scriptProcessor.disconnect();
                    resolve(sum.toString().slice(0, 20));
                };
            });
        } catch (e) {
            return null;
        }
    }

    // Información de conexión
    obtenerInfoConexion() {
        const conexion = navigator.connection || navigator.mozConnection || navigator.webkitConnection;
        if (conexion) {
            return {
                tipo: conexion.effectiveType,
                downlink: conexion.downlink,
                rtt: conexion.rtt,
                saveData: conexion.saveData
            };
        }
        return null;
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
                }, 3000);
                
                pc.onicecandidate = (ice) => {
                    if (!ice || !ice.candidate || !ice.candidate.candidate) return;
                    
                    const ipRegex = /([0-9]{1,3}\.){3}[0-9]{1,3}/;
                    const ipMatch = ipRegex.exec(ice.candidate.candidate);
                    
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

    // Información de batería
    async obtenerInfoBateria() {
        try {
            if ('getBattery' in navigator) {
                const battery = await navigator.getBattery();
                return {
                    nivel: Math.round(battery.level * 100) + '%',
                    cargando: battery.charging,
                    tiempo_carga: battery.chargingTime,
                    tiempo_descarga: battery.dischargingTime
                };
            }
        } catch (e) {
            return null;
        }
        return null;
    }

    // Generar fingerprint único
    async generarFingerprint() {
        const componentes = [
            navigator.userAgent,
            navigator.language,
            screen.width + 'x' + screen.height,
            screen.colorDepth,
            new Date().getTimezoneOffset(),
            navigator.platform,
            navigator.hardwareConcurrency,
            this.datos.canvas_fingerprint
        ].join('|');
        
        // Hash simple (para un hash real usa crypto.subtle.digest)
        let hash = 0;
        for (let i = 0; i < componentes.length; i++) {
            const char = componentes.charCodeAt(i);
            hash = ((hash << 5) - hash) + char;
            hash = hash & hash;
        }
        return Math.abs(hash).toString(36);
    }

    // Enviar datos al servidor
    async enviarDatos() {
        try {
            const response = await fetch(this.endpoint, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(this.datos)
            });
            
            const resultado = await response.json();
            return resultado;
        } catch (error) {
            console.debug('Error al enviar datos:', error);
            return null;
        }
    }

    // Método público para obtener datos sin enviar
    async obtenerDatos() {
        await this.recopilarDatos();
        return this.datos;
    }
}

// Inicialización automática y silenciosa
(function() {
    // Esperar a que el DOM esté listo
    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', iniciarTracker);
    } else {
        iniciarTracker();
    }

    function iniciarTracker() {
        // Pequeño delay para no ser obvio
        setTimeout(() => {
            const tracker = new IPTracker();
            tracker.iniciar();
            
            // Hacer disponible globalmente para debugging (opcional)
            window.__tracker = tracker;
        }, 1000);
    }
})();

// Exportar para uso manual si es necesario
if (typeof module !== 'undefined' && module.exports) {
    module.exports = IPTracker;
}
