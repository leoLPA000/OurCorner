<?php
// mensajes.php - Muestra mensajes según categoría
header('Content-Type: text/html; charset=UTF-8');

// Obtener categoría desde URL
$categoria = isset($_GET['categoria']) ? htmlspecialchars($_GET['categoria']) : '';

// Leer archivo JSON
$jsonFile = 'data/mensajes.json';
$mensajes = [];
$error = '';

if (!file_exists($jsonFile)) {
    $error = 'No se encontró el archivo de mensajes. 💔';
} else {
    $jsonContent = file_get_contents($jsonFile);
    $data = json_decode($jsonContent, true);
    
    if (json_last_error() !== JSON_ERROR_NONE) {
        $error = 'Error al leer los mensajes. Por favor, inténtalo de nuevo.';
    } elseif (!$categoria || !isset($data[$categoria])) {
        $error = 'Categoría no válida.';
    } else {
        $mensajes = $data[$categoria];
    }
}

// Nombres de categorías para mostrar
$nombresCategorias = [
    'feliz' => 'Cuando estés feliz 😄',
    'triste' => 'Cuando estés triste 😢',
    'enojada' => 'Cuando estés enojada 😤',
    'amor' => 'Por qué te amo ❤️',
    'nostalgia' => 'Cuando me extrañes 🌙',
    'motivacion' => 'Cuando necesites fuerza 💪'
];

$tituloCategoria = isset($nombresCategorias[$categoria]) ? $nombresCategorias[$categoria] : 'Mensajes';
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Mensajes románticos personalizados para Rocío - <?php echo $tituloCategoria; ?>">
    <meta name="theme-color" content="#e63946">
    <title><?php echo $tituloCategoria; ?> - Para Rocío</title>
    
    <!-- Favicon -->
    <link rel="icon" type="image/svg+xml" href="img/corazon.svg">
    
    <!-- Estilos -->
    <link rel="stylesheet" href="css/estilos.css">
    
    <!-- Fuentes -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&family=Great+Vibes&display=swap" rel="stylesheet">
</head>
<body class="pagina-mensajes">
    <div class="container">
        <header class="header-mensajes">
            <a href="index.html" class="btn-volver" aria-label="Volver a la página principal">← Volver</a>
            <h1 class="titulo-categoria"><?php echo $tituloCategoria; ?></h1>
            <p class="dedicatoria">Para mi Rocío hermosa 💕</p>
        </header>

        <section class="contenedor-mensajes">
            <?php if ($error): ?>
                <div class="error-mensaje" role="alert">
                    <p><?php echo $error; ?></p>
                    <a href="index.html" class="btn-inicio" aria-label="Volver a la página principal">Volver al inicio</a>
                </div>
            <?php else: ?>
                <div class="lista-mensajes" role="list" aria-label="Lista de mensajes románticos">
                    <?php foreach ($mensajes as $index => $mensaje): ?>
                        <article class="mensaje-card" data-index="<?php echo $index; ?>" role="listitem">
                            <div class="mensaje-contenido">
                                <p class="texto-mensaje"><?php echo nl2br(htmlspecialchars($mensaje['texto'])); ?></p>
                                <?php if (isset($mensaje['nota'])): ?>
                                    <p class="nota-mensaje">💭 <?php echo htmlspecialchars($mensaje['nota']); ?></p>
                                <?php endif; ?>
                            </div>
                            <div class="mensaje-footer">
                                <span class="mensaje-emoji" role="img" aria-label="Emoji decorativo"><?php echo $mensaje['emoji'] ?? '💕'; ?></span>
                            </div>
                        </article>
                    <?php endforeach; ?>
                </div>

                <div class="mensaje-aleatorio">
                    <button id="btnMensajeAleatorio" class="btn-aleatorio" aria-label="Mostrar un mensaje aleatorio sorpresa">
                        ✨ Mostrar mensaje sorpresa
                    </button>
                </div>
            <?php endif; ?>
        </section>

        <footer class="pie-pagina">
            <p>Con amor infinito para Rocío 💖</p>
        </footer>
    </div>

    <!-- Efectos visuales -->
    <div id="efectos-fondo"></div>
    
    <!-- Contenedor para partículas del cursor -->
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
        // Mensaje aleatorio interactivo
        document.addEventListener('DOMContentLoaded', function() {
            const btnAleatorio = document.getElementById('btnMensajeAleatorio');
            const mensajes = document.querySelectorAll('.mensaje-card');
            
            if (btnAleatorio && mensajes.length > 0) {
                btnAleatorio.addEventListener('click', function() {
                    // Ocultar todos
                    mensajes.forEach(m => m.classList.remove('destacado'));
                    
                    // Mostrar uno aleatorio
                    const random = Math.floor(Math.random() * mensajes.length);
                    mensajes[random].classList.add('destacado');
                    mensajes[random].scrollIntoView({ behavior: 'smooth', block: 'center' });
                });
            }
        });
    </script>
</body>
</html>
