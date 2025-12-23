<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Mensajes personalizados de Rocío">
    <title>Mis Mensajes Personalizados ✍️</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="img/corazon.svg">
    
    <!-- Estilos -->
    <link rel="stylesheet" href="css/estilos.css">
    
    <!-- Fuentes -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&family=Great+Vibes&display=swap" rel="stylesheet">
</head>
<body>
    <div class="container">
        <header class="hero">
            <a href="index.html" class="btn-volver" aria-label="Volver a la página principal">← Volver</a>
            <h1 class="titulo-categoria">✍️ Mis Mensajes</h1>
            <p class="mensaje-intro">
                Tus propias palabras de amor guardadas aquí 💕
            </p>
        </header>

        <section class="filtros-section">
            <label for="filtroCategoria" class="filtro-label">
                Filtrar por categoría:
            </label>
            <select id="filtroCategoria" class="filtro-select">
                <option value="todas">📂 Todas las categorías</option>
                <option value="feliz">😄 Feliz</option>
                <option value="triste">😢 Triste</option>
                <option value="enojada">😤 Enojada</option>
                <option value="amor">❤️ Amor</option>
                <option value="nostalgia">🌙 Nostalgia</option>
                <option value="motivacion">💪 Motivación</option>
            </select>
        </section>

        <section class="mensajes-personalizados" id="mensajesPersonalizados">
            <!-- Los mensajes se cargarán dinámicamente aquí -->
        </section>

        <footer class="pie-pagina">
            <p>Mensajes creados con amor por ti 💕</p>
        </footer>
    </div>

    <!-- Efectos visuales -->
    <div id="efectos-fondo"></div>
    <div id="cursor-particles"></div>
    
     <!--<script src="js/efectos.js"></script> -->
    <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>
    <script src="js/supabaseConfig.js"></script>
    <script src="js/cursorEffects.js"></script>
    <script src="js/musica.js"></script>
    <script src="js/galeria.js"></script>
    <script src="js/modoOscuro.js"></script>
    <script src="js/formulario.js"></script>
    
    <script>
        // Cargar y mostrar mensajes personalizados
        function cargarMensajesPersonalizados() {
            const mensajes = JSON.parse(localStorage.getItem('mensajesPersonalizados') || '[]');
            const contenedor = document.getElementById('mensajesPersonalizados');
            const filtro = document.getElementById('filtroCategoria').value;
            
            // Filtrar mensajes si es necesario
            const mensajesFiltrados = filtro === 'todas' 
                ? mensajes 
                : mensajes.filter(m => m.categoria === filtro);
            
            if (mensajesFiltrados.length === 0) {
                contenedor.innerHTML = `
                    <div class="mensaje-vacio-grande">
                        <div class="icono-vacio">✍️</div>
                        <h3>No hay mensajes aquí todavía</h3>
                        <p>Usa el botón "Agregar Mensaje" para crear tu primer mensaje personalizado</p>
                        <button onclick="document.querySelector('.btn-formulario').click()" class="btn-crear-primero">
                            ✍️ Crear mi primer mensaje
                        </button>
                    </div>
                `;
                return;
            }
            
            // Ordenar por fecha (más recientes primero)
            mensajesFiltrados.sort((a, b) => b.id - a.id);
            
            contenedor.innerHTML = mensajesFiltrados.map(mensaje => `
                <article class="mensaje-card mensaje-personalizado" data-id="${mensaje.id}">
                    <div class="mensaje-header-personalizado">
                        <span class="emoji-grande">${mensaje.emoji}</span>
                        <span class="badge-personalizado">Tu mensaje</span>
                    </div>
                    <p class="mensaje-texto">${mensaje.texto}</p>
                    ${mensaje.nota ? `<p class="mensaje-nota-personalizado">📝 ${mensaje.nota}</p>` : ''}
                    <div class="mensaje-footer-personalizado">
                        <span class="mensaje-firma">— ${mensaje.autor}</span>
                        <span class="mensaje-fecha-creacion">${mensaje.fecha}</span>
                    </div>
                    <button class="btn-eliminar-mensaje-vista" data-id="${mensaje.id}" title="Eliminar mensaje">
                        🗑️ Eliminar
                    </button>
                </article>
            `).join('');
            
            // Bind eventos de eliminación
            document.querySelectorAll('.btn-eliminar-mensaje-vista').forEach(btn => {
                btn.addEventListener('click', (e) => {
                    const id = parseInt(e.target.dataset.id);
                    eliminarMensajeVista(id);
                });
            });
        }
        
        function eliminarMensajeVista(id) {
            if (!confirm('¿Estás segura de que quieres eliminar este mensaje?')) {
                return;
            }
            
            let mensajes = JSON.parse(localStorage.getItem('mensajesPersonalizados') || '[]');
            mensajes = mensajes.filter(m => m.id !== id);
            localStorage.setItem('mensajesPersonalizados', JSON.stringify(mensajes));
            
            // Recargar lista
            cargarMensajesPersonalizados();
            
            // Mostrar notificación
            mostrarNotificacion('Mensaje eliminado correctamente', 'info');
        }
        
        function mostrarNotificacion(mensaje, tipo) {
            const notificacion = document.createElement('div');
            notificacion.className = `notificacion-toast notificacion-${tipo} show`;
            notificacion.innerHTML = `
                <span class="notificacion-icono">${tipo === 'info' ? 'ℹ️' : '✅'}</span>
                <span class="notificacion-texto">${mensaje}</span>
            `;
            document.body.appendChild(notificacion);
            
            setTimeout(() => {
                notificacion.classList.remove('show');
                setTimeout(() => notificacion.remove(), 300);
            }, 3000);
        }
        
        // Cargar al inicio
        document.addEventListener('DOMContentLoaded', () => {
            cargarMensajesPersonalizados();
            
            // Evento de filtro
            document.getElementById('filtroCategoria').addEventListener('change', cargarMensajesPersonalizados);
            
            // Recargar cuando se guarde un nuevo mensaje
            window.addEventListener('storage', (e) => {
                if (e.key === 'mensajesPersonalizados') {
                    cargarMensajesPersonalizados();
                }
            });
        });
    </script>
    
    <style>
        .filtros-section {
            text-align: center;
            margin: 30px 0;
        }
        
        .filtro-label {
            font-family: var(--font-cuerpo);
            font-size: 1.2rem;
            color: var(--morado-suave);
            display: block;
            margin-bottom: 10px;
        }
        
        body.tema-oscuro .filtro-label {
            color: var(--acento-oscuro);
        }
        
        .filtro-select {
            padding: 12px 20px;
            border: 2px solid var(--rosa-claro);
            border-radius: 25px;
            font-family: var(--font-texto);
            font-size: 1rem;
            background: white;
            cursor: pointer;
            min-width: 250px;
        }
        
        body.tema-oscuro .filtro-select {
            background: var(--bg-oscuro-card);
            color: var(--texto-oscuro);
            border-color: var(--morado-oscuro);
        }
        
        .mensajes-personalizados {
            display: flex;
            flex-direction: column;
            gap: 20px;
            margin: 30px 0;
        }
        
        .mensaje-personalizado {
            position: relative;
            padding-bottom: 60px;
        }
        
        .mensaje-header-personalizado {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 15px;
        }
        
        .badge-personalizado {
            background: linear-gradient(135deg, #ff6b9d, var(--morado-suave));
            color: white;
            padding: 5px 15px;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: bold;
        }
        
        .mensaje-nota-personalizado {
            font-size: 1rem;
            color: var(--morado-suave);
            font-style: italic;
            margin-top: 10px;
        }
        
        body.tema-oscuro .mensaje-nota-personalizado {
            color: var(--acento-oscuro);
        }
        
        .mensaje-footer-personalizado {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 2px solid var(--rosa-claro);
        }
        
        body.tema-oscuro .mensaje-footer-personalizado {
            border-color: var(--morado-oscuro);
        }
        
        .mensaje-firma {
            font-family: var(--font-cuerpo);
            font-size: 1.1rem;
            color: var(--rojo-amor);
            font-weight: bold;
        }
        
        body.tema-oscuro .mensaje-firma {
            color: var(--acento-oscuro);
        }
        
        .mensaje-fecha-creacion {
            font-size: 0.9rem;
            color: var(--morado-suave);
        }
        
        body.tema-oscuro .mensaje-fecha-creacion {
            color: var(--texto-oscuro);
        }
        
        .btn-eliminar-mensaje-vista {
            position: absolute;
            bottom: 15px;
            right: 15px;
            background: rgba(230, 57, 70, 0.1);
            color: var(--rojo-amor);
            border: none;
            padding: 8px 15px;
            border-radius: 20px;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-eliminar-mensaje-vista:hover {
            background: var(--rojo-amor);
            color: white;
            transform: scale(1.05);
        }
        
        .mensaje-vacio-grande {
            text-align: center;
            padding: 60px 20px;
            background: rgba(255, 194, 209, 0.1);
            border-radius: 30px;
            border: 3px dashed var(--rosa-claro);
        }
        
        body.tema-oscuro .mensaje-vacio-grande {
            background: rgba(255, 107, 157, 0.05);
            border-color: var(--acento-oscuro);
        }
        
        .icono-vacio {
            font-size: 5rem;
            margin-bottom: 20px;
        }
        
        .mensaje-vacio-grande h3 {
            font-family: var(--font-titulo);
            font-size: 2rem;
            color: var(--morado-suave);
            margin-bottom: 15px;
        }
        
        body.tema-oscuro .mensaje-vacio-grande h3 {
            color: var(--acento-oscuro);
        }
        
        .mensaje-vacio-grande p {
            font-size: 1.1rem;
            color: var(--gris-texto);
            margin-bottom: 25px;
        }
        
        body.tema-oscuro .mensaje-vacio-grande p {
            color: var(--texto-oscuro);
        }
        
        .btn-crear-primero {
            background: linear-gradient(135deg, var(--rojo-amor), #ff6b9d);
            color: white;
            border: none;
            padding: 15px 30px;
            border-radius: 50px;
            font-family: var(--font-cuerpo);
            font-size: 1.2rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        
        .btn-crear-primero:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 30px var(--sombra-suave);
        }
    </style>
</body>
</html>
