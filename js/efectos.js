// efectos.js - Animaciones e interactividad para NuestroMes
// ============================================================

document.addEventListener('DOMContentLoaded', function() {
    inicializarEfectos();
    crearCorazonesFlotantes();
    crearPetalosRosa();
    animarTarjetas();
});

// ============================================================
// INICIALIZAR EFECTOS
// ============================================================
function inicializarEfectos() {
    console.log('💕 Efectos cargados para Rocío (modo optimizado)');
    
    // Agregar clase de cargado
    document.body.classList.add('cargado');
    
    // Explosión de corazones desactivada para mejor rendimiento
    // Los efectos hover están en cursorEffects.js
}

// ============================================================
// CORAZONES FLOTANTES - OPTIMIZADO
// ============================================================
function crearCorazonesFlotantes() {
    const contenedor = document.getElementById('efectos-fondo');
    if (!contenedor) return;
    
    // REDUCIDO: 5 en móvil, 8 en desktop (antes 10/15)
    const numCorazones = window.innerWidth < 768 ? 5 : 8;
    
    for (let i = 0; i < numCorazones; i++) {
        setTimeout(() => {
            const corazon = document.createElement('div');
            corazon.className = 'corazon-flotante';
            corazon.innerHTML = Math.random() > 0.5 ? '❤️' : '💕';
            
            // Posición aleatoria
            corazon.style.left = Math.random() * 100 + '%';
            corazon.style.fontSize = (Math.random() * 15 + 12) + 'px'; // Más pequeños
            corazon.style.animationDuration = (Math.random() * 4 + 10) + 's'; // Más lentos
            corazon.style.animationDelay = (Math.random() * 2) + 's';
            corazon.style.opacity = Math.random() * 0.3 + 0.2; // Más transparentes
            
            contenedor.appendChild(corazon);
            
            // Remover después de la animación
            setTimeout(() => {
                if (corazon.parentNode) {
                    corazon.remove();
                }
            }, 15000);
        }, i * 1200); // Más espaciados
    }
    
    // Repetir cada 18 segundos (antes 12)
    setInterval(() => {
        crearCorazonesFlotantes();
    }, 18000);
}

// ============================================================
// PÉTALOS DE ROSA - OPTIMIZADO
// ============================================================
function crearPetalosRosa() {
    const contenedor = document.getElementById('efectos-fondo');
    if (!contenedor) return;
    
    // REDUCIDO: 4 en móvil, 6 en desktop (antes 8/12)
    const numPetalos = window.innerWidth < 768 ? 4 : 6;
    
    for (let i = 0; i < numPetalos; i++) {
        setTimeout(() => {
            const petalo = document.createElement('div');
            petalo.className = 'petalo-rosa';
            petalo.innerHTML = '🌸';
            
            // Posición y animación aleatoria
            petalo.style.left = Math.random() * 100 + '%';
            petalo.style.fontSize = (Math.random() * 12 + 10) + 'px'; // Más pequeños
            petalo.style.animationDuration = (Math.random() * 6 + 12) + 's'; // Más lentos
            petalo.style.animationDelay = (Math.random() * 3) + 's';
            petalo.style.opacity = Math.random() * 0.4 + 0.2; // Más transparentes
            
            contenedor.appendChild(petalo);
            
            // Remover después de caer
            setTimeout(() => {
                if (petalo.parentNode) {
                    petalo.remove();
                }
            }, 20000);
        }, i * 1500); // Más espaciados
    }
    
    // Repetir cada 20 segundos (antes 15)
    setInterval(() => {
        crearPetalosRosa();
    }, 20000);
}

// ============================================================
// EXPLOSIÓN DE CORAZONES AL HOVER - DESACTIVADO
// ============================================================
// Esta función está desactivada para mejorar el rendimiento
// Los efectos de hover ahora se manejan en cursorEffects.js
function crearExplosionCorazones(elemento) {
    // Función desactivada para optimización
    return;
}

// ============================================================
// ANIMAR TARJETAS DE MENSAJES
// ============================================================
function animarTarjetas() {
    const mensajes = document.querySelectorAll('.mensaje-card');
    
    mensajes.forEach((mensaje, index) => {
        mensaje.addEventListener('click', function() {
            // Agregar efecto de pulso
            this.style.animation = 'none';
            setTimeout(() => {
                this.style.animation = 'pulsoCorazon 0.6s ease';
            }, 10);
        });
    });
}

// ============================================================
// ESTILOS CSS INYECTADOS PARA EFECTOS
// ============================================================
const estilosEfectos = document.createElement('style');
estilosEfectos.textContent = `
    .corazon-flotante {
        position: fixed;
        pointer-events: none;
        z-index: 999;
        animation: flotarArriba 12s linear infinite;
        user-select: none;
    }
    
    @keyframes flotarArriba {
        0% {
            transform: translateY(100vh) rotate(0deg);
            opacity: 0;
        }
        10% {
            opacity: 0.7;
        }
        90% {
            opacity: 0.7;
        }
        100% {
            transform: translateY(-100px) rotate(360deg);
            opacity: 0;
        }
    }
    
    .petalo-rosa {
        position: fixed;
        pointer-events: none;
        z-index: 998;
        animation: caerPetalo 15s ease-in infinite;
        user-select: none;
    }
    
    @keyframes caerPetalo {
        0% {
            transform: translateY(-50px) rotate(0deg);
            opacity: 0;
        }
        10% {
            opacity: 0.8;
        }
        100% {
            transform: translateY(100vh) rotate(720deg);
            opacity: 0;
        }
    }
    
    .corazon-explosion {
        position: fixed;
        pointer-events: none;
        z-index: 1000;
        animation: explotar 1s ease-out forwards;
        user-select: none;
    }
    
    @keyframes explotar {
        0% {
            transform: translate(0, 0) scale(1);
            opacity: 1;
        }
        100% {
            transform: translate(var(--tx), var(--ty)) scale(0);
            opacity: 0;
        }
    }
    
    @keyframes pulsoCorazon {
        0%, 100% {
            transform: scale(1);
        }
        50% {
            transform: scale(1.05);
        }
    }
    
    body.cargado .categoria-card,
    body.cargado .mensaje-card {
        animation-play-state: running;
    }
`;

document.head.appendChild(estilosEfectos);

// ============================================================
// EFECTO DE ESTELA - DESACTIVADO PARA OPTIMIZACIÓN
// ============================================================
// Este efecto está ahora integrado en cursorEffects.js de manera más eficiente

// ============================================================
// LOG ROMÁNTICO EN CONSOLA (easter egg)
// ============================================================
console.log('%c💕 Para Rocío, con todo mi amor 💕', 'color: #e63946; font-size: 20px; font-weight: bold; text-shadow: 2px 2px 4px rgba(0,0,0,0.3);');
console.log('%c🌹 Este sitio fue hecho con mucho cariño por Leo 🌹', 'color: #8e44ad; font-size: 14px; font-style: italic;');
console.log('%c❤️ Nuestro primer mes juntos - 8 de noviembre, 2025 ❤️', 'color: #e63946; font-size: 12px;');
