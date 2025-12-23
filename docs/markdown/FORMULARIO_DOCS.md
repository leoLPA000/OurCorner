# 📝 Formulario de Nuevos Mensajes - Documentación Completa

## ✨ ¿Qué es?

El **Formulario de Nuevos Mensajes** es una funcionalidad interactiva que permite a Rocío (o cualquier usuario) crear y guardar sus propios mensajes románticos personalizados. Los mensajes se guardan en el navegador usando `localStorage`, por lo que persisten entre sesiones.

---

## 🎯 Características Principales

### 1. **Formulario Completo**
- ✅ **Selección de categoría**: Elige entre 6 categorías emocionales
- ✅ **Selector de emoji**: 15 emojis románticos para elegir
- ✅ **Área de texto**: Hasta 500 caracteres con contador en tiempo real
- ✅ **Nota especial**: Campo opcional para contexto adicional
- ✅ **Firma personalizada**: Campo para el nombre del autor (pre-rellenado con "Rocío")

### 2. **Vista Previa en Vivo**
- ✅ Ver cómo se verá el mensaje antes de guardarlo
- ✅ Preview estilizado con el diseño de la web
- ✅ Muestra todos los campos: emoji, texto, nota y firma

### 3. **Gestión de Mensajes**
- ✅ Lista de todos los mensajes guardados dentro del modal
- ✅ Cada mensaje muestra: emoji, categoría, texto, nota, autor y fecha
- ✅ Botón para eliminar mensajes (con confirmación)
- ✅ Contador de mensajes guardados

### 4. **Página Dedicada: "Mis Mensajes"**
- ✅ Página especial en `mis-mensajes.php` para ver todos los mensajes
- ✅ Filtro por categoría
- ✅ Diseño elegante con badges y fechas
- ✅ Botón de eliminación por mensaje
- ✅ Mensaje vacío cuando no hay mensajes

### 5. **Notificaciones Toast**
- ✅ Notificaciones elegantes al guardar/eliminar
- ✅ 4 tipos: éxito, error, advertencia, info
- ✅ Auto-desaparecen después de 3 segundos
- ✅ Animación suave de entrada/salida

### 6. **Explosión de Corazones**
- ✅ Animación especial al guardar un mensaje exitosamente
- ✅ 15 corazones que explotan desde el centro
- ✅ Diferentes colores: ❤️💕💖💝

---

## 🎨 Interfaz de Usuario

### Botón de Acceso
- **Ubicación**: Esquina superior derecha (debajo del toggle de modo oscuro)
- **Icono**: ✍️
- **Texto**: "Agregar Mensaje"
- **Color**: Gradiente rosa-morado (#ff6b9d → #8e44ad)

### Modal del Formulario
- **Tamaño**: 700px de ancho máximo
- **Altura**: 90vh máximo con scroll
- **Fondo**: Overlay oscuro con blur
- **Estilo**: Bordes redondeados (30px), sombras elegantes
- **Responsive**: Adaptado para móvil

### Botón "Mis Mensajes"
- **Ubicación**: Entre las categorías y el footer en index.php
- **Muestra**: Cantidad de mensajes guardados
- **Enlace**: Va a `mis-mensajes.php`

---

## 💾 Almacenamiento de Datos

### localStorage
Los mensajes se guardan en el navegador con la estructura:

```javascript
[
    {
        id: 1699999999999,              // Timestamp único
        categoria: "amor",              // feliz|triste|enojada|amor|nostalgia|motivacion
        emoji: "❤️",                    // Emoji elegido
        texto: "Tu mensaje aquí...",    // Contenido del mensaje
        nota: "Nota opcional",          // Contexto adicional (opcional)
        autor: "Rocío",                 // Nombre del autor
        fecha: "5 de noviembre, 2025"   // Fecha de creación
    },
    // ... más mensajes
]
```

### Persistencia
- ✅ Los mensajes **NO se pierden** al cerrar el navegador
- ✅ Los mensajes **SON específicos** de este dominio/localhost
- ✅ Los mensajes **SE PIERDEN** si se borra el historial del navegador
- ⚠️ Los mensajes **NO se sincronizan** entre dispositivos (solo local)

---

## 🔧 Archivos Creados/Modificados

### Nuevos Archivos:
1. **`js/formulario.js`** (450 líneas)
   - Clase `FormularioMensajes`
   - Gestión completa del formulario
   - CRUD de mensajes en localStorage
   - Notificaciones y animaciones

2. **`mis-mensajes.php`** (300 líneas)
   - Página dedicada para ver mensajes
   - Filtro por categoría
   - Eliminar mensajes
   - Diseño responsive

### Archivos Modificados:
1. **`css/estilos.css`** (+800 líneas)
   - Estilos del formulario
   - Estilos del modal
   - Notificaciones toast
   - Animación de explosión
   - Responsive completo

2. **`index.php`**
   - Agregado script `formulario.js`
   - Botón "Mis Mensajes" con contador
   - JavaScript para actualizar contador

3. **`mensajes.php`**
   - Agregado script `formulario.js`

---

## 🎮 Cómo Usar

### Para Crear un Mensaje:

1. **Clic en el botón "✍️ Agregar Mensaje"** (esquina superior derecha)

2. **Llenar el formulario:**
   - Elegir una categoría (requerido)
   - Elegir un emoji (opcional, por defecto ❤️)
   - Escribir el mensaje (requerido, máx 500 caracteres)
   - Agregar una nota (opcional)
   - Confirmar/cambiar firma (por defecto "Rocío")

3. **Opciones:**
   - **👁️ Vista Previa**: Ver cómo se verá antes de guardar
   - **💾 Guardar Mensaje**: Guardar el mensaje

4. **Confirmación:**
   - Notificación de éxito: "¡Mensaje guardado con éxito! 💕"
   - Explosión de corazones animada
   - El mensaje aparece en la lista de guardados

### Para Ver Mensajes Guardados:

**Opción 1: Dentro del Modal**
- Los mensajes aparecen automáticamente en la sección "Tus Mensajes Guardados"
- Scroll para ver más
- Clic en 🗑️ para eliminar

**Opción 2: Página Dedicada**
- Clic en el botón "Mis Mensajes" en la página principal
- Filtrar por categoría con el selector
- Ver todos los detalles de cada mensaje
- Eliminar con el botón "🗑️ Eliminar"

### Para Eliminar un Mensaje:
1. Clic en el botón 🗑️ (en el modal o en la página dedicada)
2. Confirmar en el diálogo que aparece
3. El mensaje se elimina permanentemente

---

## 📱 Responsive

### Desktop (>768px):
- Botón "Agregar Mensaje" con texto completo
- Modal de 700px de ancho
- Dos columnas en el formulario (donde aplique)
- Notificaciones en la esquina superior derecha

### Tablet (481-768px):
- Botón sin texto (solo icono ✍️)
- Modal más estrecho
- Formulario a una columna
- Notificaciones adaptadas

### Móvil (<480px):
- Botón compacto
- Modal fullscreen con padding reducido
- Formulario en columna única
- Botones apilados verticalmente

---

## 🎨 Temas

### Modo Claro:
- Fondo blanco/rosa suave
- Bordes rosa claro
- Texto gris oscuro
- Acentos rojos y morados

### Modo Oscuro:
- Fondo azul oscuro (#16213e)
- Bordes morados oscuros
- Texto blanco suave
- Acentos rosa brillante (#ff6b9d)

**Todos los elementos se adaptan automáticamente al cambiar de tema.**

---

## ⚙️ Funciones JavaScript Principales

### Clase `FormularioMensajes`:

```javascript
// Inicialización
constructor()
init()
crearBotonFormulario()
crearModal()
bindEventos()

// Navegación
abrirFormulario()
cerrarFormulario()

// Vista Previa
mostrarVistaPrevia()
ocultarVistaPrevia()

// CRUD
guardarMensaje(e)
cargarMensajesGuardados()
eliminarMensaje(id)

// UI/UX
mostrarNotificacion(mensaje, tipo)
crearExplosionExito()
getCategoriaTexto(categoria)
```

---

## 🔒 Seguridad y Privacidad

### ✅ Seguro:
- Los mensajes se guardan **solo en tu navegador**
- **No se envían a ningún servidor**
- **No se comparten** con nadie automáticamente
- Cada navegador/dispositivo tiene su propia copia

### ⚠️ Consideraciones:
- Si borras el historial del navegador, **pierdes los mensajes**
- En modo incógnito, los mensajes **se borran al cerrar**
- Si usas otro dispositivo, **no verás los mensajes** (no hay sincronización)
- Si alguien usa tu computadora, **puede ver los mensajes**

### 💡 Consejo:
Si quieres hacer backup de tus mensajes:
1. Abre la consola del navegador (F12)
2. Escribe: `localStorage.getItem('mensajesPersonalizados')`
3. Copia el texto y guárdalo en un archivo .txt

Para restaurar:
1. Abre la consola
2. Escribe: `localStorage.setItem('mensajesPersonalizados', 'PEGA_AQUI_TU_BACKUP')`

---

## 🎯 Casos de Uso

### 1. **Responder a Leo**
Rocío puede escribir sus propios mensajes de amor para Leo y guardarlos en la web.

### 2. **Diario Emocional**
Usar la web como un diario privado, escribiendo mensajes según el estado de ánimo.

### 3. **Colección de Frases**
Guardar frases favoritas, citas inspiradoras o pensamientos personales.

### 4. **Mensajes Futuros**
Escribir mensajes para leer en fechas futuras importantes.

---

## 🐛 Solución de Problemas

### Problema: El botón no aparece
- **Solución**: Verifica que `js/formulario.js` esté cargado en el HTML
- **Consola**: Busca errores en F12 → Console

### Problema: Los mensajes no se guardan
- **Solución**: Verifica que localStorage esté habilitado
- **Prueba**: Abre consola y escribe `localStorage.setItem('test', '123')`

### Problema: Los mensajes desaparecieron
- **Causa**: Se borró el historial del navegador
- **Solución**: No hay forma de recuperarlos (hacer backups periódicos)

### Problema: Notificaciones no aparecen
- **Solución**: Revisa la consola (F12) para ver errores
- **Verificar**: Que los estilos CSS se hayan cargado correctamente

---

## 📊 Estadísticas

```
Líneas de código JavaScript:  ~450
Líneas de código CSS:         ~800
Líneas de código PHP:         ~300
Total funcionalidades:        6 principales
Campos del formulario:        5
Tipos de notificaciones:      4
Animaciones únicas:           3
Categorías soportadas:        6
Emojis disponibles:           15
Límite de caracteres:         500
```

---

## 🎉 Próximas Mejoras Opcionales

- [ ] Exportar mensajes a PDF
- [ ] Sincronizar entre dispositivos (requiere backend)
- [ ] Agregar imágenes a los mensajes
- [ ] Recordatorios para leer mensajes
- [ ] Compartir mensajes por redes sociales
- [ ] Estadísticas de mensajes (por categoría, por fecha)
- [ ] Búsqueda de mensajes por palabras clave

---

**¡Disfruta creando tus propios mensajes románticos! 💕✍️**
