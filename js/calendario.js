/* ============================================================================
   CALENDARIO DE ADVIENTO NAVIDEÑO - JAVASCRIPT
   ============================================================================ */

// Estado global
let regalosData = [];
let regaloActual = null;

// ============================================================================
// INICIALIZACIÓN
// ============================================================================
document.addEventListener('DOMContentLoaded', async () => {
    console.log('🎄 Calendario de Adviento cargado');

    // Cargar regalos desde Supabase
    await cargarRegalos();

    // Generar grid de regalos
    generarGridRegalos();

    // Actualizar árbol según fecha
    actualizarArbol();

    // Iniciar efectos de nieve
    iniciarNieve();

    // Configurar eventos
    configurarEventos();

    // Verificar desbloqueos automáticos
    verificarDesbloqueos();
});

// ============================================================================
// CARGAR REGALOS DESDE SUPABASE
// ============================================================================
async function cargarRegalos() {
    try {
        const { data, error } = await supabaseClient
            .from('regalos_navidad')
            .select('*')
            .order('dia', { ascending: true });

        if (error) throw error;

        if (data && data.length > 0) {
            regalosData = data;
            console.log(`✅ ${regalosData.length} regalos cargados desde Supabase`);
        } else {
            console.warn('⚠️ No hay regalos en la base de datos');
        }
    } catch (error) {
        console.error('❌ Error al cargar regalos:', error);
        alert('Error al cargar los regalos. Por favor, recarga la página.');
    }
}

// ============================================================================
// GENERAR GRID DE REGALOS
// ============================================================================
function generarGridRegalos() {
    const grid = document.getElementById('regalosGrid');
    if (!grid) return;

    grid.innerHTML = '';

    const hoy = new Date();
    const diaActual = hoy.getDate();
    const mesActual = hoy.getMonth() + 1; // Diciembre = 12

    regalosData.forEach(regalo => {
        const card = document.createElement('div');
        card.className = 'regalo-card';
        card.dataset.dia = regalo.dia;

        // Determinar estado del regalo
        let estado = 'bloqueado';
        let estadoTexto = `Disponible el ${regalo.dia} de dic`;

        if (mesActual === 12 && diaActual >= regalo.dia) {
            if (regalo.desbloqueado) {
                estado = 'abierto';
                estadoTexto = '✓ Abierto';
            } else {
                estado = 'disponible';
                estadoTexto = '¡Disponible!';
            }
        }

        card.classList.add(`regalo-${estado}`);

        // Contenido de la tarjeta
        card.innerHTML = `
            <div class="regalo-numero">Día ${regalo.dia}</div>
            ${estado === 'bloqueado' ? '<div class="regalo-candado">🔒</div>' : ''}
            ${estado === 'abierto' ? '<div class="regalo-check">✓</div>' : ''}
            <div class="regalo-emoji">${regalo.emoji || '🎁'}</div>
            <div class="regalo-titulo">${estado !== 'bloqueado' ? regalo.titulo : '???'}</div>
            <div class="regalo-estado">${estadoTexto}</div>
        `;

        // Evento click
        if (estado !== 'bloqueado') {
            card.style.cursor = 'pointer';
            card.addEventListener('click', () => abrirRegalo(regalo));
        } else {
            card.addEventListener('click', () => {
                alert(`Este regalo se desbloqueará el ${regalo.dia} de diciembre 🎁`);
            });
        }

        grid.appendChild(card);
    });
}

// ============================================================================
// ABRIR REGALO
// ============================================================================
async function abrirRegalo(regalo) {
    regaloActual = regalo;

    // Actualizar modal
    document.getElementById('modalEmoji').textContent = regalo.emoji || '🎁';
    document.getElementById('modalTitulo').textContent = regalo.titulo;
    document.getElementById('modalDia').textContent = `Día ${regalo.dia} de Diciembre`;
    document.getElementById('modalContenido').textContent = regalo.contenido || '';

    // Mostrar foto si existe
    const modalFoto = document.getElementById('modalFoto');
    const modalFotoImg = document.getElementById('modalFotoImg');

    if (regalo.foto_url) {
        modalFotoImg.src = regalo.foto_url;
        modalFoto.style.display = 'block';
    } else {
        modalFoto.style.display = 'none';
    }

    // Mostrar modal
    document.getElementById('modalRegalo').classList.add('activo');

    // Marcar como desbloqueado si no lo estaba
    if (!regalo.desbloqueado) {
        await marcarComoDesbloqueado(regalo.id);
        regalo.desbloqueado = true;
        generarGridRegalos(); // Actualizar grid
    }

    // Confeti al abrir
    lanzarConfeti();
}

// ============================================================================
// MARCAR REGALO COMO DESBLOQUEADO
// ============================================================================
async function marcarComoDesbloqueado(regaloId) {
    try {
        const { error } = await supabaseClient
            .from('regalos_navidad')
            .update({
                desbloqueado: true,
                fecha_desbloqueo: new Date().toISOString()
            })
            .eq('id', regaloId);

        if (error) throw error;
        console.log('✅ Regalo marcado como desbloqueado');
    } catch (error) {
        console.error('❌ Error al marcar regalo:', error);
    }
}

// ============================================================================
// ACTUALIZAR ÁRBOL SEGÚN FECHA
// ============================================================================
function actualizarArbol() {
    const hoy = new Date();
    const diaActual = hoy.getDate();
    const mesActual = hoy.getMonth() + 1;

    const arbolImg = document.getElementById('arbolNavidad');
    const arbolMensaje = document.getElementById('arbolMensaje');

    if (!arbolImg || !arbolMensaje) return;

    if (mesActual !== 12) {
        arbolImg.src = 'img/navidad/arbol-etapa1.png';
        arbolMensaje.textContent = 'El árbol crecerá en diciembre... 🌱';
        return;
    }

    // Etapas del árbol
    if (diaActual >= 1 && diaActual <= 8) {
        arbolImg.src = 'img/navidad/arbol-etapa1.png';
        arbolMensaje.textContent = 'El árbol está creciendo... 🌱';
    } else if (diaActual >= 9 && diaActual <= 16) {
        arbolImg.src = 'img/navidad/arbol-etapa2.png';
        arbolMensaje.textContent = '¡El árbol está creciendo más! 🎄';
    } else if (diaActual >= 17 && diaActual <= 24) {
        arbolImg.src = 'img/navidad/arbol-etapa3.png';
        arbolMensaje.textContent = '¡El árbol está completamente decorado! ✨🎄';
    } else {
        arbolImg.src = 'img/navidad/arbol-etapa3.png';
        arbolMensaje.textContent = '¡Feliz Navidad! 🎅🎄';
    }
}

// ============================================================================
// VERIFICAR DESBLOQUEOS AUTOMÁTICOS
// ============================================================================
async function verificarDesbloqueos() {
    const hoy = new Date();
    const diaActual = hoy.getDate();
    const mesActual = hoy.getMonth() + 1;

    if (mesActual !== 12) return;

    // Desbloquear automáticamente regalos hasta el día actual
    for (const regalo of regalosData) {
        if (regalo.dia <= diaActual && !regalo.desbloqueado) {
            // No marcar como abierto, solo como disponible
            console.log(`Regalo día ${regalo.dia} está disponible`);
        }
    }
}

// ============================================================================
// EFECTOS DE NIEVE
// ============================================================================
function iniciarNieve() {
    const container = document.getElementById('nieve-container');
    if (!container) return;

    const cantidadCopos = 50;

    for (let i = 0; i < cantidadCopos; i++) {
        setTimeout(() => {
            crearCopo(container);
        }, i * 100);
    }

    // Crear nuevos copos continuamente
    setInterval(() => {
        crearCopo(container);
    }, 500);
}

function crearCopo(container) {
    const copo = document.createElement('div');
    copo.className = 'copo-nieve';
    copo.textContent = '❄';
    copo.style.left = Math.random() * 100 + '%';
    copo.style.fontSize = (Math.random() * 1 + 0.5) + 'em';
    copo.style.animationDuration = (Math.random() * 5 + 5) + 's';
    copo.style.opacity = Math.random() * 0.5 + 0.3;

    container.appendChild(copo);

    // Eliminar copo después de la animación
    setTimeout(() => {
        copo.remove();
    }, 10000);
}

// ============================================================================
// CONFETI AL ABRIR REGALO
// ============================================================================
function lanzarConfeti() {
    const colores = ['#ffd700', '#c41e3a', '#4a7c2c', '#ffffff'];
    const cantidad = 50;

    for (let i = 0; i < cantidad; i++) {
        setTimeout(() => {
            const confeti = document.createElement('div');
            confeti.style.position = 'fixed';
            confeti.style.left = Math.random() * 100 + '%';
            confeti.style.top = '-10px';
            confeti.style.width = '10px';
            confeti.style.height = '10px';
            confeti.style.backgroundColor = colores[Math.floor(Math.random() * colores.length)];
            confeti.style.zIndex = '9999';
            confeti.style.pointerEvents = 'none';
            confeti.style.borderRadius = '50%';

            document.body.appendChild(confeti);

            const animacion = confeti.animate([
                { transform: 'translateY(0) rotate(0deg)', opacity: 1 },
                { transform: `translateY(${window.innerHeight}px) rotate(${Math.random() * 720}deg)`, opacity: 0 }
            ], {
                duration: Math.random() * 2000 + 2000,
                easing: 'cubic-bezier(0.25, 0.46, 0.45, 0.94)'
            });

            animacion.onfinish = () => confeti.remove();
        }, i * 30);
    }
}

// ============================================================================
// CONFIGURAR EVENTOS
// ============================================================================
function configurarEventos() {
    // Cerrar modal
    const btnCerrarModal = document.getElementById('btnCerrarModal');
    const modalRegalo = document.getElementById('modalRegalo');

    if (btnCerrarModal) {
        btnCerrarModal.addEventListener('click', () => {
            modalRegalo.classList.remove('activo');
        });
    }

    // Cerrar modal al hacer click fuera
    if (modalRegalo) {
        modalRegalo.addEventListener('click', (e) => {
            if (e.target === modalRegalo) {
                modalRegalo.classList.remove('activo');
            }
        });
    }

    // Música navideña
    const btnMusica = document.getElementById('btnMusicaNavidad');
    const audioNavidad = document.getElementById('audioNavidad');

    if (btnMusica && audioNavidad) {
        btnMusica.addEventListener('click', () => {
            if (audioNavidad.paused) {
                audioNavidad.play();
                btnMusica.classList.add('reproduciendo');
                btnMusica.textContent = '🎶';
            } else {
                audioNavidad.pause();
                btnMusica.classList.remove('reproduciendo');
                btnMusica.textContent = '🎵';
            }
        });
    }

    // Panel de administración (tecla secreta: Ctrl + Shift + A)
    document.addEventListener('keydown', (e) => {
        if (e.ctrlKey && e.shiftKey && e.key === 'A') {
            abrirPanelAdmin();
        }
    });

    // Cerrar panel admin
    const btnCerrarAdmin = document.getElementById('btnCerrarAdmin');
    if (btnCerrarAdmin) {
        btnCerrarAdmin.addEventListener('click', cerrarPanelAdmin);
    }

    // Guardar cambios en admin
    const btnGuardarAdmin = document.getElementById('btnGuardarAdmin');
    if (btnGuardarAdmin) {
        btnGuardarAdmin.addEventListener('click', guardarCambiosAdmin);
    }

    // Cambio de tipo en admin
    const adminTipo = document.getElementById('adminTipo');
    if (adminTipo) {
        adminTipo.addEventListener('change', (e) => {
            const fotoSection = document.getElementById('adminFotoSection');
            if (e.target.value === 'foto' || e.target.value === 'mixto') {
                fotoSection.style.display = 'block';
            } else {
                fotoSection.style.display = 'none';
            }
        });
    }

    // Preview de foto en admin
    const adminFoto = document.getElementById('adminFoto');
    if (adminFoto) {
        adminFoto.addEventListener('change', previsualizarFotoAdmin);
    }
}

// ============================================================================
// PANEL DE ADMINISTRACIÓN
// ============================================================================
function abrirPanelAdmin() {
    const panel = document.getElementById('panelAdmin');
    if (!panel) return;

    // Cargar primer regalo
    if (regalosData.length > 0) {
        cargarRegaloEnAdmin(regalosData[0]);
    }

    panel.style.display = 'flex';
}

function cerrarPanelAdmin() {
    const panel = document.getElementById('panelAdmin');
    if (panel) {
        panel.style.display = 'none';
    }
}

function cargarRegaloEnAdmin(regalo) {
    document.getElementById('adminDia').textContent = regalo.dia;
    document.getElementById('adminTitulo').value = regalo.titulo;
    document.getElementById('adminTipo').value = regalo.tipo;
    document.getElementById('adminContenido').value = regalo.contenido || '';
    document.getElementById('adminEmoji').value = regalo.emoji || '🎁';

    const fotoSection = document.getElementById('adminFotoSection');
    if (regalo.tipo === 'foto' || regalo.tipo === 'mixto') {
        fotoSection.style.display = 'block';
        if (regalo.foto_url) {
            document.getElementById('adminFotoPreview').innerHTML = `<img src="${regalo.foto_url}" alt="Preview">`;
        }
    } else {
        fotoSection.style.display = 'none';
    }

    regaloActual = regalo;
}

async function guardarCambiosAdmin() {
    if (!regaloActual) return;

    const titulo = document.getElementById('adminTitulo').value;
    const tipo = document.getElementById('adminTipo').value;
    const contenido = document.getElementById('adminContenido').value;
    const emoji = document.getElementById('adminEmoji').value;
    const fotoInput = document.getElementById('adminFoto');

    try {
        let foto_url = regaloActual.foto_url;
        let foto_path = regaloActual.foto_path;

        // Si hay nueva foto, subirla
        if (fotoInput.files && fotoInput.files[0]) {
            const archivo = fotoInput.files[0];
            const nombreArchivo = `navidad/dia${regaloActual.dia}_${Date.now()}.${archivo.name.split('.').pop()}`;

            const { data: uploadData, error: uploadError } = await supabaseClient.storage
                .from('archivos')
                .upload(nombreArchivo, archivo);

            if (uploadError) throw uploadError;

            const { data: urlData } = supabaseClient.storage
                .from('archivos')
                .getPublicUrl(nombreArchivo);

            foto_url = urlData.publicUrl;
            foto_path = nombreArchivo;
        }

        // Actualizar en Supabase
        const { error } = await supabaseClient
            .from('regalos_navidad')
            .update({
                titulo,
                tipo,
                contenido,
                emoji,
                foto_url,
                foto_path,
                actualizado_en: new Date().toISOString()
            })
            .eq('id', regaloActual.id);

        if (error) throw error;

        alert('✅ Regalo actualizado correctamente');

        // Recargar datos
        await cargarRegalos();
        generarGridRegalos();
        cerrarPanelAdmin();

    } catch (error) {
        console.error('❌ Error al guardar:', error);
        alert('Error al guardar los cambios: ' + error.message);
    }
}

function previsualizarFotoAdmin(e) {
    const archivo = e.target.files[0];
    if (!archivo) return;

    const reader = new FileReader();
    reader.onload = (event) => {
        document.getElementById('adminFotoPreview').innerHTML = `<img src="${event.target.result}" alt="Preview">`;
    };
    reader.readAsDataURL(archivo);
}

// ============================================================================
// NAVEGACIÓN ENTRE REGALOS EN ADMIN
// ============================================================================
function siguienteRegaloAdmin() {
    if (!regaloActual) return;
    const indiceActual = regalosData.findIndex(r => r.id === regaloActual.id);
    if (indiceActual < regalosData.length - 1) {
        cargarRegaloEnAdmin(regalosData[indiceActual + 1]);
    }
}

function anteriorRegaloAdmin() {
    if (!regaloActual) return;
    const indiceActual = regalosData.findIndex(r => r.id === regaloActual.id);
    if (indiceActual > 0) {
        cargarRegaloEnAdmin(regalosData[indiceActual - 1]);
    }
}

console.log('🎄 Calendario.js cargado correctamente');
