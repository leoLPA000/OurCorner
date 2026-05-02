# 💕 NuestroMes - Página Web Romántica

## 🎯 Descripción
**NuestroMes** es una página web romántica e interactiva creada como regalo digital. El sitio presenta mensajes personalizados clasificados por emociones, con animaciones suaves y un diseño romántico.

## 📦 Características

- ✨ Interfaz romántica y fluida
- 📱 Diseño completamente responsive
- 💬 Categorías de mensajes personalizables
- 🔐 Autenticación con Supabase
- 🎨 Animaciones suaves y elegantes
- 📚 Galería de imágenes personalizada
- 🎵 Reproducción de audio
- ✍️ Sistema para guardar mensajes favoritos

---

## 🚀 Inicio Rápido

### Requisitos Previos
- Node.js 14+ (opcional, solo si usas herramientas de build)
- Git
- Navegador moderno

### Instalación

```bash
# Clonar el repositorio
git clone https://github.com/leolpa000/OurCorner.git
cd OurCorner

# Si usas servidor local (ej: Laragon)
# Coloca la carpeta en htdocs/ de Laragon
```

### Uso Local
```bash
# Opción 1: Servir con Laragon/XAMPP/PHP
# Solo abre en navegador: http://localhost/OurCorner

# Opción 2: Usar un servidor HTTP simple
python -m http.server 8000
# O con Node.js:
npx http-server
```

---

## 📁 Estructura del Proyecto

```
OurCorner/
├── index.html                 # Página principal
├── README.md                  # Este archivo
├── .htaccess                  # Configuración Apache
│
├── archivosPHP/              # Funciones PHP
│   ├── mensajes.php
│   ├── mis-mensajes.php
│   ├── test.php
│   └── index.php
│
├── assets/                    # Recursos estáticos
│   ├── css/                   # Estilos
│   │   ├── estilos.css
│   │   ├── boton-navidad.css
│   │   ├── calendario.css
│   │   └── ...
│   ├── js/                    # Scripts JavaScript
│   │   ├── config/
│   │   ├── controllers/
│   │   ├── models/
│   │   ├── services/
│   │   ├── ui/
│   │   └── data/
│   ├── images/                # Imágenes
│   ├── audio/                 # Archivos de audio
│   └── data/
│       └── mensajes.json
│
├── views/                     # Páginas HTML
│   ├── mensajes.html
│   ├── mis-mensajes.html
│   ├── login.html
│   ├── admin-panel.html
│   └── ...
│
├── docs/                      # Documentación
│   ├── README.md
│   ├── CLEANUP-SUMMARY.md     # Resumen de limpieza
│   ├── AUTENTICACION.md
│   ├── DEPLOY.md
│   ├── sql/                   # Scripts SQL
│   │   ├── supabase-setup.sql
│   │   ├── CLEANUP-VISITOR-LOGS-AUTO.sql
│   │   └── ...
│   └── ...
│
└── galeria/                   # Galería de imágenes
```

---

## 🔐 Configuración de Base de Datos

### Supabase Setup

1. **Crear proyecto en Supabase**
   - Ir a https://supabase.com
   - Crear nuevo proyecto

2. **Ejecutar script de inicialización**
   ```bash
   # Copiar y ejecutar en Supabase SQL Editor:
   # docs/sql/supabase-setup.sql
   ```

3. **Configurar variables de entorno**
   ```javascript
   // En tu archivo de configuración:
   const SUPABASE_URL = 'tu-url-supabase'
   const SUPABASE_ANON_KEY = 'tu-anon-key'
   ```

---

## 🧹 Limpieza de IP Tracking (IMPORTANTE)

**Estado Actual:** Se han eliminado todos los archivos y funcionalidad de IP tracking y geolocalización.

### 📋 Cambios Realizados

A partir del commit `e7d758e` en la rama `25-04-2026-Refactorizacion02-05-2026`:

✅ **Archivos Eliminados:**
- Código PHP de logging (`archivosPHP/ip-logger.php`)
- Scripts JavaScript de tracking (3 archivos)
- Vistas HTML de dashboards (4 archivos)
- Datos de visitor logs JSON
- Documentación relacionada
- Scripts SQL de setup

✅ **Próximos Pasos (OBLIGATORIO si usas Supabase):**

1. **Hacer backup de tu BD** (IMPORTANTE)
   ```bash
   # Desde Supabase Dashboard:
   # Database → Backups → Request new backup
   ```

2. **Ejecutar script de limpieza en Supabase SQL Editor**
   ```sql
   -- Copiar el contenido de:
   -- docs/sql/CLEANUP-VISITOR-LOGS-AUTO.sql
   
   -- Y pegarlo en Supabase SQL Editor
   -- Luego ejecutar (Run)
   ```

3. **Verificar que se completó**
   - No debería haber errores
   - Deberías ver mensajes de confirmación (✅ Limpieza completada)

4. **Confirmar que la tabla fue eliminada**
   ```sql
   SELECT * FROM information_schema.tables 
   WHERE table_name = 'visitor_logs';
   -- Resultado: (0 rows)
   ```

### 📖 Más Información
Ver: [CLEANUP-SUMMARY.md](docs/CLEANUP-SUMMARY.md)

---

## 🌐 Deploy

### GitHub Pages

```bash
git add .
git commit -m "Cambios"
git push origin main
```

Habilitar GitHub Pages en:
- Repository Settings → Pages
- Branch: main / folder: root

### Servidor Propio

```bash
# Copiar archivos al servidor
scp -r . usuario@servidor:/ruta/

# O usar Git
cd /ruta/proyecto
git pull origin main
```

---

## 🛠️ Mantenimiento

### Actualizar mensajes

Edita `assets/data/mensajes.json`:
```json
{
  "feliz": [
    "Mensaje 1",
    "Mensaje 2"
  ],
  "triste": [...],
  ...
}
```

### Actualizar configuración

Edita los archivos en `assets/js/config/`

### Ver logs en Supabase

```sql
-- Revisar tabla específica
SELECT * FROM nombre_tabla LIMIT 10;

-- Ver tabla de reacciones
SELECT * FROM public.reacciones;
```

---

## 📚 Documentación Adicional

- [Guía de Autenticación](docs/AUTENTICACION.md)
- [Guía de Deploy](docs/DEPLOY.md)
- [Estructura del Proyecto](docs/ESTRUCTURA.md)
- [Resumen de Limpieza](docs/CLEANUP-SUMMARY.md)

---

## 🤝 Contribuir

Las contribuciones son bienvenidas. Por favor:

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

---

## 📝 Licencia

Este proyecto es de uso personal. 

---

## 👤 Autor

**Leonardo** - Creado como regalo para Rocío ❤️

---

## 📞 Soporte

Para reportar problemas o sugerencias:
- Abre un issue en GitHub
- Contacta directamente

---

## ✨ Changelog

### 2 de mayo 2026 - Refactorización
- ✅ Eliminado IP tracking y geolocalización
- ✅ Limpieza de código (18 archivos)
- ✅ Script automático para limpiar BD
- ✅ Documentación actualizada

### Versiones anteriores
Ver: [CHANGELOG.md](docs/markdown/CHANGELOG.md)

---

**Last Updated:** 2 de mayo 2026


