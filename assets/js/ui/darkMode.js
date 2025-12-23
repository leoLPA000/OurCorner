/**
 * 🌙 MODO OSCURO/CLARO
 * Toggle con persistencia en localStorage
 */

class ModoOscuro {
    constructor() {
        this.oscuro = false;
        this.init();
    }
    
    init() {
        // Cargar preferencia guardada
        const preferencia = localStorage.getItem('tema-oscuro');
        this.oscuro = preferencia === 'true';
        
        // Crear toggle
        this.crearToggle();
        
        // Aplicar tema inicial
        if (this.oscuro) {
            this.activarModoOscuro();
        }
        
        // Bind eventos
        this.bindEventos();
    }
    
    crearToggle() {
        const toggle = document.createElement('div');
        toggle.className = 'tema-toggle';
        toggle.innerHTML = `
            <div class="toggle-container">
                <span class="toggle-icono sol">☀️</span>
                <label class="toggle-switch">
                    <input type="checkbox" ${this.oscuro ? 'checked' : ''}>
                    <span class="toggle-slider"></span>
                </label>
                <span class="toggle-icono luna">🌙</span>
            </div>
            <span class="toggle-texto">Modo ${this.oscuro ? 'Oscuro' : 'Claro'}</span>
        `;
        
        document.body.appendChild(toggle);
    }
    
    bindEventos() {
        const checkbox = document.querySelector('.tema-toggle input[type="checkbox"]');
        checkbox.addEventListener('change', (e) => {
            if (e.target.checked) {
                this.activarModoOscuro();
            } else {
                this.activarModoClaro();
            }
        });
    }
    
    activarModoOscuro() {
        this.oscuro = true;
        document.body.classList.add('tema-oscuro');
        localStorage.setItem('tema-oscuro', 'true');
        
        // Actualizar texto
        const texto = document.querySelector('.toggle-texto');
        if (texto) texto.textContent = 'Modo Oscuro';
        
        // Animación suave
        this.animarCambio();
    }
    
    activarModoClaro() {
        this.oscuro = false;
        document.body.classList.remove('tema-oscuro');
        localStorage.setItem('tema-oscuro', 'false');
        
        // Actualizar texto
        const texto = document.querySelector('.toggle-texto');
        if (texto) texto.textContent = 'Modo Claro';
        
        // Animación suave
        this.animarCambio();
    }
    
    animarCambio() {
        // Crear overlay de transición
        const overlay = document.createElement('div');
        overlay.className = 'transicion-tema';
        document.body.appendChild(overlay);
        
        setTimeout(() => {
            overlay.remove();
        }, 500);
        
        // Efecto de partículas
        this.crearParticulasCambio();
    }
    
    crearParticulasCambio() {
        const numParticulas = 8;
        const icono = this.oscuro ? '🌙' : '☀️';
        
        for (let i = 0; i < numParticulas; i++) {
            const particula = document.createElement('div');
            particula.className = 'particula-tema';
            particula.textContent = icono;
            particula.style.left = Math.random() * 100 + '%';
            particula.style.animationDelay = (i * 0.1) + 's';
            
            document.body.appendChild(particula);
            
            setTimeout(() => {
                particula.remove();
            }, 2000);
        }
    }
}

// Inicializar cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
    new ModoOscuro();
});
