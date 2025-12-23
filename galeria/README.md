# 📸 Galería de Fotos

## Instrucciones

Esta carpeta debe contener las fotos de tu relación con Rocío. 

### Archivos necesarios:

1. **foto1.jpg** - Primera foto importante
2. **foto2.jpg** - Segunda foto importante
3. **foto3.jpg** - Tercera foto importante
4. **foto4.jpg** - Cuarta foto importante

### Recomendaciones:

- **Formato**: JPG o PNG
- **Resolución**: 1920x1080 o similar (no más de 2MB por foto)
- **Contenido**: Fotos juntos, momentos especiales, selfies románticas
- **Nombres**: Mantén los nombres `foto1.jpg`, `foto2.jpg`, etc. para que funcione automáticamente

### Personalizar:

Si quieres agregar más fotos o cambiar los títulos/descripciones, edita el archivo:
**`js/galeria.js`** (líneas 4-29)

```javascript
this.fotos = [
    {
        src: 'galeria/foto1.jpg',
        titulo: 'Nuestro Primer Momento',
        fecha: '8 de octubre, 2025',
        descripcion: 'El día que todo comenzó 💕'
    },
    // ... agregar más fotos aquí
];
```

### Placeholder:

Si aún no tienes fotos listas, la galería mostrará un ícono de placeholder automáticamente.

---

**Nota**: No subas fotos privadas a repositorios públicos. Usa este sistema solo en tu servidor local o hosting privado.
