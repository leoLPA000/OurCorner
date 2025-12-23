<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pruebas - NuestroMes</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            max-width: 900px;
            margin: 40px auto;
            padding: 20px;
            background: #f5f5f5;
        }
        .test-section {
            background: white;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        .test-result {
            padding: 10px;
            margin: 10px 0;
            border-radius: 5px;
        }
        .pass { background: #d4edda; color: #155724; }
        .fail { background: #f8d7da; color: #721c24; }
        .info { background: #d1ecf1; color: #0c5460; }
        h2 { color: #e63946; }
        pre {
            background: #f8f9fa;
            padding: 10px;
            border-radius: 5px;
            overflow-x: auto;
        }
    </style>
</head>
<body>
    <h1>🧪 Pruebas del Sistema - NuestroMes</h1>
    
    <?php
    // Test 1: Verificar que mensajes.json existe y es válido
    echo '<div class="test-section">';
    echo '<h2>Test 1: Archivo JSON</h2>';
    
    $jsonFile = 'data/mensajes.json';
    if (file_exists($jsonFile)) {
        echo '<div class="test-result pass">✓ El archivo mensajes.json existe</div>';
        
        $jsonContent = file_get_contents($jsonFile);
        $data = json_decode($jsonContent, true);
        
        if (json_last_error() === JSON_ERROR_NONE) {
            echo '<div class="test-result pass">✓ El JSON es válido</div>';
            
            // Verificar categorías
            $categoriasEsperadas = ['feliz', 'triste', 'enojada', 'amor', 'nostalgia', 'motivacion'];
            $todasPresentes = true;
            foreach ($categoriasEsperadas as $cat) {
                if (isset($data[$cat])) {
                    $count = count($data[$cat]);
                    echo "<div class='test-result pass'>✓ Categoría '$cat': $count mensajes</div>";
                } else {
                    echo "<div class='test-result fail'>✗ Categoría '$cat' faltante</div>";
                    $todasPresentes = false;
                }
            }
            
            if ($todasPresentes) {
                echo '<div class="test-result pass">✓ Todas las categorías están presentes</div>';
            }
            
            // Contar mensajes totales
            $totalMensajes = 0;
            foreach ($data as $categoria => $mensajes) {
                $totalMensajes += count($mensajes);
            }
            echo "<div class='test-result info'>ℹ Total de mensajes: $totalMensajes</div>";
            
        } else {
            echo '<div class="test-result fail">✗ Error de JSON: ' . json_last_error_msg() . '</div>';
        }
    } else {
        echo '<div class="test-result fail">✗ El archivo mensajes.json NO existe</div>';
    }
    echo '</div>';
    
    // Test 2: Verificar archivos CSS y JS
    echo '<div class="test-section">';
    echo '<h2>Test 2: Archivos de recursos</h2>';
    
    $archivos = [
        'css/estilos.css' => 'CSS',
        'js/efectos.js' => 'JavaScript Efectos',
        'js/cursorEffects.js' => 'JavaScript Cursor',
        'img/rosa.svg' => 'Rosa SVG',
        'img/corazon.svg' => 'Corazón SVG',
       
    ];
    
    foreach ($archivos as $archivo => $nombre) {
        if (file_exists($archivo)) {
            $size = filesize($archivo);
            $sizeKB = round($size / 1024, 2);
            echo "<div class='test-result pass'>✓ $nombre existe ({$sizeKB} KB)</div>";
        } else {
            echo "<div class='test-result fail'>✗ $nombre NO existe</div>";
        }
    }
    echo '</div>';
    
    // Test 3: Verificar PHP
    echo '<div class="test-section">';
    echo '<h2>Test 3: Configuración PHP</h2>';
    
    echo '<div class="test-result pass">✓ Versión PHP: ' . phpversion() . '</div>';
    echo '<div class="test-result pass">✓ JSON extension: ' . (extension_loaded('json') ? 'Habilitada' : 'Deshabilitada') . '</div>';
    
    echo '</div>';
    
    // Test 4: Simulación de categorías
    echo '<div class="test-section">';
    echo '<h2>Test 4: Simulación de URLs</h2>';
    
    $categoriasTest = ['feliz', 'triste', 'enojada', 'amor', 'nostalgia', 'motivacion', 'invalida'];
    
    foreach ($categoriasTest as $cat) {
        $url = "mensajes.php?categoria=$cat";
        echo "<div class='test-result info'>";
        echo "URL: <a href='$url' target='_blank'>$url</a>";
        
        if ($cat === 'invalida') {
            echo " (debería mostrar error)";
        }
        echo "</div>";
    }
    echo '</div>';
    
    // Test 5: Información del sistema
    echo '<div class="test-section">';
    echo '<h2>Test 5: Información del Sistema</h2>';
    
    echo '<div class="test-result info">Servidor: ' . $_SERVER['SERVER_SOFTWARE'] . '</div>';
    echo '<div class="test-result info">Puerto: ' . $_SERVER['SERVER_PORT'] . '</div>';
    echo '<div class="test-result info">Directorio: ' . __DIR__ . '</div>';
    
    echo '</div>';
    
    // Test 6: Validación de estructura de mensajes
    echo '<div class="test-section">';
    echo '<h2>Test 6: Validación de Estructura de Mensajes</h2>';
    
    if (isset($data)) {
        $erroresEstructura = [];
        foreach ($data as $categoria => $mensajes) {
            foreach ($mensajes as $index => $mensaje) {
                if (!isset($mensaje['texto'])) {
                    $erroresEstructura[] = "Categoría '$categoria', mensaje $index: falta campo 'texto'";
                }
                if (!isset($mensaje['emoji'])) {
                    $erroresEstructura[] = "Categoría '$categoria', mensaje $index: falta campo 'emoji'";
                }
            }
        }
        
        if (empty($erroresEstructura)) {
            echo '<div class="test-result pass">✓ Todos los mensajes tienen la estructura correcta</div>';
        } else {
            foreach ($erroresEstructura as $error) {
                echo "<div class='test-result fail'>✗ $error</div>";
            }
        }
    }
    echo '</div>';
    ?>
    
    <div class="test-section">
        <h2>Acciones</h2>
        <p>
            <a href="index.php" style="display:inline-block; padding:10px 20px; background:#e63946; color:white; text-decoration:none; border-radius:5px; margin-right:10px;">
                🏠 Ir a Inicio
            </a>
            <a href="?" style="display:inline-block; padding:10px 20px; background:#8e44ad; color:white; text-decoration:none; border-radius:5px;">
                🔄 Recargar Tests
            </a>
        </p>
    </div>
</body>
</html>
