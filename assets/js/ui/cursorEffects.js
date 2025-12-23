// Efectos de cursor con partículas románticas
class CursorEffects {
    constructor() {
        this.particles = [];
        this.mouseX = 0;
        this.mouseY = 0;
        this.isTouch = false;
        this.container = document.getElementById('cursor-particles');
        this.customCursor = null;
        
        this.init();
    }
    
    init() {
        // Detectar si es dispositivo táctil
        this.isTouch = 'ontouchstart' in window || navigator.maxTouchPoints > 0;
        
        if (!this.isTouch) {
            // Para escritorio - crear cursor personalizado
            this.createCustomCursor();
            this.bindMouseEvents();
        } else {
            // Para móviles - usar eventos táctiles
            this.bindTouchEvents();
        }
        
        // Iniciar el loop de animación
        this.animate();
    }
    
    createCustomCursor() {
        this.customCursor = document.createElement('div');
        this.customCursor.className = 'custom-cursor';
        document.body.appendChild(this.customCursor);
    }
    
    bindMouseEvents() {
        let lastParticleTime = 0;
        const particleThrottle = 150; // Mínimo 150ms entre partículas
        
        document.addEventListener('mousemove', (e) => {
            this.mouseX = e.clientX;
            this.mouseY = e.clientY;
            
            // Actualizar cursor personalizado
            if (this.customCursor) {
                this.customCursor.style.left = (this.mouseX - 10) + 'px';
                this.customCursor.style.top = (this.mouseY - 10) + 'px';
            }
            
            // Crear partícula solo cada 150ms (throttle)
            const now = Date.now();
            if (now - lastParticleTime > particleThrottle && Math.random() < 0.15) { // Solo 15%
                this.createParticle(this.mouseX, this.mouseY);
                lastParticleTime = now;
            }
        });
        
        document.addEventListener('mousedown', () => {
            if (this.customCursor) {
                this.customCursor.classList.add('clicking');
            }
            // Crear solo 3 partículas al hacer clic (reducido de 5)
            for (let i = 0; i < 3; i++) {
                setTimeout(() => {
                    this.createParticle(
                        this.mouseX + (Math.random() - 0.5) * 20,
                        this.mouseY + (Math.random() - 0.5) * 20
                    );
                }, i * 80);
            }
        });
        
        document.addEventListener('mouseup', () => {
            if (this.customCursor) {
                this.customCursor.classList.remove('clicking');
            }
        });
    }
    
    bindTouchEvents() {
        let lastTouchTime = 0;
        const touchThrottle = 250; // Throttle más agresivo para móvil
        
        document.addEventListener('touchmove', (e) => {
            const now = Date.now();
            if (now - lastTouchTime < touchThrottle) return;
            
            const touch = e.touches[0];
            this.mouseX = touch.clientX;
            this.mouseY = touch.clientY;
            
            // Solo crear partícula cada 250ms
            if (Math.random() < 0.3) { // 30% probabilidad
                this.createParticle(this.mouseX, this.mouseY);
                lastTouchTime = now;
            }
        }, { passive: true }); // Cambiar a passive para mejor performance
        
        document.addEventListener('touchstart', (e) => {
            const touch = e.touches[0];
            this.mouseX = touch.clientX;
            this.mouseY = touch.clientY;
            
            // Solo 2 partículas al tocar (reducido de 3)
            for (let i = 0; i < 2; i++) {
                setTimeout(() => {
                    this.createParticle(
                        this.mouseX + (Math.random() - 0.5) * 15,
                        this.mouseY + (Math.random() - 0.5) * 15
                    );
                }, i * 50);
            }
        });
    }
    
    createParticle(x, y) {
        // Limitar el número máximo de partículas simultáneas
        if (this.particles.length > 30) return;
        
        const particle = document.createElement('div');
        particle.className = 'cursor-particle';
        
        // Solo 2 tipos de partículas para mejor rendimiento
        const types = ['heart', 'sparkle'];
        const randomType = types[Math.floor(Math.random() * types.length)];
        
        particle.classList.add(randomType);
        
        // Contenido según el tipo
        if (randomType === 'heart') {
            const hearts = ['💕', '💖', '💗', '💝', '💘', '❤️', '❤️‍🔥', '💜'];
            particle.textContent = hearts[Math.floor(Math.random() * hearts.length)];
            particle.style.fontSize = (Math.random() * 6 + 10) + 'px';
        }
        
        // Posición inicial
        particle.style.left = x + 'px';
        particle.style.top = y + 'px';
        
        // Duración más corta para limpieza más rápida
        const randomDuration = 600 + Math.random() * 300; // 600-900ms (reducido)
        const randomDirection = (Math.random() - 0.5) * 40;
        
        particle.style.animationDuration = randomDuration + 'ms';
        particle.style.setProperty('--random-x', randomDirection + 'px');
        
        this.container.appendChild(particle);
        this.particles.push({
            element: particle,
            birthTime: Date.now(),
            duration: randomDuration
        });
        
        // Eliminar partícula después de la animación
        setTimeout(() => {
            if (particle.parentNode) {
                particle.parentNode.removeChild(particle);
            }
        }, randomDuration);
    }
    
    animate() {
        // Limpiar partículas viejas
        const now = Date.now();
        this.particles = this.particles.filter(particle => {
            if (now - particle.birthTime > particle.duration) {
                if (particle.element.parentNode) {
                    particle.element.parentNode.removeChild(particle.element);
                }
                return false;
            }
            return true;
        });
        
        requestAnimationFrame(() => this.animate());
    }
}

// Efectos adicionales para mejorar la experiencia
class RomanticEnhancements {
    constructor() {
        this.addHoverEffects();
        this.addClickRipples();
    }
    
    addHoverEffects() {
        // Efecto especial cuando el cursor está sobre las categorías
        const categorias = document.querySelectorAll('.categoria-card');
        categorias.forEach(card => {
            let hoverTimeout;
            card.addEventListener('mouseenter', () => {
                // Solo 2 corazones al entrar (reducido de 3)
                clearTimeout(hoverTimeout);
                hoverTimeout = setTimeout(() => {
                    const rect = card.getBoundingClientRect();
                    const centerX = rect.left + rect.width / 2;
                    const centerY = rect.top + rect.height / 2;
                    window.cursorEffects.createParticle(centerX, centerY);
                    
                    setTimeout(() => {
                        window.cursorEffects.createParticle(
                            centerX + (Math.random() - 0.5) * 30,
                            centerY + (Math.random() - 0.5) * 30
                        );
                    }, 100);
                }, 50); // Pequeño delay para evitar spam
            });
        });
        
        // Efecto en mensajes - MUY REDUCIDO
        const mensajes = document.querySelectorAll('.mensaje-card');
        mensajes.forEach(mensaje => {
            let hoverTimeout;
            mensaje.addEventListener('mouseenter', () => {
                // Solo 1 partícula (reducido de 2)
                clearTimeout(hoverTimeout);
                hoverTimeout = setTimeout(() => {
                    const rect = mensaje.getBoundingClientRect();
                    window.cursorEffects.createParticle(
                        rect.left + Math.random() * rect.width,
                        rect.top + Math.random() * rect.height
                    );
                }, 100);
            });
        });
        
        // Efecto en botones - REDUCIDO
        const botones = document.querySelectorAll('.btn-aleatorio, .btn-volver, .btn-inicio');
        botones.forEach(boton => {
            let clickTimeout;
            boton.addEventListener('click', () => {
                clearTimeout(clickTimeout);
                clickTimeout = setTimeout(() => {
                    const rect = boton.getBoundingClientRect();
                    const centerX = rect.left + rect.width / 2;
                    const centerY = rect.top + rect.height / 2;
                    
                    // Solo 4 partículas (reducido de 8)
                    for (let i = 0; i < 4; i++) {
                        setTimeout(() => {
                            const angle = (Math.PI * 2 * i) / 4;
                            const distance = 25;
                            window.cursorEffects.createParticle(
                                centerX + Math.cos(angle) * distance,
                                centerY + Math.sin(angle) * distance
                            );
                        }, i * 60);
                    }
                }, 0);
            });
        });
    }
    
    addClickRipples() {
        let lastRippleTime = 0;
        const rippleThrottle = 300; // Mínimo 300ms entre ripples
        
        document.addEventListener('click', (e) => {
            const now = Date.now();
            if (now - lastRippleTime < rippleThrottle) return;
            lastRippleTime = now;
            
            // Crear efecto de ondas al hacer clic (más ligero)
            const ripple = document.createElement('div');
            ripple.style.position = 'fixed';
            ripple.style.left = e.clientX + 'px';
            ripple.style.top = e.clientY + 'px';
            ripple.style.width = '0px';
            ripple.style.height = '0px';
            ripple.style.borderRadius = '50%';
            ripple.style.background = 'radial-gradient(circle, rgba(255, 182, 193, 0.3), transparent)';
            ripple.style.pointerEvents = 'none';
            ripple.style.zIndex = '9998';
            ripple.style.animation = 'rippleEffect 0.5s ease-out forwards';
            ripple.style.userSelect = 'none';
            
            document.body.appendChild(ripple);
            
            setTimeout(() => {
                if (ripple.parentNode) {
                    ripple.parentNode.removeChild(ripple);
                }
            }, 500);
        });
    }
}

// Inicializar efectos cuando el DOM esté listo
if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', () => {
        window.cursorEffects = new CursorEffects();
        new RomanticEnhancements();
        console.log('💕 Efectos de cursor activados para Rocío');
    });
} else {
    window.cursorEffects = new CursorEffects();
    new RomanticEnhancements();
    console.log('💕 Efectos de cursor activados para Rocío');
}