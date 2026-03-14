# 📸 Galería Personalizable

## ✨ Características

La galería de fotos ahora es **100% personalizable**. Tanto tú como Rocío pueden agregar, ver y eliminar fotos fácilmente.

---

## 🎯 Funcionalidades

### **1. Ver Galería** 📸
- Click en el botón **"Galería"** (abajo izquierda)
- Navega entre fotos con las flechas ← →
- Click en thumbnails para ir a una foto específica
- Cierra con el botón ✖️ o haciendo click fuera

### **2. Agregar Nuevas Fotos** ➕
1. Click en el botón **verde "+"** (abajo izquierda, debajo de Galería)
2. Se abre un formulario con:
   - **Selector de archivo**: Sube tu imagen (JPG, PNG, etc.)
   - **Vista previa**: Ve cómo se verá antes de guardar
   - **Título**: Nombre de la foto (máx. 50 caracteres)
   - **Fecha**: Cuándo fue tomada (máx. 30 caracteres)
   - **Descripción**: Un texto especial (máx. 150 caracteres)
3. Click en **"💾 Guardar Foto"**
4. ¡Listo! La foto aparece en la galería

### **3. Eliminar Fotos** 🗑️
- Solo puedes eliminar **fotos personalizadas** (las que agregaste)
- Las 4 fotos originales **NO** se pueden eliminar
- Para eliminar:
  1. Abre la galería
  2. Ve a la foto que quieres eliminar
  3. Click en **"🗑️ Eliminar"** (aparece abajo)
  4. Confirma la acción
  5. La foto se elimina permanentemente

---

## 💾 Almacenamiento

- Las fotos se guardan en **localStorage** del navegador
- Se convierten a **Base64** (no necesitas subir archivos al servidor)
- Son **persistentes**: permanecen aunque recargues la página
- **Límite**: ~5-10 MB total (depende del navegador)

---

## 🎨 Tipos de Fotos

### **Fotos Base** (4 originales)
```javascript
- galeria/foto1.jpg - "Nuestro Primer Momento"
- galeria/foto2.jpg - "Juntos"
- galeria/foto3.jpg - "Felicidad"
- galeria/foto4.jpg - "Amor"
```
- **NO se pueden eliminar**
- Son las fotos originales del proyecto

### **Fotos Personalizadas**
- Agregadas por ti o Rocío
- **SÍ se pueden eliminar**
- Guardadas en localStorage
- Se muestran después de las fotos base

---

## 🔧 Ejemplo de Uso

```javascript
// Estructura de una foto personalizada en localStorage:
{
    "src": "data:image/jpeg;base64,...", // Imagen en Base64
    "titulo": "Nuestra Primera Cita",
    "fecha": "15 de octubre, 2025",
    "descripcion": "El día que lo cambió todo 💕",
    "tipo": "personalizada",
    "id": 1699567890123 // Timestamp único
}
```

---

## 🎨 Botones en la Interfaz

| Botón | Posición | Función |
|-------|----------|---------|
| 📸 **Galería** | Abajo izquierda | Abre el visor de fotos |
| ➕ **Agregar** | Abajo izquierda (debajo) | Abre formulario de nueva foto |
| 🗑️ **Eliminar** | Dentro del visor | Elimina foto actual (solo personalizadas) |

---

## 📱 Responsive

✅ Funciona en **móviles, tablets y escritorio**
✅ Vista previa adaptativa
✅ Formulario optimizado para touch
✅ Drag & drop de imágenes

---

## 🌙 Modo Oscuro

✅ Formulario adaptado a modo oscuro
✅ Botones con colores ajustados
✅ Alta legibilidad en ambos modos

---

## ⚠️ Limitaciones

1. **Tamaño de archivos**: Recomendado < 2 MB por foto
2. **Total de fotos**: Limitado por espacio del navegador (~5-10 MB)
3. **Formatos**: JPG, PNG, GIF, WebP
4. **No sincronización**: Las fotos se guardan localmente en cada navegador

---

## 💡 Consejos

1. **Optimiza tus fotos** antes de subirlas (reducir resolución)
2. **Usa títulos descriptivos** para recordar cada momento
3. **Fecha clara**: "Octubre 2025" o "15 de octubre, 2025"
4. **Descripciones emotivas**: Hazlas especiales 💕

---

## 🎉 Resultado

Ahora tienes una galería romántica donde:
- ✅ Ambos pueden agregar fotos
- ✅ Las fotos se guardan automáticamente
- ✅ Control total sobre fotos personalizadas
- ✅ Interfaz hermosa y fácil de usar
- ✅ Compatible con modo oscuro

¡Disfruten agregando sus momentos especiales! 📸💕
