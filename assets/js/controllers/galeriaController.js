/**
 * 📸 GALERÍA DE FOTOS ROMÁNTICA
 * Lightbox con carrusel y efectos suaves
 */

class GaleriaRomantica {

    constructor() {
        this.currentIndex = 0;

        // Galería base vacía - solo fotos personalizadas
        this.fotosBase = [];

        this.fotos = [];
        // Cargar fotos desde Supabase (si está disponible) y luego inicializar
        this.cargarFotos().then(() => this.init());
    }

    async cargarFotos() {
        // Intentar cargar fotos personalizadas desde Supabase
        try {
            if (window.supabaseClient) {
                const { data, error } = await window.supabaseClient
                    .from('fotos')
                    .select('*')
                    .order('creado_en', { ascending: true });

                if (error) throw error;

                const fotosPersonalizadas = (data || []).map(f => ({
                    src: f.url,
                    titulo: f.titulo,
                    fecha: new Date(f.creado_en).toLocaleDateString('es-ES', { year: 'numeric', month: 'long', day: 'numeric' }),
                    descripcion: f.descripcion || '',
                    tipo: 'personalizada',
                    id: f.id,
                    path: f.path || null
                }));

                this.fotos = [...this.fotosBase, ...fotosPersonalizadas];
                console.log('✅ Fotos cargadas desde Supabase:', this.fotos.length);
                return;
            } else {
                console.error('❌ Supabase no está inicializado');
            }
        } catch (err) {
            console.error('❌ Error cargando fotos desde Supabase:', err);
        }

        // En rama servidor: NO usar localStorage
        this.fotos = [...this.fotosBase];
        console.warn('⚠️ No se pudieron cargar fotos desde Supabase');
    }

    init() {
        this.crearBotonGaleria();
        this.crearModal();
        this.bindEventos();
    }

    crearBotonGaleria() {
        // Verificar si ya existe
        if (document.querySelector('.btn-galeria')) return;

        const boton = document.createElement('button');
        boton.className = 'btn-galeria';
        boton.innerHTML = `
            <span class="icono-galeria">📸</span>
            <span class="texto-galeria">Galería</span>
        `;
        boton.title = 'Ver nuestra galería de fotos';

        document.body.appendChild(boton);

        boton.addEventListener('click', () => {
            this.abrir();
        });

        // Crear botón de administración de fotos
        const botonAdmin = document.createElement('button');
        botonAdmin.className = 'btn-admin-galeria';
        botonAdmin.innerHTML = `
            <span class="icono-admin">➕</span>
        `;
        botonAdmin.title = 'Agregar nueva foto';

        document.body.appendChild(botonAdmin);

        botonAdmin.addEventListener('click', () => {
            // 🔐 Verificar autenticación
            if (!window.authService || !window.authService.isAuthenticated()) {
                alert('⚠️ Debes iniciar sesión para agregar fotos');
                window.location.href = '/OurCorner/views/login.html?return=' + encodeURIComponent(window.location.pathname);
                return;
            }
            this.abrirFormularioFoto();
        });
    }

    crearModal() {
        const modal = document.createElement('div');
        modal.className = 'galeria-modal';
        modal.innerHTML = `
            <div class="galeria-overlay"></div>
            
            <div class="galeria-contenido">
                <button class="galeria-cerrar" title="Cerrar">✖️</button>
                
                <button class="galeria-nav galeria-prev" title="Anterior">
                    <span>❮</span>
                </button>
                
                <div class="galeria-imagen-container">
                    <img src="" alt="" class="galeria-imagen">
                    <div class="galeria-info">
                        <h3 class="galeria-titulo"></h3>
                        <p class="galeria-fecha"></p>
                        <p class="galeria-descripcion"></p>
                        <div class="galeria-contador">
                            <span class="contador-actual">1</span> / <span class="contador-total">4</span>
                        </div>
                        <button class="btn-eliminar-foto" style="display:none;" title="Eliminar esta foto">🗑️ Eliminar</button>
                    </div>
                </div>
                
                <button class="galeria-nav galeria-next" title="Siguiente">
                    <span>❯</span>
                </button>
                
                <div class="galeria-thumbnails">
                    ${this.fotos.map((foto, index) => `
                        <div class="thumbnail ${index === 0 ? 'active' : ''}" data-index="${index}">
                            <img src="${foto.src}" alt="${foto.titulo}" onerror="this.src='assets/images/placeholder.jpg'">
                        </div>
                    `).join('')}
                </div>
            </div>
        `;

        document.body.appendChild(modal);
    }

    bindEventos() {
        // Cerrar
        const btnCerrar = document.querySelector('.galeria-cerrar');
        const overlay = document.querySelector('.galeria-overlay');

        btnCerrar.addEventListener('click', () => this.cerrar());
        overlay.addEventListener('click', () => this.cerrar());

        // Navegación
        const btnPrev = document.querySelector('.galeria-prev');
        const btnNext = document.querySelector('.galeria-next');

        btnPrev.addEventListener('click', () => this.anterior());
        btnNext.addEventListener('click', () => this.siguiente());

        // Thumbnails
        const thumbnails = document.querySelectorAll('.thumbnail');
        thumbnails.forEach((thumb, index) => {
            thumb.addEventListener('click', () => this.irAFoto(index));
        });

        // Teclado
        document.addEventListener('keydown', (e) => {
            const modal = document.querySelector('.galeria-modal');
            if (!modal.classList.contains('active')) return;

            if (e.key === 'ArrowLeft') this.anterior();
            if (e.key === 'ArrowRight') this.siguiente();
            if (e.key === 'Escape') this.cerrar();
        });
    }

    abrir(index = 0) {
        const modal = document.querySelector('.galeria-modal');
        modal.classList.add('active');
        document.body.style.overflow = 'hidden';

        this.mostrarFoto(index);
    }

    cerrar() {
        const modal = document.querySelector('.galeria-modal');
        modal.classList.remove('active');
        document.body.style.overflow = '';
    }

    mostrarFoto(index) {
        this.currentIndex = index;
        const foto = this.fotos[index];

        // Actualizar imagen
        const img = document.querySelector('.galeria-imagen');
        img.style.opacity = '0';

        setTimeout(() => {
            img.src = foto.src;
            img.alt = foto.titulo;
            img.style.opacity = '1';
        }, 200);

        // Actualizar info
        document.querySelector('.galeria-titulo').textContent = foto.titulo;
        document.querySelector('.galeria-fecha').textContent = foto.fecha;
        document.querySelector('.galeria-descripcion').textContent = foto.descripcion;
        document.querySelector('.contador-actual').textContent = index + 1;
        document.querySelector('.contador-total').textContent = this.fotos.length;

        // Mostrar/ocultar botón eliminar (solo para fotos personalizadas)
        const btnEliminar = document.querySelector('.btn-eliminar-foto');
        if (foto.tipo === 'personalizada') {
            btnEliminar.style.display = 'block';
            btnEliminar.onclick = () => this.eliminarFoto(foto.id);
        } else {
            btnEliminar.style.display = 'none';
        }

        // Actualizar thumbnails
        document.querySelectorAll('.thumbnail').forEach((thumb, i) => {
            thumb.classList.toggle('active', i === index);
        });
    }

    siguiente() {
        const nextIndex = (this.currentIndex + 1) % this.fotos.length;
        this.mostrarFoto(nextIndex);
    }

    anterior() {
        const prevIndex = this.currentIndex === 0
            ? this.fotos.length - 1
            : this.currentIndex - 1;
        this.mostrarFoto(prevIndex);
    }

    irAFoto(index) {
        this.mostrarFoto(index);
    }

    abrirFormularioFoto() {
        // Crear modal de formulario
        const modal = document.createElement('div');
        modal.className = 'modal-formulario-foto';
        modal.innerHTML = `
            <div class="modal-overlay"></div>
            <div class="modal-contenido-foto">
                <h2>📸 Agregar Nueva Foto</h2>
                <p class="subtitulo-modal">Sube una foto ❤️</p>
                
                <form id="formNuevaFoto" class="form-nueva-foto">
                    <div class="form-grupo">
                        <label for="inputFoto">Seleccionar imagen:</label>
                        <input type="file" id="inputFoto" accept="image/*" required>
                        <div class="preview-container">
                            <img id="previewFoto" src="" alt="Vista previa" style="display:none">
                        </div>
                    </div>
                    
                    <div class="form-grupo">
                        <label for="tituloFoto">Título:</label>
                        <input type="text" id="tituloFoto" placeholder="Ej: Un día especial" maxlength="50" required>
                    </div>
                    
                    <div class="form-grupo">
                        <label for="fechaFoto">Fecha:</label>
                        <input type="text" id="fechaFoto" placeholder="Ej: Octubre 2025" maxlength="30" required>
                    </div>
                    
                    <div class="form-grupo">
                        <label for="descripcionFoto">Descripción:</label>
                        <textarea id="descripcionFoto" placeholder="Una breve descripción..." maxlength="150" required></textarea>
                    </div>
                    
                    <div class="form-botones">
                        <button type="submit" class="btn-guardar-foto">💾 Guardar Foto</button>
                        <button type="button" class="btn-cancelar-foto">❌ Cancelar</button>
                    </div>
                </form>
            </div>
        `;

        document.body.appendChild(modal);

        // Preview de imagen
        const inputFoto = document.getElementById('inputFoto');
        const previewFoto = document.getElementById('previewFoto');

        inputFoto.addEventListener('change', (e) => {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                reader.onload = (event) => {
                    previewFoto.src = event.target.result;
                    previewFoto.style.display = 'block';
                };
                reader.readAsDataURL(file);
            }
        });

        // Guardar foto
        document.getElementById('formNuevaFoto').addEventListener('submit', async (e) => {
            e.preventDefault();

            const file = inputFoto.files[0];
            if (!file) return;

            const titulo = document.getElementById('tituloFoto').value;
            const fecha = document.getElementById('fechaFoto').value;
            const descripcion = document.getElementById('descripcionFoto').value;

            // Mostrar indicador de carga
            const btnGuardar = modal.querySelector('.btn-guardar-foto');
            const textoOriginal = btnGuardar.innerHTML;
            btnGuardar.innerHTML = '⏳ Subiendo...';
            btnGuardar.disabled = true;

            try {
                console.log('📤 Iniciando subida de foto...');
                console.log('Supabase disponible:', !!window.supabaseClient);

                if (!window.supabaseClient) {
                    throw new Error('Supabase no inicializado - cayendo a localStorage');
                }

                // Generar path seguro
                const timestamp = Date.now();
                const safeName = file.name.replace(/[^a-zA-Z0-9._-]/g, '_');
                const path = `fotos/${timestamp}_${safeName}`;

                console.log('📁 Path generado:', path);

                // Subir archivo
                const { data: uploadData, error: uploadError } = await window.supabaseClient
                    .storage
                    .from('archivos')
                    .upload(path, file, { upsert: true });

                if (uploadError) {
                    console.error('❌ Error en upload:', uploadError);
                    throw uploadError;
                }

                console.log('✅ Archivo subido:', uploadData);

                // Obtener URL pública
                const { data: publicUrlData } = window.supabaseClient
                    .storage
                    .from('archivos')
                    .getPublicUrl(path);

                const publicURL = publicUrlData?.publicUrl || '';
                console.log('🔗 URL pública:', publicURL);

                // Insertar metadatos en la tabla fotos
                const { data: insertData, error: insertError } = await window.supabaseClient
                    .from('fotos')
                    .insert([{ titulo, descripcion, url: publicURL, tipo: 'foto', path }])
                    .select();

                if (insertError) {
                    console.error('❌ Error en insert:', insertError);
                    throw insertError;
                }

                console.log('✅ Metadata insertada:', insertData);

                modal.remove();
                this.mostrarNotificacion('¡Foto agregada exitosamente! 📸💕', 'success');

                // Recargar fotos desde Supabase
                await this.cargarFotos();

                // Actualizar la galería si está abierta
                this.actualizarGaleria();
            } catch (err) {
                console.error('❌ Error completo al subir/guardar foto:', err);
                console.error('Detalles del error:', {
                    message: err.message,
                    name: err.name,
                    stack: err.stack
                });

                // Restaurar botón
                btnGuardar.innerHTML = textoOriginal;
                btnGuardar.disabled = false;

                // En rama servidor: NO usar localStorage, mostrar error
                this.mostrarNotificacion('❌ Error al guardar foto: ' + err.message, 'error');
                this.mostrarNotificacion('Verifica tu conexión a Supabase en la consola (F12)', 'info');

                // NO cerrar modal para que usuario pueda reintentar
            }
        });

        // Cancelar
        modal.querySelector('.btn-cancelar-foto').addEventListener('click', () => {
            modal.remove();
        });

        modal.querySelector('.modal-overlay').addEventListener('click', () => {
            modal.remove();
        });

        // Animación de entrada
        setTimeout(() => modal.classList.add('active'), 10);
    }

    async eliminarFoto(id) {
        // 🔐 Verificar autenticación
        if (!window.authService || !window.authService.isAuthenticated()) {
            alert('⚠️ Debes iniciar sesión para eliminar fotos');
            window.location.href = '/OurCorner/views/login.html?return=' + encodeURIComponent(window.location.pathname);
            return;
        }

        if (!confirm('¿Estás seguro de eliminar esta foto? 🗑️')) return;

        try {
            if (!window.supabaseClient) {
                console.error('❌ Supabase no está inicializado');
                this.mostrarNotificacion('❌ Error: Supabase no inicializado', 'info');
                return;
            }

            // Buscar la foto en la lista actual para obtener path/url
            const foto = this.fotos.find(f => String(f.id) === String(id));

            // Eliminar registro de la tabla
            const { error: delError } = await window.supabaseClient.from('fotos').delete().eq('id', id);
            if (delError) {
                console.error('❌ Error eliminando registro en Supabase:', delError);
                throw delError;
            }

            // Eliminar archivo del storage si tenemos el path
            const path = foto?.path || (foto?.src ? (foto.src.split('/archivos/')[1] || null) : null);
            if (path) {
                const { error: rmError } = await window.supabaseClient.storage.from('archivos').remove([path]);
                if (rmError) console.warn('⚠️ Advertencia eliminando archivo en Storage:', rmError);
            }

            // Recargar fotos
            await this.cargarFotos();

            // Cerrar modal si está abierto
            this.cerrar();

            // Actualizar galería
            this.actualizarGaleria();

            this.mostrarNotificacion('Foto eliminada correctamente 🗑️', 'info');
        } catch (err) {
            console.error('Error al eliminar foto:', err);
            this.mostrarNotificacion('Error al eliminar la foto', 'info');
        }
    }

    actualizarGaleria() {
        // Actualizar thumbnails si la galería está abierta
        const thumbnailsContainer = document.querySelector('.galeria-thumbnails');
        if (thumbnailsContainer) {
            thumbnailsContainer.innerHTML = this.fotos.map((foto, index) => `
                <div class="thumbnail ${index === this.currentIndex ? 'active' : ''}" data-index="${index}">
                    <img src="${foto.src}" alt="${foto.titulo}" onerror="this.src='assets/images/placeholder.jpg'">
                </div>
            `).join('');

            // Re-bind eventos de thumbnails
            document.querySelectorAll('.thumbnail').forEach((thumb, index) => {
                thumb.addEventListener('click', () => this.irAFoto(index));
            });

            // Actualizar contador total
            const contadorTotal = document.querySelector('.contador-total');
            if (contadorTotal) {
                contadorTotal.textContent = this.fotos.length;
            }
        }
    }

    mostrarNotificacion(mensaje, tipo) {
        const notif = document.createElement('div');
        notif.className = `notificacion-foto ${tipo}`;
        notif.textContent = mensaje;

        document.body.appendChild(notif);

        setTimeout(() => notif.classList.add('show'), 10);

        setTimeout(() => {
            notif.classList.remove('show');
            setTimeout(() => notif.remove(), 300);
        }, 3000);
    }
}

// Inicializar cuando el DOM esté listo
document.addEventListener('DOMContentLoaded', () => {
    new GaleriaRomantica();
});
