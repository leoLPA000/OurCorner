# 🎵 Música Navideña - Instrucciones

## Archivos de Música Necesarios

Para que el calendario de adviento funcione con música navideña, necesitas agregar archivos de audio en la carpeta `audio/navidad/`.

### Archivo Principal
- **Nombre**: `jingle-bells.mp3` (o cualquier canción navideña)
- **Formato**: MP3, OGG, WAV o M4A
- **Ubicación**: `audio/navidad/jingle-bells.mp3`

## Cómo Agregar Música

### Opción 1: Descargar Música Libre de Derechos
Puedes descargar música navideña gratuita y libre de derechos de:
- **YouTube Audio Library**: https://studio.youtube.com/channel/UC/music
- **Free Music Archive**: https://freemusicarchive.org/
- **Incompetech**: https://incompetech.com/music/
- **Bensound**: https://www.bensound.com/

### Opción 2: Usar Tu Propia Música
1. Selecciona tu canción navideña favorita
2. Conviértela a MP3 si es necesario
3. Renómbrala a `jingle-bells.mp3`
4. Cópiala a la carpeta `audio/navidad/`

## Canciones Navideñas Sugeridas

- Jingle Bells
- Silent Night (Noche de Paz)
- Deck the Halls
- We Wish You a Merry Christmas
- O Christmas Tree
- Joy to the World
- The First Noel

## Cambiar la Canción en el Código

Si quieres usar un nombre de archivo diferente, edita `calendario-adviento.html` línea 64:

```html
<source src="audio/navidad/TU_CANCION.mp3" type="audio/mpeg">
```

## Múltiples Canciones (Opcional)

Si quieres agregar más canciones, puedes modificar el JavaScript para crear una playlist navideña:

1. Agrega varios archivos MP3 en `audio/navidad/`
2. Modifica `js/calendario.js` para incluir un array de canciones
3. Implementa lógica de siguiente/anterior canción

## Notas Importantes

- ⚠️ **Tamaño**: Mantén los archivos de audio por debajo de 10MB para carga rápida
- ⚠️ **Derechos**: Asegúrate de tener permiso para usar la música
- ✅ **Formato**: MP3 es el más compatible con todos los navegadores
- ✅ **Volumen**: Ajusta el volumen de la canción antes de subirla

## Estado Actual

📁 Carpeta creada: `audio/navidad/`
❌ Archivo de música: **PENDIENTE** - Debes agregar `jingle-bells.mp3` manualmente

Una vez que agregues el archivo de música, el reproductor funcionará automáticamente en el calendario de adviento.
