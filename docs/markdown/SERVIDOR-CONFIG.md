# 🚀 Configuración Rama SERVIDOR

## 📌 Propósito de esta Rama

Esta rama está configurada específicamente para:
- ✅ **GitHub Pages** - Hosting público en `https://leolpa000.github.io/NuestroMes/`
- ✅ **Supabase** - Base de datos y Storage en la nube
- ✅ **Sin localStorage** - Todo se guarda en Supabase (sin fallback local)

## 🔧 Diferencias con la Rama `main`

| Característica | Rama `main` | Rama `servidor` |
|----------------|-------------|-----------------|
| **Servidor local** | ✅ XAMPP/localhost | ❌ No necesario |
| **GitHub Pages** | ❌ | ✅ Optimizado |
| **Supabase** | ⚠️ Opcional (fallback) | ✅ Obligatorio |
| **localStorage** | ✅ Fallback activo | ❌ Deshabilitado |
| **Archivos PHP** | ✅ Funcionales | ⚠️ Solo referencia |
| **Archivos HTML** | ✅ Principal | ✅ Principal |

## 📋 Checklist de Configuración

### ✅ Paso 1: Verificar Supabase
- [ ] Tabla `canciones` creada
- [ ] Tabla `fotos` creada
- [ ] Tabla `mensajes` creada
- [ ] Bucket `archivos` creado (público)
- [ ] Políticas RLS configuradas
- [ ] Políticas Storage configuradas

### ✅ Paso 2: Archivos Configurados
- [x] `index.html` - Página principal
- [x] `mensajes.html` - Mensajes por categoría
- [x] `mis-mensajes.html` - Mensajes personalizados
- [x] `js/supabaseConfig.js` - Configuración de Supabase
- [x] `js/musica.js` - Reproductor sin fallback a localStorage
- [x] `js/galeria.js` - Galería sin fallback a localStorage

### ✅ Paso 3: Deploy a GitHub Pages
- [ ] Commit de cambios
- [ ] Push a rama `servidor`
- [ ] Configurar GitHub Pages para usar rama `servidor`
- [ ] Verificar que funcione en `https://leolpa000.github.io/NuestroMes/`

## 🔒 Seguridad

⚠️ **IMPORTANTE:** Esta configuración usa políticas RLS abiertas (anon).

Para producción real, considera:
1. Implementar autenticación con Supabase Auth
2. Restringir políticas RLS a usuarios autenticados
3. No compartir la URL públicamente
4. Monitorear uso de Supabase regularmente

## 📊 Monitoreo

### Verificar Estado de Supabase
```javascript
// Abrir consola (F12) en el sitio y ejecutar:
console.log('Cliente Supabase:', !!window.supabaseClient);

// Listar canciones
const { data: canciones } = await window.supabaseClient.from('canciones').select('*');
console.log('Canciones:', canciones);

// Listar fotos
const { data: fotos } = await window.supabaseClient.from('fotos').select('*');
console.log('Fotos:', fotos);
```

## 🛠️ Comandos Git Útiles

### Cambiar a rama servidor
```bash
git checkout servidor
```

### Ver diferencias con main
```bash
git diff main servidor
```

### Hacer cambios solo en servidor
```bash
git checkout servidor
# hacer cambios
git add .
git commit -m "Descripción del cambio"
git push origin servidor
```

### Volver a main
```bash
git checkout main
```

## 🚨 Solución de Problemas

### Problema: "Foto guardada localmente"
**Causa:** Supabase no está funcionando
**Solución:**
1. Abre consola (F12)
2. Busca errores en rojo
3. Verifica que `window.supabaseClient` exista
4. Revisa políticas en Supabase Dashboard

### Problema: "new row violates row-level security"
**Causa:** Políticas RLS no configuradas
**Solución:** Ejecuta `supabase-setup.sql` en Supabase Dashboard

### Problema: SDK de Supabase no carga
**Causa:** URL del CDN incorrecta o bloqueada
**Solución:** Verifica que uses HTTPS y que el CDN sea accesible

## 📝 Próximos Pasos

1. ✅ Ejecutar SQL setup en Supabase
2. ✅ Configurar políticas de Storage
3. ✅ Hacer commit y push de cambios
4. ✅ Configurar GitHub Pages
5. ✅ Probar en producción
6. ✅ Agregar contenido (fotos/música)

---

**Última actualización:** 6 de noviembre de 2025
**Rama actual:** `servidor`
**Estado:** Configuración en progreso
