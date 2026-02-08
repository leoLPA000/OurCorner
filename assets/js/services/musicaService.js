/**
 * 🎵 REPRODUCTOR DE MÚSICA ROMÁNTICA
 * Sistema de audio con controles personalizados
 */

class ReproductorRomantico {
    constructor() {
        this.audio = null;
        this.playing = false;
        this.currentTrack = 0;
        this.volume = 0.3; // Volumen inicial 30%
        this.minimizado = false;

        // Lista mínima de canciones base internas (1 archivo local) — evita problemas de CORS
        // Coloca un MP3 en el path: audio/romantica-interna.mp3 (o cambia el src al nombre que prefieras)

        // Detectar si estamos en una subcarpeta (views/) o en la raíz
        const basePath = window.location.pathname.includes('/views/') ? '../assets/audio/' : 'assets/audio/';

        this.playlistBase = [
            {
                titulo: 'Melodía ',
                artista: 'Instrumental',
                // Archivo local dentro del proyecto para evitar CORS cuando pruebas en local
                src: basePath + 'Happy-Together.mp3',
                tipo: 'predeterminada',
                id: 'base-local-1'
            }
        ];

        this.playlist = [];

        // Restaurar estado previo si existe
        this.restaurarEstado();

        // Cargar playlist desde Supabase (si está disponible) y luego inicializar
        this.cargarPlaylist().then(() => this.init());
    }

    restaurarEstado() {
        try {
            const estado = JSON.parse(sessionStorage.getItem('reproductorEstado') || '{}');
            if (estado.currentTrack !== undefined) this.currentTrack = estado.currentTrack;
            if (estado.volume !== undefined) this.volume = estado.volume;
            if (estado.minimizado !== undefined) this.minimizado = estado.minimizado;
            if (estado.playing !== undefined) this.playing = estado.playing;
        } catch (err) {
            console.warn('No se pudo restaurar estado del reproductor:', err);
        }
    }

    guardarEstado() {
        try {
            const estado = {
                currentTrack: this.currentTrack,
                volume: this.volume,
                minimizado: this.minimizado,
                playing: this.playing,
                currentTime: this.audio ? this.audio.currentTime : 0
            };
            sessionStorage.setItem('reproductorEstado', JSON.stringify(estado));
        } catch (err) {
            console.warn('No se pudo guardar estado del reproductor:', err);
        }
    }

    async cargarPlaylist() {
        // Intentar cargar canciones personalizadas desde Supabase
        try {
            if (window.supabaseClient) {
                const { data, error } = await window.supabaseClient
                    .from('canciones')
                    .select('*')
                    .order('creado_en', { ascending: true });

                if (error) throw error;

                const cancionesPersonalizadas = (data || []).map(c => ({
                    titulo: c.titulo,
                    artista: c.artista,
                    src: c.url,
                    tipo: 'personalizada',
                    id: c.id,
                    path: c.path || null
                }));

                this.playlist = [...this.playlistBase, ...cancionesPersonalizadas];
                console.log('✅ Playlist cargada desde Supabase:', this.playlist.length, 'canciones');
                return;
            } else {
                console.error('❌ Supabase no está inicializado');
            }
        } catch (err) {
            console.error('❌ Error cargando canciones desde Supabase:', err);
        }

        // En rama servidor: solo canciones base, NO localStorage
        this.playlist = [...this.playlistBase];
        console.warn('⚠️ Usando solo canciones predeterminadas (5)');
    }

    init() {
        // Crear elemento de audio con preload optimizado
        this.audio = new Audio();
        this.audio.volume = this.volume;
        this.audio.loop = false;
        this.audio.preload = 'auto'; // Precargar el audio completo
        this.audio.crossOrigin = 'anonymous'; // Para Supabase

        // Restaurar tiempo de reproducción si existe
        const estadoPrevio = JSON.parse(sessionStorage.getItem('reproductorEstado') || '{}');

        // Evento cuando termina una canción
        this.audio.addEventListener('ended', () => {
            this.siguiente();
        });

        // Guardar estado periódicamente mientras se reproduce (optimizado)
        let ultimoGuardado = 0;
        this.audio.addEventListener('timeupdate', () => {
            if (this.playing) {
                const ahora = Date.now();
                // Guardar solo cada 2 segundos (en vez de cada frame)
                if (ahora - ultimoGuardado > 2000) {
                    this.guardarEstado();
                    ultimoGuardado = ahora;
                }
            }
        });

        // Evento cuando el audio está listo para reproducir
        this.audio.addEventListener('canplay', () => {
            // Si estaba reproduciéndose, reanudar inmediatamente
            if (estadoPrevio.playing && !this.playing) {
                this.play();
            }
        });

        // Cargar canción actual
        this.cargarCancion(this.currentTrack);

        // Restaurar tiempo de reproducción (más rápido)
        if (estadoPrevio.currentTime && estadoPrevio.playing) {
            this.audio.addEventListener('loadedmetadata', () => {
                this.audio.currentTime = estadoPrevio.currentTime;
            }, { once: true });
        }

        // Crear controles
        this.crearControles();

        // Bind eventos
        this.bindEventos();

        // Guardar estado antes de salir de la página (por si hay navegación entre vistas)
        window.addEventListener('beforeunload', () => {
            try { this.guardarEstado(); } catch (e) { /* ignore */ }
        });

        // En producción: guardar estado también cuando la página se oculta (más confiable)
        window.addEventListener('pagehide', () => {
            try { this.guardarEstado(); } catch (e) { /* ignore */ }
        });

        // Reintentar reproducción cuando la página vuelve a estar visible (útil en HTTPS)
        document.addEventListener('visibilitychange', () => {
            if (document.visibilityState === 'visible') {
                const estado = JSON.parse(sessionStorage.getItem('reproductorEstado') || '{}');
                if (estado.playing && !this.playing && this.audio && !this.audio.ended) {
                    // Intentar reanudar
                    const p = this.audio.play();
                    if (p && typeof p.then === 'function') {
                        p.then(() => {
                            this.playing = true;
                            this.actualizarUI(true);
                            this.hideResumeButton();
                        }).catch(() => {
                            // Si falla, mostrar botón
                            this.showResumeButton();
                        });
                    }
                }
            }
        });

        // Si en la sesión previa estaba reproduciéndose, intentar reanudar cuando la página sea visible
        if (estadoPrevio.playing) {
            // Intentar reproducir automáticamente (navegadores modernos pueden bloquear)
            const tryAutoPlay = () => {
                const p = this.audio.play();
                if (p && typeof p.then === 'function') {
                    p.then(() => {
                        this.playing = true;
                        this.guardarEstado();
                        this.actualizarUI(true);
                        this.hideResumeButton();
                    }).catch(() => {
                        // Autoplay bloqueado: mostrar botón de reanudar
                        this.showResumeButton();
                    });
                }
            };

            // Intentar inmediatamente
            setTimeout(tryAutoPlay, 100);

            // Reintentar cuando la página vuelva a ser visible
            window.addEventListener('visibilitychange', () => {
                if (document.visibilityState === 'visible' && !this.playing && estadoPrevio.playing) {
                    tryAutoPlay();
                }
            });
        }

        // OPTIMIZACIÓN PARA PRODUCCIÓN: Interceptar navegación en enlaces internos
        this.interceptarNavegacion();
    }

    // Interceptar clicks en enlaces para mantener audio activo
    interceptarNavegacion() {
        // Detectar si estamos en producción (HTTPS o dominio remoto)
        const esProduccion = window.location.protocol === 'https:' ||
            window.location.hostname !== 'localhost' &&
            window.location.hostname !== '127.0.0.1';

        if (!esProduccion) return; // En local no es necesario

        // Interceptar todos los enlaces internos
        document.addEventListener('click', (e) => {
            const link = e.target.closest('a');
            if (!link) return;

            const href = link.getAttribute('href');
            if (!href || href.startsWith('#') || href.startsWith('http://') || href.startsWith('https://')) return;

            // Es un enlace interno relativo
            if (this.playing) {
                e.preventDefault();

                // Guardar estado antes de navegar
                this.guardarEstado();

                // Pequeño delay para que el audio tenga chance de seguir
                setTimeout(() => {
                    window.location.href = href;
                }, 50);
            }
        }, true);

        // También interceptar el botón "Volver" si existe
        const btnVolver = document.querySelector('.btn-volver');
        if (btnVolver) {
            btnVolver.addEventListener('click', (e) => {
                if (this.playing) {
                    e.preventDefault();
                    this.guardarEstado();
                    setTimeout(() => {
                        window.location.href = btnVolver.getAttribute('href') || 'index.html';
                    }, 50);
                }
            });
        }
    }

    crearControles() {
        console.log('🎵 Creando controles del reproductor...');

        const controles = document.createElement('div');
        controles.className = 'reproductor-container cargando';
        controles.innerHTML = `
            <div class="reproductor-info">
                <span class="icono-musica">🎵</span>
                <div class="info-cancion">
                    <div class="cancion-titulo">Música</div>
                    <div class="cancion-artista">💕</div>
                </div>
            </div>
            
            <div class="reproductor-controles">
                <button class="btn-control btn-anterior" title="Anterior">
                    <span>⏮️</span>
                </button>
                
                <button class="btn-control btn-play" title="Reproducir/Pausar">
                    <span class="icono-play">▶️</span>
                    <span class="icono-pause" style="display:none">⏸️</span>
                </button>
                
                <button class="btn-control btn-siguiente" title="Siguiente">
                    <span>⏭️</span>
                </button>
                
                <button class="btn-control btn-agregar-musica" title="Agregar canción">
                    <span>➕</span>
                </button>
                
                <button class="btn-control btn-ver-playlist" title="Ver playlist">
                    <span>📋</span>
                </button>
                
                <div class="volumen-container">
                    <button class="btn-control btn-volumen" title="Volumen">
                        <span class="icono-volumen-alto">🔊</span>
                        <span class="icono-volumen-bajo" style="display:none">🔉</span>
                        <span class="icono-volumen-mute" style="display:none">🔇</span>
                    </button>
                    <input type="range" class="volumen-slider" min="0" max="100" value="30">
                </div>
            </div>
            
            <button class="btn-minimizar-reproductor" title="Minimizar">➖</button>
        `;

        document.body.appendChild(controles);
        console.log('✅ Controles agregados al DOM');
        // Habilitar interacción inmediatamente para evitar que overlays o problemas de CORS de audio bloqueen los clicks
        // (la clase 'cargando' se usa solo para apariencia; permitimos interacciones de todas formas)
        controles.classList.remove('cargando');
        controles.classList.add('listo');

        // Marcar como listo cuando el audio esté preparado
        this.audio.addEventListener('canplaythrough', () => {
            controles.classList.remove('cargando');
            controles.classList.add('listo');
        }, { once: true });

        // Crear botón flotante minimizadoo
        const botonFlotante = document.createElement('button');
        botonFlotante.className = 'reproductor-minimizado';
        botonFlotante.title = 'Abrir reproductor';
        botonFlotante.innerHTML = '🎵';
        botonFlotante.style.display = 'none';
        document.body.appendChild(botonFlotante);

        console.log('✅ Reproductor creado completamente');
    }

    bindEventos() {
        // Play/Pause
        const btnPlay = document.querySelector('.btn-play');
        if (btnPlay) {
            btnPlay.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                this.togglePlay();
            });
        } else {
            console.error('❌ No se encontró .btn-play');
        }

        // Anterior
        const btnAnterior = document.querySelector('.btn-anterior');
        if (btnAnterior) {
            btnAnterior.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                this.anterior();
            });
        } else {
            console.error('❌ No se encontró .btn-anterior');
        }

        // Siguiente
        const btnSiguiente = document.querySelector('.btn-siguiente');
        if (btnSiguiente) {
            btnSiguiente.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                this.siguiente();
            });
        } else {
            console.error('❌ No se encontró .btn-siguiente');
        }

        // Volumen slider
        const volumenSlider = document.querySelector('.volumen-slider');
        if (volumenSlider) {
            volumenSlider.addEventListener('input', (e) => {
                this.cambiarVolumen(e.target.value / 100);
            });
        }

        // Botón volumen (mute/unmute)
        const btnVolumen = document.querySelector('.btn-volumen');
        if (btnVolumen) {
            btnVolumen.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                this.toggleMute();
            });
        }

        // Minimizar reproductor
        const btnMinimizar = document.querySelector('.btn-minimizar-reproductor');
        if (btnMinimizar) {
            btnMinimizar.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                console.log('🔽 Minimizando reproductor...');
                this.minimizar();
            });
        } else {
            console.error('❌ No se encontró .btn-minimizar-reproductor');
        }

        // Abrir desde minimizado
        const btnFlotante = document.querySelector('.reproductor-minimizado');
        if (btnFlotante) {
            btnFlotante.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                this.maximizar();
            });
        }

        // Agregar música
        const btnAgregar = document.querySelector('.btn-agregar-musica');
        if (btnAgregar) {
            btnAgregar.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                
                // 🔐 Verificar autenticación
                if (!window.authService || !window.authService.isAuthenticated()) {
                    alert('⚠️ Debes iniciar sesión para agregar canciones');
                    window.location.href = '/OurCorner/views/login.html?return=' + encodeURIComponent(window.location.pathname);
                    return;
                }
                
                console.log('➕ Abriendo formulario de canción...');
                this.abrirFormularioCancion();
            });
        } else {
            console.error('❌ No se encontró .btn-agregar-musica');
        }

        // Ver playlist
        const btnPlaylist = document.querySelector('.btn-ver-playlist');
        if (btnPlaylist) {
            btnPlaylist.addEventListener('click', (e) => {
                e.preventDefault();
                e.stopPropagation();
                console.log('📋 Mostrando playlist...');
                this.mostrarPlaylist();
            });
        } else {
            console.error('❌ No se encontró .btn-ver-playlist');
        }

        console.log('✅ Eventos del reproductor vinculados correctamente');
    }

    // Mostrar un botón flotante para reanudar la reproducción cuando el navegador bloquea el autoplay
    showResumeButton() {
        if (document.querySelector('.btn-reanudar-musica')) return; // ya existe

        const btn = document.createElement('button');
        btn.className = 'btn-reanudar-musica';
        btn.title = 'Reanudar música';
        btn.innerHTML = '🎵 Reanudar música';
        btn.addEventListener('click', (e) => {
            e.preventDefault();
            e.stopPropagation();
            this.hideResumeButton();
            // Intentar reproducir con interacción explícita
            this.play();
        });

        document.body.appendChild(btn);
        // pequeña animación para llamar la atención
        setTimeout(() => btn.classList.add('visible'), 20);

        // En producción, el botón es más prominente y no desaparece automáticamente
        const esProduccion = window.location.protocol === 'https:' ||
            (window.location.hostname !== 'localhost' &&
                window.location.hostname !== '127.0.0.1');

        if (esProduccion) {
            btn.style.fontSize = '1.1rem';
            btn.style.padding = '15px 25px';
            btn.style.animation = 'pulse 2s infinite';
        }
    }
    hideResumeButton() {
        const btn = document.querySelector('.btn-reanudar-musica');
        if (!btn) return;
        btn.classList.remove('visible');
        setTimeout(() => btn.remove(), 250);
    }

    cargarCancion(index) {
        if (index >= 0 && index < this.playlist.length) {
            this.currentTrack = index;
            const cancion = this.playlist[index];
            this.audio.src = cancion.src;
            this.guardarEstado();

            // Actualizar info visual
            const titulo = document.querySelector('.cancion-titulo');
            const artista = document.querySelector('.cancion-artista');

            if (titulo) titulo.textContent = cancion.titulo;
            if (artista) artista.textContent = cancion.artista;
        }
    }

    togglePlay() {
        if (this.playing) {
            this.pause();
        } else {
            this.play();
        }
    }

    play() {
        // Verificar si hay canciones disponibles
        if (this.playlist.length === 0) {
            this.mostrarNotificacion('📭 No hay canciones en la playlist. ¡Agrega tu primera canción! 🎵', 'info');
            setTimeout(() => this.abrirFormularioCancion(), 500);
            return;
        }

        // Verificar si la canción actual tiene src válido
        const cancionActual = this.playlist[this.currentTrack];
        if (!cancionActual || !cancionActual.src) {
            this.mostrarNotificacion('❌ La canción actual no tiene una fuente válida', 'info');
            return;
        }

        // Intentar reproducir inmediatamente con manejo de promesas
        const playPromise = this.audio.play();

        if (playPromise !== undefined) {
            playPromise
                .then(() => {
                    // Reproducción exitosa
                    this.playing = true;
                    this.guardarEstado();
                    this.actualizarUI(true);
                    this.hideResumeButton();
                })
                .catch(err => {
                    // Autoplay bloqueado: mostrar botón de reanudar
                    console.log('Autoplay bloqueado, mostrando botón:', err);
                    this.showResumeButton();
                });
        }
    }

    actualizarUI(reproduciendo) {
        // Actualizar iconos
        const iconoPlay = document.querySelector('.icono-play');
        const iconoPause = document.querySelector('.icono-pause');
        const iconoMusica = document.querySelector('.icono-musica');

        if (iconoPlay) iconoPlay.style.display = reproduciendo ? 'none' : 'inline';
        if (iconoPause) iconoPause.style.display = reproduciendo ? 'inline' : 'none';
        if (iconoMusica) {
            if (reproduciendo) {
                iconoMusica.classList.add('pulsando');
            } else {
                iconoMusica.classList.remove('pulsando');
            }
        }
    }

    pause() {
        this.audio.pause();
        this.playing = false;
        this.guardarEstado();
        this.actualizarUI(false);
    }

    siguiente() {
        if (this.playlist.length === 0) {
            this.mostrarNotificacion('📭 No hay canciones en la playlist', 'info');
            return;
        }

        const nextIndex = (this.currentTrack + 1) % this.playlist.length;
        this.cargarCancion(nextIndex);
        if (this.playing) {
            this.play();
        }
    }

    anterior() {
        if (this.playlist.length === 0) {
            this.mostrarNotificacion('📭 No hay canciones en la playlist', 'info');
            return;
        }

        const prevIndex = this.currentTrack === 0
            ? this.playlist.length - 1
            : this.currentTrack - 1;
        this.cargarCancion(prevIndex);
        if (this.playing) {
            this.play();
        }
    }

    cambiarVolumen(nivel) {
        this.volume = nivel;
        this.audio.volume = nivel;

        // Actualizar iconos de volumen
        const alto = document.querySelector('.icono-volumen-alto');
        const bajo = document.querySelector('.icono-volumen-bajo');
        const mute = document.querySelector('.icono-volumen-mute');

        alto.style.display = 'none';
        bajo.style.display = 'none';
        mute.style.display = 'none';

        if (nivel === 0) {
            mute.style.display = 'inline';
        } else if (nivel < 0.5) {
            bajo.style.display = 'inline';
        } else {
            alto.style.display = 'inline';
        }
    }

    toggleMute() {
        if (this.audio.volume > 0) {
            this.audio.volume = 0;
            document.querySelector('.volumen-slider').value = 0;
            this.cambiarVolumen(0);
        } else {
            this.audio.volume = this.volume;
            document.querySelector('.volumen-slider').value = this.volume * 100;
            this.cambiarVolumen(this.volume);
        }
    }

    minimizar() {
        this.minimizado = true;
        const reproductor = document.querySelector('.reproductor-container');
        const botonFlotante = document.querySelector('.reproductor-minimizado');

        reproductor.style.animation = 'slideOutRight 0.3s ease';
        setTimeout(() => {
            reproductor.style.display = 'none';
            botonFlotante.style.display = 'flex';
            botonFlotante.style.animation = 'bounceIn 0.5s ease';
        }, 300);
    }

    maximizar() {
        this.minimizado = false;
        const reproductor = document.querySelector('.reproductor-container');
        const botonFlotante = document.querySelector('.reproductor-minimizado');

        botonFlotante.style.animation = 'fadeOut 0.2s ease';
        setTimeout(() => {
            botonFlotante.style.display = 'none';
            reproductor.style.display = 'flex';
            reproductor.style.animation = 'slideInRight 0.5s ease';
        }, 200);
    }

    mostrar() {
        const reproductor = document.querySelector('.reproductor-container');
        reproductor.style.display = 'flex';
        reproductor.style.animation = 'fadeIn 0.3s ease';
    }

    abrirFormularioCancion() {
        // Pausar música si está sonando
        if (this.playing) this.pause();

        // Crear modal de formulario
        const modal = document.createElement('div');
        modal.className = 'modal-formulario-musica';
        modal.innerHTML = `
            <div class="modal-overlay-musica"></div>
            <div class="modal-contenido-musica">
                <h2>🎵 Agregar Nueva Canción</h2>
                <p class="subtitulo-modal">Sube una canción ❤️</p>
                
                <form id="formNuevaCancion" class="form-nueva-cancion">
                    <div class="form-grupo">
                        <label for="inputAudio">Seleccionar archivo de audio:</label>
                        <input type="file" id="inputAudio" accept="audio/*" required>
                        <p class="hint-texto">Cualquier formato de audio (MP3, M4A, WAV, OGG, FLAC, AAC, etc.) - Máx. 50MB</p>
                    </div>
                    
                    <div class="form-grupo">
                        <label for="tituloCancion">Título de la canción:</label>
                        <input type="text" id="tituloCancion" placeholder="Ej: Nuestra Canción" maxlength="50" required>
                    </div>
                    
                    <div class="form-grupo">
                        <label for="artistaCancion">Artista:</label>
                        <input type="text" id="artistaCancion" placeholder="Ej: Artista Favorito" maxlength="50" required>
                    </div>
                    
                    <div class="info-archivo">
                        <p>📁 <span id="nombreArchivo">Ningún archivo seleccionado</span></p>
                        <p>📦 <span id="tamanoArchivo">-- MB</span></p>
                        <p>⏱️ <span id="duracionArchivo">--:--</span></p>
                    </div>
                    
                    <div class="form-botones">
                        <button type="submit" class="btn-guardar-cancion">💾 Guardar Canción</button>
                        <button type="button" class="btn-cancelar-cancion">❌ Cancelar</button>
                    </div>
                </form>
            </div>
        `;

        document.body.appendChild(modal);

        // Info de archivo de audio
        const inputAudio = document.getElementById('inputAudio');
        const nombreArchivo = document.getElementById('nombreArchivo');
        const tamanoArchivo = document.getElementById('tamanoArchivo');
        const duracionArchivo = document.getElementById('duracionArchivo');

        inputAudio.addEventListener('change', (e) => {
            const file = e.target.files[0];
            if (file) {
                // Mostrar nombre
                nombreArchivo.textContent = file.name;
                
                // Mostrar tamaño
                const sizeMB = (file.size / 1024 / 1024).toFixed(2);
                tamanoArchivo.textContent = `${sizeMB} MB`;
                tamanoArchivo.style.color = file.size > 50 * 1024 * 1024 ? '#ff4444' : '#4caf50';

                // Obtener duración del audio
                const audioTemp = new Audio();
                audioTemp.src = URL.createObjectURL(file);
                audioTemp.addEventListener('loadedmetadata', () => {
                    const minutos = Math.floor(audioTemp.duration / 60);
                    const segundos = Math.floor(audioTemp.duration % 60);
                    duracionArchivo.textContent = `${minutos}:${segundos.toString().padStart(2, '0')}`;
                    URL.revokeObjectURL(audioTemp.src); // Liberar memoria
                });
            }
        });

        // Guardar canción: subir a Supabase Storage y guardar metadatos en tabla
        document.getElementById('formNuevaCancion').addEventListener('submit', async (e) => {
            e.preventDefault();
            const file = inputAudio.files[0];
            if (!file) return;

            const titulo = document.getElementById('tituloCancion').value;
            const artista = document.getElementById('artistaCancion').value;

            // ✅ Validar que sea un archivo de audio (cualquier formato)
            const esAudio = file.type.startsWith('audio/') || file.name.match(/\.(mp3|wav|ogg|m4a|aac|flac|wma|opus|webm|aiff)$/i);
            
            if (!esAudio) {
                alert('❌ El archivo no parece ser de audio. Por favor selecciona un archivo de audio válido.');
                return;
            }

            // ✅ Validar tamaño (máximo 50MB)
            const maxSize = 50 * 1024 * 1024; // 50MB en bytes
            if (file.size > maxSize) {
                alert(`❌ El archivo es muy grande (${(file.size / 1024 / 1024).toFixed(2)}MB). Máximo: 50MB`);
                return;
            }

            // Mostrar indicador de carga
            const btnGuardar = modal.querySelector('.btn-guardar-cancion');
            const textoOriginal = btnGuardar.innerHTML;
            btnGuardar.innerHTML = '⏳ Subiendo...';
            btnGuardar.disabled = true;

            try {
                if (!window.supabaseClient) throw new Error('Supabase no inicializado');

                console.log('📤 Iniciando subida de archivo:', file.name, 'Tipo:', file.type, 'Tamaño:', (file.size / 1024 / 1024).toFixed(2) + 'MB');

                // Generar path seguro
                const timestamp = Date.now();
                const safeName = file.name.replace(/[^a-zA-Z0-9._-]/g, '_');
                const path = `musica/${timestamp}_${safeName}`;

                console.log('📁 Path generado:', path);
                
                // ✅ Determinar contentType automáticamente
                let contentType = file.type;
                if (!contentType || contentType === '') {
                    // Mapeo de extensiones a tipos MIME comunes
                    const extension = file.name.toLowerCase().split('.').pop();
                    const mimeTypes = {
                        'm4a': 'audio/mp4',
                        'mp3': 'audio/mpeg',
                        'wav': 'audio/wav',
                        'ogg': 'audio/ogg',
                        'flac': 'audio/flac',
                        'aac': 'audio/aac',
                        'opus': 'audio/opus',
                        'webm': 'audio/webm',
                        'wma': 'audio/x-ms-wma',
                        'aiff': 'audio/aiff'
                    };
                    contentType = mimeTypes[extension] || 'audio/mpeg'; // default a audio/mpeg
                }
                console.log('📝 Content-Type:', contentType);

                // Subir archivo con contentType específico
                const { data: uploadData, error: uploadError } = await window.supabaseClient
                    .storage
                    .from('archivos')
                    .upload(path, file, { 
                        contentType: contentType,
                        upsert: true 
                    });

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

                // Insertar metadatos en la tabla canciones
                const { data: insertData, error: insertError } = await window.supabaseClient
                    .from('canciones')
                    .insert([{ titulo, artista, url: publicURL, tipo: 'personalizada', path }])
                    .select();

                if (insertError) {
                    console.error('❌ Error en insert:', insertError);
                    throw insertError;
                }

                console.log('✅ Metadata insertada:', insertData);

                modal.remove();
                this.mostrarNotificacion('¡Canción agregada exitosamente! 🎵💕', 'success');

                // Recargar playlist desde Supabase
                await this.cargarPlaylist();
            } catch (err) {
                console.error('❌ Error completo al subir/guardar canción:', err);
                console.error('Detalles del error:', {
                    message: err.message,
                    name: err.name,
                    stack: err.stack,
                    hint: err.hint,
                    details: err.details
                });

                // Restaurar botón
                btnGuardar.innerHTML = textoOriginal;
                btnGuardar.disabled = false;

                // Mensajes de error más específicos
                let mensajeError = '❌ Error al guardar canción';
                if (err.message.includes('authenticated') || err.message.includes('JWT')) {
                    mensajeError = '🔐 Debes iniciar sesión para subir canciones. Redirigiendo...';
                    setTimeout(() => {
                        window.location.href = '/OurCorner/views/login.html?return=' + encodeURIComponent(window.location.pathname);
                    }, 2000);
                } else if (err.message.includes('size') || err.message.includes('too large')) {
                    mensajeError = '❌ El archivo es muy grande. Máximo 50MB';
                } else if (err.message.includes('mime') || err.message.includes('type')) {
                    mensajeError = '❌ Formato de archivo no permitido';
                } else {
                    mensajeError = '❌ Error: ' + err.message;
                }
                
                this.mostrarNotificacion(mensajeError, 'error');
                alert(mensajeError);

                // NO cerrar modal para que usuario pueda reintentar
            }
        });

        // Cancelar
        modal.querySelector('.btn-cancelar-cancion').addEventListener('click', () => {
            modal.remove();
        });

        modal.querySelector('.modal-overlay-musica').addEventListener('click', () => {
            modal.remove();
        });

        // Animación de entrada
        setTimeout(() => modal.classList.add('active'), 10);
    }

    guardarCancion(cancion) {
        // En rama servidor: SOLO Supabase, NO localStorage
        (async () => {
            try {
                if (!window.supabaseClient) {
                    console.error('❌ Supabase no está inicializado');
                    this.mostrarNotificacion('❌ Error: Supabase no inicializado. Verifica la configuración.', 'error');
                    return;
                }

                if (!cancion.path || !cancion.titulo) {
                    console.error('❌ Datos de canción incompletos:', cancion);
                    this.mostrarNotificacion('❌ Error: Datos de canción incompletos', 'error');
                    return;
                }

                await window.supabaseClient.from('canciones').insert([{
                    titulo: cancion.titulo,
                    artista: cancion.artista,
                    url: cancion.src,
                    tipo: 'personalizada',
                    path: cancion.path
                }]);

                console.log('✅ Canción guardada en Supabase:', cancion.titulo);
                await this.cargarPlaylist();
            } catch (err) {
                console.error('❌ Error al guardar canción en Supabase:', err);
                this.mostrarNotificacion(`❌ Error al guardar canción: ${err.message}`, 'error');
            }
        })();
    }

    async eliminarCancion(id) {
        // 🔐 Verificar autenticación
        if (!window.authService || !window.authService.isAuthenticated()) {
            alert('⚠️ Debes iniciar sesión para eliminar canciones');
            window.location.href = '/OurCorner/views/login.html?return=' + encodeURIComponent(window.location.pathname);
            return;
        }

        if (!confirm('¿Estás seguro de eliminar esta canción? 🗑️')) return;

        try {
            if (!window.supabaseClient) {
                console.error('❌ Supabase no está inicializado');
                this.mostrarNotificacion('❌ Error: Supabase no inicializado', 'error');
                return;
            }

            // Buscar la canción en la playlist actual para obtener path/url
            const cancion = this.playlist.find(c => String(c.id) === String(id));

            // Eliminar registro de la tabla
            const { error: delError } = await window.supabaseClient.from('canciones').delete().eq('id', id);
            if (delError) {
                console.error('❌ Error eliminando registro en Supabase:', delError);
                throw delError;
            }

            // Eliminar archivo del storage si tenemos el path
            const path = cancion?.path || (cancion?.url ? (cancion.url.split('/archivos/')[1] || null) : null);
            if (path) {
                const { error: rmError } = await window.supabaseClient.storage.from('archivos').remove([path]);
                if (rmError) console.warn('⚠️ Advertencia eliminando archivo en Storage:', rmError);
            }

            // Recargar playlist
            await this.cargarPlaylist();

            // Si la canción eliminada es la actual, parar y cargar otra
            if (String(this.playlist[this.currentTrack]?.id) === String(id)) {
                this.pause();
                this.cargarCancion(0);
            }

            this.mostrarNotificacion('Canción eliminada correctamente 🗑️', 'info');
        } catch (err) {
            console.error('Error al eliminar canción:', err);
            this.mostrarNotificacion('Error al eliminar la canción', 'info');
        }
    }

    mostrarNotificacion(mensaje, tipo) {
        const notif = document.createElement('div');
        notif.className = `notificacion-musica ${tipo}`;
        notif.textContent = mensaje;

        document.body.appendChild(notif);

        setTimeout(() => notif.classList.add('show'), 10);

        setTimeout(() => {
            notif.classList.remove('show');
            setTimeout(() => notif.remove(), 300);
        }, 3000);
    }

    mostrarPlaylist() {
        // Pausar música
        if (this.playing) this.pause();

        // Si no hay canciones, mostrar mensaje
        if (this.playlist.length === 0) {
            const modal = document.createElement('div');
            modal.className = 'modal-playlist';
            modal.innerHTML = `
                <div class="modal-overlay-playlist"></div>
                <div class="modal-contenido-playlist">
                    <h2>🎵 Mi Playlist Romántica</h2>
                    <div style="text-align: center; padding: 40px 20px;">
                        <div style="font-size: 5rem; margin-bottom: 20px;">📭</div>
                        <h3 style="color: var(--morado-suave); margin-bottom: 15px;">Playlist vacía</h3>
                        <p style="margin-bottom: 25px;">Aún no has agregado ninguna canción.</p>
                        <button class="btn-agregar-primera" style="
                            background: linear-gradient(135deg, var(--rojo-amor), #ff6b9d);
                            color: white;
                            border: none;
                            padding: 15px 30px;
                            border-radius: 50px;
                            font-size: 1.1rem;
                            cursor: pointer;
                            transition: all 0.3s ease;
                        ">
                            ➕ Agregar primera canción
                        </button>
                    </div>
                    <button class="btn-cerrar-playlist">✖️ Cerrar</button>
                </div>
            `;

            document.body.appendChild(modal);

            // Evento botón agregar
            modal.querySelector('.btn-agregar-primera').addEventListener('click', () => {
                modal.remove();
                this.abrirFormularioCancion();
            });

            // Cerrar
            modal.querySelector('.btn-cerrar-playlist').addEventListener('click', () => {
                modal.remove();
            });

            modal.querySelector('.modal-overlay-playlist').addEventListener('click', () => {
                modal.remove();
            });

            setTimeout(() => modal.classList.add('active'), 10);
            return;
        }

        // Crear modal de playlist
        const modal = document.createElement('div');
        modal.className = 'modal-playlist';
        modal.innerHTML = `
            <div class="modal-overlay-playlist"></div>
            <div class="modal-contenido-playlist">
                <h2>🎵 Mi Playlist Romántica</h2>
                <p class="subtitulo-modal">${this.playlist.length} canción${this.playlist.length !== 1 ? 'es' : ''} en total</p>
                
                <div class="lista-canciones">
                    ${this.playlist.map((cancion, index) => `
                        <div class="cancion-item ${index === this.currentTrack ? 'actual' : ''}" data-index="${index}">
                            <div class="cancion-numero">${index + 1}</div>
                            <div class="cancion-info-item">
                                <div class="cancion-titulo-item">${cancion.titulo}</div>
                                <div class="cancion-artista-item">${cancion.artista}</div>
                            </div>
                            ${cancion.tipo === 'personalizada' ? `
                                <button class="btn-eliminar-cancion" data-id="${cancion.id}" title="Eliminar">
                                    🗑️
                                </button>
                            ` : ''}
                            <button class="btn-reproducir-cancion" data-index="${index}" title="Reproducir">
                                ▶️
                            </button>
                        </div>
                    `).join('')}
                </div>
                
                <button class="btn-cerrar-playlist">✖️ Cerrar</button>
            </div>
        `;

        document.body.appendChild(modal);

        // Eventos de eliminar
        modal.querySelectorAll('.btn-eliminar-cancion').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.stopPropagation();
                const id = btn.dataset.id;
                this.eliminarCancion(id);
                modal.remove();
            });
        });

        // Eventos de reproducir
        modal.querySelectorAll('.btn-reproducir-cancion').forEach(btn => {
            btn.addEventListener('click', (e) => {
                e.stopPropagation();
                const index = parseInt(btn.dataset.index);
                this.cargarCancion(index);
                this.play();
                modal.remove();
            });
        });

        // Cerrar
        modal.querySelector('.btn-cerrar-playlist').addEventListener('click', () => {
            modal.remove();
        });

        modal.querySelector('.modal-overlay-playlist').addEventListener('click', () => {
            modal.remove();
        });

        // Animación
        setTimeout(() => modal.classList.add('active'), 10);
    }
}

// Inicializar cuando el DOM esté listo
let reproductorGlobal;

document.addEventListener('DOMContentLoaded', () => {
    reproductorGlobal = new ReproductorRomantico();

    // Preguntar al usuario si quiere música (opcional)
    // setTimeout(() => {
    //     if (confirm('¿Quieres escuchar música romántica? 🎵💕')) {
    //         reproductorGlobal.play();
    //     }
    // }, 2000);
});
