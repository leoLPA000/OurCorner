# 🚀 Guía: Ejecutar Limpieza en Supabase

**Documento de Referencia Rápida para ejecutar la limpieza de IP Tracking**

---

## ⚠️ ANTES DE EMPEZAR

### 1️⃣ HACER BACKUP (CRÍTICO)

Entra en tu **Supabase Dashboard**:
1. Ve a **Database** → **Backups**
2. Click en **Request new backup**
3. Espera a que se complete (aparecerá en la lista)

```
✅ Solo continúa después de verificar que el backup se creó
```

---

## 📋 Pasos para Ejecutar la Limpieza

### 2️⃣ ABRIR SQL EDITOR

En tu **Supabase Dashboard**:
1. Ve a **SQL Editor** (lado izquierdo)
2. Click en **New Query** (botón azul)

### 3️⃣ COPIAR EL SCRIPT

Copia TODO el contenido del archivo:
```
docs/sql/CLEANUP-VISITOR-LOGS-AUTO.sql
```

### 4️⃣ PEGAR EN SUPABASE

En la ventana de SQL Editor:
1. Limpia cualquier contenido anterior
2. Pega TODO el script
3. Verifica que se vea así (sin errores de sintaxis):

```sql
-- 🧹 SCRIPT DE LIMPIEZA AUTOMÁTICA - SUPABASE
-- ... contenido completo ...
RAISE NOTICE '✅ Limpieza de IP tracking completada exitosamente';
```

### 5️⃣ EJECUTAR

1. Click en el botón **▶ Run** (esquina superior derecha)
2. Espera unos segundos

### 6️⃣ VERIFICAR RESULTADO

Deberías ver en la sección **Messages** (abajo):

```
✅ Limpieza de IP tracking completada exitosamente
✅ VERIFICACIÓN: La tabla visitor_logs ha sido eliminada correctamente
```

Si ves errores como:
```
Error: relation "visitor_logs" does not exist
```

Es NORMAL si ya fue eliminada. Continúa al siguiente paso.

---

## ✅ VERIFICACIÓN FINAL

En el mismo **SQL Editor**, crea una **New Query** y ejecuta:

```sql
-- Verificar que la tabla NO existe
SELECT * FROM information_schema.tables 
WHERE table_name = 'visitor_logs';
```

**Resultado esperado:**
```
(0 rows)
```

Si obtienes este resultado, ¡la limpieza fue exitosa! ✅

---

## 🔍 ALTERNATIVA: Verificación Manual

Si quieres revisar qué se eliminó, ejecuta estas consultas:

```sql
-- Ver todas las tablas
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'public' 
ORDER BY table_name;

-- Ver todas las funciones
SELECT routine_name FROM information_schema.routines 
WHERE routine_schema = 'public' AND routine_type = 'FUNCTION';
```

**Deberías NOT VER:**
- Tabla: `visitor_logs`
- Funciones: `get_visitor_stats`, `count_visitor_logs`, etc.

---

## 💡 TIPS Y TROUBLESHOOTING

### ❓ "¿Qué pasa si algo falla?"

No te preocupes, el script tiene validaciones:
1. Verifica que la tabla exista ANTES de eliminar
2. Si algo falla, tienes tu **backup** listo
2. Puedes restaurar desde el backup

### ❓ "¿Necesito hacer algo más?"

Después de ejecutar el script:
- ✅ Actualizar BD a producción (si es necesario)
- ✅ Hacer deploy de la rama de limpieza
- ✅ Opcional: Eliminar archivos de backup SQL si no los usas

### ❓ "¿Qué son los RAISE NOTICE?"

Son mensajes informativos que Supabase muestra en la consola:
```
RAISE NOTICE 'Este es un mensaje de info'
```

No son errores, son confirmaciones del progreso.

---

## 📊 Resumen de lo que se Elimina

| Tipo | Elemento | Acción |
|------|----------|--------|
| Tabla | `visitor_logs` | ❌ Eliminar |
| Policies | 6 RLS Policies | ❌ Eliminar |
| Funciones | 4 funciones | ❌ Eliminar |
| Vistas | Vistas de resumen | ❌ Eliminar |
| Índices | 4 índices | ❌ Eliminar |

---

## 🎯 Checklista Final

- [ ] Hice backup de la BD
- [ ] Copié el script completo
- [ ] Pegué en SQL Editor
- [ ] Ejecuté el script (botón Run)
- [ ] Vi mensajes de ✅ Completado
- [ ] Verifiqué que `visitor_logs` no existe
- [ ] Actualicé la BD en producción (si es necesario)

---

## 🆘 Si Algo Salió Mal

1. **Entra en Supabase → Database → Backups**
2. **Click en el backup más reciente**
3. **Click en "Restore"**
4. **Espera a que se complete**

Tu BD volverá al estado anterior automáticamente.

---

## ✨ Listo!

Una vez completado, tu proyecto estará:
- ✅ Libre de IP tracking
- ✅ Libre de geolocalización
- ✅ Más limpio y mantenible
- ✅ Más respetuoso con la privacidad

¿Preguntas? Revisa la documentación completa en: [CLEANUP-SUMMARY.md](CLEANUP-SUMMARY.md)
