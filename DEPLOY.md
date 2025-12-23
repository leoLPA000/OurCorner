# 🚀 Guía Rápida de Despliegue - NuestroMes

## 📋 Checklist Pre-Despliegue

Antes de subir tu proyecto a internet, verifica:

- [x] Todos los mensajes personalizados están completos
- [x] El nombre de Rocío aparece correctamente
- [x] La fecha de inicio es correcta (5 de octubre, 2025)
- [x] Probaste en móvil localmente
- [x] No hay errores en `test.php`
- [ ] Tienes una cuenta de hosting o GitHub

---

## 🌐 Opción 1: Hosting con PHP (RECOMENDADO)

### Proveedores gratuitos sugeridos:
1. **InfinityFree** - https://infinityfree.com
2. **000webhost** - https://www.000webhost.com
3. **Hostinger Free** - https://www.hostinger.com

### Pasos:

#### 1. Crear cuenta en el hosting
- Regístrate con tu email
- Elige un subdominio gratuito (ej: `nuestromes.infinityfreeapp.com`)

#### 2. Subir archivos vía FTP
**Usando FileZilla (recomendado):**
```
1. Descarga FileZilla: https://filezilla-project.org/
2. Conecta con los datos de tu hosting (host, usuario, contraseña)
3. Sube TODA la carpeta nuestroMes/ a /htdocs/ o /public_html/
```

**Estructura en servidor:**
```
/htdocs/
  ├── index.php
  ├── mensajes.php
  ├── test.php
  ├── .htaccess
  ├── css/
  ├── js/
  ├── data/
  └── img/
```

#### 3. Verificar permisos
- Asegúrate de que `data/mensajes.json` tenga permisos de lectura (644)

#### 4. Probar
- Accede a: `https://tusubdominio.infinityfreeapp.com`
- Prueba: `https://tusubdominio.infinityfreeapp.com/test.php`

---

## 💾 Opción 2: GitHub Pages (Conversión necesaria)

⚠️ **Limitación**: GitHub Pages NO soporta PHP

### Solución: Convertir a HTML + JavaScript puro

**Pasos:**

1. **Renombrar archivos:**
   - `index.php` → `index.html`
   - `mensajes.php` → `mensajes.html`

2. **Modificar mensajes.html** para cargar JSON con fetch:
```javascript
fetch('data/mensajes.json')
  .then(response => response.json())
  .then(data => {
    // Procesar mensajes aquí
  });
```

3. **Subir a GitHub:**
```bash
git init
git add .
git commit -m "Initial commit - NuestroMes"
git branch -M main
git remote add origin https://github.com/leoLPA000/NuestroMes.git
git push -u origin main
```

4. **Habilitar GitHub Pages:**
   - Ve a Settings → Pages
   - Source: `main` branch
   - URL: `https://leolpa000.github.io/NuestroMes/`

---

## 🔒 Opción 3: Hosting Privado con Contraseña

Si quieres que solo Rocío vea la página:

### A) Protección con .htaccess (Apache)

**Crear `.htpasswd`:**
```bash
htpasswd -c .htpasswd rocio
# Ingresa una contraseña
```

**Modificar `.htaccess`:**
```apache
AuthType Basic
AuthName "Solo para Rocío 💕"
AuthUserFile /ruta/completa/a/.htpasswd
Require valid-user
```

### B) Protección con PHP simple

**Crear `login.php`:**
```php
<?php
session_start();
$password_correcto = 'rocio2025'; // Cambia esto

if ($_POST['password'] === $password_correcto) {
    $_SESSION['autenticado'] = true;
    header('Location: index.php');
}
?>
<!DOCTYPE html>
<html>
<body>
    <form method="POST">
        <input type="password" name="password" placeholder="Contraseña">
        <button>Entrar</button>
    </form>
</body>
</html>
```

**Proteger `index.php` (agregar al inicio):**
```php
<?php
session_start();
if (!isset($_SESSION['autenticado'])) {
    header('Location: login.php');
    exit;
}
?>
```

---

## 📱 Probar en móvil (antes de desplegar)

### Método 1: Misma red Wi-Fi
1. En tu PC, ejecuta: `ipconfig`
2. Encuentra tu IPv4 (ej: 192.168.0.28)
3. En el móvil: `http://192.168.0.28/pro/nuestroMes/`

### Método 2: Ngrok (túnel público temporal)
```bash
# Instalar ngrok: https://ngrok.com/download
ngrok http 80

# Te da una URL pública temporal:
# https://abc123.ngrok.io
```

---

## ✅ Post-Despliegue

### 1. Verifica funcionamiento
- [ ] Página principal carga
- [ ] Todas las categorías funcionan
- [ ] Mensajes se muestran correctamente
- [ ] Animaciones funcionan
- [ ] Contador de días actualiza
- [ ] Responsive en móvil

### 2. Optimizaciones opcionales
```bash
# Minificar CSS
# Usar: https://cssminifier.com/

# Minificar JS
# Usar: https://javascript-minifier.com/

# Optimizar imágenes SVG
# Usar: https://jakearchibald.github.io/svgomg/
```

### 3. Compartir con Rocío
```
🌹 ¡Hola mi amor!

Preparé algo especial para ti 💕

🔗 Link: https://tu-dominio.com

Ábrelo cuando quieras leer algo bonito.
Te amo muchísimo ❤️

— Leo
```

---

## 🐛 Solución de Problemas

### Problema: "500 Internal Server Error"
**Solución:**
- Verifica permisos de archivos (644 para archivos, 755 para carpetas)
- Revisa `.htaccess` (comenta líneas si da error)
- Verifica que PHP esté habilitado en el hosting

### Problema: "No se cargan los mensajes"
**Solución:**
- Verifica ruta de `data/mensajes.json`
- Verifica permisos de lectura del JSON
- Revisa consola del navegador (F12) para errores

### Problema: "Animaciones no funcionan"
**Solución:**
- Verifica que `js/efectos.js` esté enlazado
- Limpia caché del navegador
- Verifica consola de errores

### Problema: "No se ve en móvil"
**Solución:**
- Verifica que la URL sea accesible desde otra red
- Usa HTTPS si es posible
- Verifica responsive en DevTools (F12 → Toggle device)

---

## 📊 Monitoreo (Opcional)

### Google Analytics
```html
<!-- Agregar antes de </head> en index.php -->
<script async src="https://www.googletagmanager.com/gtag/js?id=TU-ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'TU-ID');
</script>
```

---

## 💡 Tips Finales

1. **Backup siempre**: Guarda una copia local antes de modificar en servidor
2. **Prueba antes**: Usa `test.php` después de desplegar
3. **SSL gratis**: Usa Let's Encrypt (muchos hostings lo incluyen)
4. **Dominio personalizado**: Compra uno bonito (ej: `nuestromes.com`)
5. **Actualiza regularmente**: Agrega nuevos mensajes cada mes

---

## 🎁 Sorpresas Extra

### Agregar música de fondo
```html
<!-- Agregar en index.php antes de </body> -->
<audio id="musicaFondo" loop>
    <source src="musica/romantica.mp3" type="audio/mpeg">
</audio>
<button onclick="document.getElementById('musicaFondo').play()">
    🎵 Reproducir
</button>
```

### Notificación del navegador
```javascript
// Pedir permiso y enviar notificación
if ('Notification' in window) {
    Notification.requestPermission().then(permission => {
        if (permission === 'granted') {
            new Notification('💕 NuestroMes', {
                body: 'Rocío, hay un mensaje nuevo para ti',
                icon: 'img/corazon.svg'
            });
        }
    });
}
```

---

**¡Éxito con tu despliegue! 🚀💕**

---

**Guía creada por Leo para NuestroMes**
*Última actualización: 5 de noviembre, 2025*
