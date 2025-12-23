# 🖱️ Guía de Efectos de Cursor - NuestroMes

## ✨ Descripción

Los efectos de cursor personalizados añaden una capa extra de magia e interactividad a la página, haciendo que cada movimiento del mouse sea una experiencia romántica.

---

## 🎨 Tipos de Partículas

### 1. 💕 Corazones (Heart)
- **Variedad**: 8 emojis diferentes (💕, 💖, 💗, 💝, 💘, ❤️, 💙, 💜)
- **Tamaño**: Aleatorio entre 8-16px
- **Animación**: Flotan hacia arriba con rotación
- **Duración**: ~1 segundo
- **Uso**: Movimiento general del cursor

### 2. ✨ Chispas (Sparkle)
- **Apariencia**: Puntos dorados brillantes
- **Tamaño**: 4px
- **Efecto**: Resplandor dorado
- **Animación**: Flotación rápida vertical
- **Duración**: ~0.8 segundos

### 3. 🫧 Burbujas (Bubble)
- **Apariencia**: Esferas translúcidas rosa-blanco
- **Tamaño**: 8px
- **Efecto**: Gradiente interno + borde sutil
- **Animación**: Crecen mientras flotan
- **Duración**: ~1.2 segundos

### 4. ⭐ Estrellas (Star)
- **Símbolo**: ✨
- **Color**: Dorado
- **Animación**: Rotan 180° mientras ascienden
- **Duración**: ~1 segundo

---

## 🖱️ Cursor Personalizado (Desktop)

### Características:
- **Diseño**: Anillo circular rosa con borde rojo
- **Tamaño**: 20x20px
- **Efectos**:
  - `mix-blend-mode: difference` (contraste con fondo)
  - Sombra brillante rosa
  - Transición suave (0.1s)

### Estados:
- **Normal**: Anillo rosa translúcido
- **Clicking**: Se reduce (scale 0.8) y se vuelve rojo sólido

### Compatibilidad:
- ✓ Solo en desktop (hover: hover)
- ✗ Oculto en dispositivos táctiles
- ✗ Desactivado con `prefers-reduced-motion`

---

## 🎯 Eventos Interactivos

### 1. **Movimiento del cursor** (`mousemove`)
- **Probabilidad**: 70% por frame
- **Efecto**: Crea 1 partícula aleatoria
- **Posición**: Exacta del cursor

### 2. **Click** (`mousedown`)
- **Efecto**: Ráfaga de 5 partículas
- **Distribución**: Radial (±20px del centro)
- **Timing**: Escalonado (50ms entre cada una)
- **Extra**: Onda expansiva (ripple)

### 3. **Hover en Categorías** (`.categoria-card`)
- **Efecto**: 3 corazones en ráfaga
- **Posición**: Centro de la tarjeta ±30px
- **Timing**: 100ms entre cada corazón

### 4. **Hover en Mensajes** (`.mensaje-card`)
- **Efecto**: 2 partículas suaves
- **Posición**: Aleatoria dentro de la tarjeta
- **Timing**: 150ms entre cada una

### 5. **Click en Botones** (`.btn-*`)
- **Efecto**: Explosión circular de 8 partículas
- **Distribución**: 360° dividido en 8 ángulos
- **Radio**: 30px desde el centro
- **Timing**: 50ms entre cada partícula

### 6. **Touch en Móvil** (`touchmove`, `touchstart`)
- **`touchmove`**: 1 partícula por movimiento
- **`touchstart`**: Ráfaga de 3 partículas
- **Timing**: 30ms entre cada una

---

## 🎭 Animaciones CSS

### `particleFloat` (General)
```css
0% → 100%:
- translateY: 0 → -80px
- translateX: 0 → var(--random-x)
- scale: 1 → 0.3
- opacity: 1 → 0
```

### `particleFloatHeart` (Corazones)
```css
0% → 50% → 100%:
- translateY: 0 → -40px → -100px
- scale: 1 → 1.2 → 0.5
- rotate: 0deg → 15deg → 30deg
```

### `sparkleFloat` (Chispas)
```css
0% → 100%:
- translateY: 0 → -60px
- scale: 1 → 0.2
```

### `bubbleFloat` (Burbujas)
```css
0% → 50% → 100%:
- translateY: 0 → -40px → -90px
- scale: 0.5 → 1 → 1.5
```

### `starFloat` (Estrellas)
```css
0% → 100%:
- translateY: 0 → -70px
- rotate: 0deg → 180deg
- scale: 1 → 0.3
```

### `rippleEffect` (Ondas al click)
```css
0% → 100%:
- width/height: 0 → 300px
- opacity: 0.8 → 0
- transform: translate(-150px, -150px)
```

---

## ⚡ Optimización

### Gestión de Memoria
- **Limpieza automática**: Las partículas se eliminan del DOM al terminar su animación
- **Seguimiento**: Array `particles[]` con `birthTime` y `duration`
- **Loop de limpieza**: `requestAnimationFrame()` verifica partículas viejas

### Rendimiento
- **Probabilidad controlada**: 70% en movimiento normal (evita saturación)
- **Throttling táctil**: Solo 1 partícula por evento táctil
- **CSS `will-change`**: No usado (solo en elementos hover)

### Prevención de Problemas
```javascript
// Prevenir selección de texto
document.addEventListener('selectstart', (e) => e.preventDefault());

// Prevenir arrastre
document.addEventListener('dragstart', (e) => e.preventDefault());
```

---

## 📱 Responsive

### Desktop (hover: hover)
- ✓ Cursor personalizado visible
- ✓ Todas las partículas activas
- ✓ Efectos hover completos

### Móvil (max-width: 768px)
- ✗ Cursor personalizado oculto (`display: none`)
- ✓ Partículas táctiles activas
- ✓ Eventos `touchmove` y `touchstart`
- ✓ Cursor predeterminado del sistema

### Accesibilidad (prefers-reduced-motion)
- ✗ Cursor personalizado desactivado
- ✗ Partículas desactivadas (`display: none`)
- ✗ Ripple instantáneo (sin animación)

---

## 🔧 Configuración

### Ajustar probabilidad de partículas:
```javascript
// En mousemove event (línea ~54)
if (Math.random() < 0.7) { // Cambiar 0.7 (70%)
    this.createParticle(this.mouseX, this.mouseY);
}
```

### Cambiar tipos de partículas:
```javascript
// En createParticle() (línea ~93)
const types = ['heart', 'sparkle', 'bubble', 'star'];
// Quitar tipos: ['heart', 'sparkle'] (solo corazones y chispas)
```

### Modificar corazones disponibles:
```javascript
// En createParticle() (línea ~100)
const hearts = ['💕', '💖', '💗', '💝', '💘', '❤️', '💙', '💜'];
// Agregar/quitar emojis según preferencia
```

### Ajustar duración de animaciones:
```javascript
// En createParticle() (línea ~111)
const randomDuration = 800 + Math.random() * 400;
// Base: 800ms, Variación: 400ms (total: 800-1200ms)
```

---

## 🐛 Solución de Problemas

### Problema: Muchas partículas (lag)
**Solución**: Reducir probabilidad en `mousemove`
```javascript
if (Math.random() < 0.3) { // De 0.7 a 0.3
```

### Problema: Cursor no se ve
**Verificar**:
1. Estás en desktop (no móvil)
2. JavaScript está habilitado
3. `.custom-cursor` no tiene `display: none`

### Problema: Partículas no desaparecen
**Verificar**:
1. Consola para errores de JavaScript
2. Método `animate()` se está ejecutando
3. `setTimeout` está funcionando

### Problema: Conflicto con otros scripts
**Solución**: Verificar orden de carga
```html
<script src="js/efectos.js"></script>
<script src="js/cursorEffects.js"></script> <!-- Cargar después -->
```

---

## 💡 Ideas de Expansión

### Agregar más tipos de partículas:
```javascript
// En createParticle()
const types = ['heart', 'sparkle', 'bubble', 'star', 'rose', 'ring'];

if (randomType === 'rose') {
    particle.textContent = '🌹';
}
if (randomType === 'ring') {
    particle.textContent = '💍';
}
```

### Partículas según categoría:
```javascript
// Detectar categoría actual
const url = window.location.href;
if (url.includes('categoria=feliz')) {
    particle.textContent = '😄'; // Solo emojis felices
}
```

### Cambiar color según hora del día:
```javascript
const hora = new Date().getHours();
if (hora >= 18 || hora <= 6) {
    // Partículas azules/moradas para la noche
    particle.style.filter = 'hue-rotate(180deg)';
}
```

---

## 📊 Métricas de Impacto

| Métrica | Valor |
|---------|-------|
| Tamaño archivo | ~8 KB |
| Clases CSS | 15 |
| Animaciones CSS | 6 |
| Eventos detectados | 6 |
| Tipos de partículas | 4 |
| Máx. partículas simultáneas | ~50-100 |

---

## ✅ Checklist de Integración

- [x] Archivo `cursorEffects.js` en `/js/`
- [x] Estilos CSS agregados en `estilos.css`
- [x] Script cargado en `index.php`
- [x] Script cargado en `mensajes.php`
- [x] Contenedor `#cursor-particles` agregado
- [x] Eventos integrados con elementos del proyecto
- [x] Probado en desktop
- [x] Probado en móvil
- [x] Compatible con `prefers-reduced-motion`

---

**Efectos de cursor creados con 💕 para Rocío**

*Última actualización: 5 de noviembre, 2025*
