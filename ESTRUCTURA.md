# Estructura del Proyecto NuestroMes - Reorganizado

## 📁 Nueva Estructura

```
NuestroMes/
├── index.html                          # Página principal (en raíz para GitHub Pages)
├── assets/                             # Recursos estáticos
│   ├── css/                            # Estilos
│   ├── js/                             # Scripts organizados por capas
│   │   ├── config/                     # Configuración
│   │   ├── models/                     # Lógica de datos
│   │   ├── controllers/                # Lógica de negocio
│   │   ├── services/                   # Servicios compartidos
│   │   └── ui/                         # Efectos visuales
│   ├── images/                         # Imágenes
│   ├── audio/                          # Audio
│   └── data/                           # JSON
├── views/                              # Páginas HTML
└── docs/                               # Documentación
    ├── sql/                            # Scripts SQL
    └── markdown/                       # Archivos .md
```

## 🔧 Cambios Realizados

### Views
- `mensajes.html` → `views/mensajes.html`
- `mis-mensajes.html` → `views/mis-mensajes.html`
- `calendario-adviento.html` → `views/calendario-adviento.html`

### Assets
- CSS: `css/` → `assets/css/`
- JS: `js/` → `assets/js/` (organizado en subcarpetas)
- Imágenes: `img/` → `assets/images/`
- Audio: `audio/` → `assets/audio/`
- Data: `data/` → `assets/data/`

### JavaScript organizado por función:
- **Config**: `assets/js/config/supabase.js`
- **Models**: `assets/js/models/reaccionesModel.js`
- **Controllers**: `assets/js/controllers/` (mensajes, calendario, galería)
- **Services**: `assets/js/services/musicaService.js`
- **UI**: `assets/js/ui/` (cursor, darkMode, animations, arbol3d)

## 📝 Rutas Actualizadas

### Desde index.html (raíz):
```html
<link rel="stylesheet" href="assets/css/estilos.css">
<script src="assets/js/config/supabase.js"></script>
<a href="views/mensajes.html">Ver mensajes</a>
```

### Desde views/:
```html
<link rel="stylesheet" href="../assets/css/estilos.css">
<a href="../index.html">Volver</a>
```

## ✅ Compatible con GitHub Pages

- index.html en la raíz ✓
- Rutas relativas ✓
- Sin PHP ni backend ✓
