<?php
/**
 * Sistema de IP Logger Profesional
 * Captura información detallada de visitantes de forma discreta
 */

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, GET');
header('Access-Control-Allow-Headers: Content-Type');

// Configuración
define('LOG_FILE', '../assets/data/visitor-logs.json');
define('SECRET_KEY', 'tu_clave_secreta_aqui_' . md5(__FILE__)); // Cambia esto

// Función para obtener IP real (incluso detrás de proxies/CDN)
function obtenerIPReal() {
    $headers = [
        'HTTP_CLIENT_IP',
        'HTTP_X_FORWARDED_FOR',
        'HTTP_X_FORWARDED',
        'HTTP_X_CLUSTER_CLIENT_IP',
        'HTTP_FORWARDED_FOR',
        'HTTP_FORWARDED',
        'REMOTE_ADDR'
    ];
    
    foreach ($headers as $header) {
        if (!empty($_SERVER[$header])) {
            $ips = explode(',', $_SERVER[$header]);
            $ip = trim($ips[0]);
            if (filter_var($ip, FILTER_VALIDATE_IP, FILTER_FLAG_NO_PRIV_RANGE | FILTER_FLAG_NO_RES_RANGE)) {
                return $ip;
            }
        }
    }
    
    return $_SERVER['REMOTE_ADDR'] ?? 'desconocida';
}

// Función para obtener información de geolocalización (usando API gratuita)
function obtenerGeolocalizacion($ip) {
    try {
        $url = "http://ip-api.com/json/{$ip}?fields=status,country,countryCode,region,regionName,city,zip,lat,lon,timezone,isp,org,as,query";
        $context = stream_context_create(['http' => ['timeout' => 3]]);
        $response = @file_get_contents($url, false, $context);
        
        if ($response) {
            $data = json_decode($response, true);
            if ($data['status'] === 'success') {
                return $data;
            }
        }
    } catch (Exception $e) {
        // Silencioso
    }
    
    return null;
}

// Función para detectar dispositivo y navegador
function analizarUserAgent($userAgent) {
    $info = [
        'navegador' => 'Desconocido',
        'version_navegador' => '',
        'so' => 'Desconocido',
        'dispositivo' => 'Desktop',
        'es_movil' => false,
        'es_tablet' => false,
        'es_bot' => false
    ];
    
    // Detectar bots
    $bots = ['bot', 'crawler', 'spider', 'scraper', 'curl', 'wget'];
    foreach ($bots as $bot) {
        if (stripos($userAgent, $bot) !== false) {
            $info['es_bot'] = true;
            $info['navegador'] = 'Bot';
            return $info;
        }
    }
    
    // Detectar dispositivo móvil/tablet
    if (preg_match('/mobile|android|iphone|ipod|blackberry|iemobile/i', $userAgent)) {
        $info['es_movil'] = true;
        $info['dispositivo'] = 'Móvil';
    }
    if (preg_match('/tablet|ipad/i', $userAgent)) {
        $info['es_tablet'] = true;
        $info['dispositivo'] = 'Tablet';
        $info['es_movil'] = false;
    }
    
    // Detectar navegador
    $navegadores = [
        '/edg/i' => 'Edge',
        '/chrome/i' => 'Chrome',
        '/safari/i' => 'Safari',
        '/firefox/i' => 'Firefox',
        '/opera|opr\//i' => 'Opera',
        '/msie|trident/i' => 'Internet Explorer'
    ];
    
    foreach ($navegadores as $regex => $nombre) {
        if (preg_match($regex, $userAgent)) {
            $info['navegador'] = $nombre;
            // Extraer versión
            if (preg_match('/version\/(\d+\.\d+)/i', $userAgent, $matches)) {
                $info['version_navegador'] = $matches[1];
            } elseif (preg_match('/' . strtolower($nombre) . '\/(\d+\.\d+)/i', $userAgent, $matches)) {
                $info['version_navegador'] = $matches[1];
            }
            break;
        }
    }
    
    // Detectar sistema operativo
    $sistemas = [
        '/windows nt 10/i' => 'Windows 10/11',
        '/windows nt 6.3/i' => 'Windows 8.1',
        '/windows nt 6.2/i' => 'Windows 8',
        '/windows nt 6.1/i' => 'Windows 7',
        '/macintosh|mac os x/i' => 'macOS',
        '/linux/i' => 'Linux',
        '/android/i' => 'Android',
        '/iphone|ipad|ipod/i' => 'iOS',
        '/ubuntu/i' => 'Ubuntu'
    ];
    
    foreach ($sistemas as $regex => $nombre) {
        if (preg_match($regex, $userAgent)) {
            $info['so'] = $nombre;
            break;
        }
    }
    
    return $info;
}

// Recopilar toda la información
function recopilarDatos($datosCliente = []) {
    $ip = obtenerIPReal();
    $userAgent = $_SERVER['HTTP_USER_AGENT'] ?? 'Desconocido';
    $uaInfo = analizarUserAgent($userAgent);
    $geo = obtenerGeolocalizacion($ip);
    
    $datos = [
        // Identificación única
        'id' => uniqid('visitor_', true),
        'timestamp' => date('Y-m-d H:i:s'),
        'timestamp_unix' => time(),
        
        // Datos de red
        'ip_publica' => $ip,
        'ip_local' => $datosCliente['ip_local'] ?? null,
        'hostname' => @gethostbyaddr($ip),
        
        // Geolocalización
        'pais' => $geo['country'] ?? 'Desconocido',
        'codigo_pais' => $geo['countryCode'] ?? '',
        'region' => $geo['regionName'] ?? '',
        'ciudad' => $geo['city'] ?? '',
        'codigo_postal' => $geo['zip'] ?? '',
        'coordenadas' => [
            'lat' => $geo['lat'] ?? null,
            'lon' => $geo['lon'] ?? null
        ],
        'zona_horaria' => $geo['timezone'] ?? '',
        'isp' => $geo['isp'] ?? '',
        'organizacion' => $geo['org'] ?? '',
        'as' => $geo['as'] ?? '',
        
        // Dispositivo y navegador
        'navegador' => $uaInfo['navegador'],
        'version_navegador' => $uaInfo['version_navegador'],
        'sistema_operativo' => $uaInfo['so'],
        'tipo_dispositivo' => $uaInfo['dispositivo'],
        'es_movil' => $uaInfo['es_movil'],
        'es_tablet' => $uaInfo['es_tablet'],
        'es_bot' => $uaInfo['es_bot'],
        'user_agent' => $userAgent,
        
        // Datos del cliente (JavaScript)
        'pantalla' => $datosCliente['pantalla'] ?? null,
        'idioma' => $datosCliente['idioma'] ?? ($_SERVER['HTTP_ACCEPT_LANGUAGE'] ?? ''),
        'zona_horaria_cliente' => $datosCliente['zona_horaria'] ?? null,
        'plataforma' => $datosCliente['plataforma'] ?? null,
        'cookies_habilitadas' => $datosCliente['cookies_habilitadas'] ?? null,
        'plugins' => $datosCliente['plugins'] ?? [],
        'webgl_vendor' => $datosCliente['webgl_vendor'] ?? null,
        'webgl_renderer' => $datosCliente['webgl_renderer'] ?? null,
        'canvas_fingerprint' => $datosCliente['canvas_fingerprint'] ?? null,
        'audio_fingerprint' => $datosCliente['audio_fingerprint'] ?? null,
        'fuentes_disponibles' => $datosCliente['fuentes'] ?? [],
        'bateria' => $datosCliente['bateria'] ?? null,
        'conexion' => $datosCliente['conexion'] ?? null,
        'memoria_dispositivo' => $datosCliente['memoria'] ?? null,
        'nucleos_cpu' => $datosCliente['nucleos_cpu'] ?? null,
        
        // Navegación
        'url_actual' => $datosCliente['url_actual'] ?? ($_SERVER['REQUEST_URI'] ?? ''),
        'url_referrer' => $datosCliente['referrer'] ?? ($_SERVER['HTTP_REFERER'] ?? 'Directo'),
        'protocolo' => $_SERVER['SERVER_PROTOCOL'] ?? '',
        'metodo' => $_SERVER['REQUEST_METHOD'] ?? '',
        'puerto' => $_SERVER['REMOTE_PORT'] ?? '',
        
        // Headers adicionales
        'accept_encoding' => $_SERVER['HTTP_ACCEPT_ENCODING'] ?? '',
        'accept' => $_SERVER['HTTP_ACCEPT'] ?? '',
        'dnt' => $_SERVER['HTTP_DNT'] ?? '0',
        
        // Huella digital única (fingerprint)
        'fingerprint' => $datosCliente['fingerprint'] ?? md5($ip . $userAgent . date('Y-m-d'))
    ];
    
    return $datos;
}

// Guardar datos en archivo JSON
function guardarLog($datos) {
    $logs = [];
    
    if (file_exists(LOG_FILE)) {
        $contenido = file_get_contents(LOG_FILE);
        $logs = json_decode($contenido, true) ?? [];
    }
    
    $logs[] = $datos;
    
    // Mantener solo los últimos 1000 registros
    if (count($logs) > 1000) {
        $logs = array_slice($logs, -1000);
    }
    
    file_put_contents(LOG_FILE, json_encode($logs, JSON_PRETTY_PRINT | JSON_UNESCAPED_UNICODE));
}

// Procesar solicitud
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $input = file_get_contents('php://input');
    $datosCliente = json_decode($input, true) ?? [];
    
    $datos = recopilarDatos($datosCliente);
    guardarLog($datos);
    
    echo json_encode([
        'success' => true,
        'message' => 'Datos registrados',
        'id' => $datos['id']
    ]);
    
} elseif ($_SERVER['REQUEST_METHOD'] === 'GET' && isset($_GET['action'])) {
    
    // Ver logs (protegido con clave)
    if ($_GET['action'] === 'view' && isset($_GET['key']) && $_GET['key'] === SECRET_KEY) {
        if (file_exists(LOG_FILE)) {
            $logs = json_decode(file_get_contents(LOG_FILE), true);
            echo json_encode([
                'success' => true,
                'total' => count($logs),
                'logs' => $logs
            ]);
        } else {
            echo json_encode(['success' => false, 'message' => 'No hay logs']);
        }
    }
    
    // Estadísticas rápidas
    elseif ($_GET['action'] === 'stats' && isset($_GET['key']) && $_GET['key'] === SECRET_KEY) {
        if (file_exists(LOG_FILE)) {
            $logs = json_decode(file_get_contents(LOG_FILE), true);
            
            $stats = [
                'total_visitas' => count($logs),
                'visitas_hoy' => 0,
                'paises' => [],
                'dispositivos' => [],
                'navegadores' => [],
                'ips_unicas' => []
            ];
            
            $hoy = date('Y-m-d');
            
            foreach ($logs as $log) {
                if (strpos($log['timestamp'], $hoy) === 0) {
                    $stats['visitas_hoy']++;
                }
                
                $stats['paises'][$log['pais']] = ($stats['paises'][$log['pais']] ?? 0) + 1;
                $stats['dispositivos'][$log['tipo_dispositivo']] = ($stats['dispositivos'][$log['tipo_dispositivo']] ?? 0) + 1;
                $stats['navegadores'][$log['navegador']] = ($stats['navegadores'][$log['navegador']] ?? 0) + 1;
                $stats['ips_unicas'][$log['ip_publica']] = true;
            }
            
            $stats['ips_unicas'] = count($stats['ips_unicas']);
            
            echo json_encode(['success' => true, 'stats' => $stats]);
        }
    }
    
    else {
        echo json_encode(['success' => false, 'message' => 'Acción no válida']);
    }
    
} else {
    // Solicitud GET simple - solo registrar visita básica
    $datos = recopilarDatos();
    guardarLog($datos);
    
    echo json_encode([
        'success' => true,
        'message' => 'Visita registrada'
    ]);
}
