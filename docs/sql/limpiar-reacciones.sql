-- =====================================================
-- SCRIPT PARA LIMPIAR REACCIONES EN SUPABASE
-- =====================================================
-- Ejecuta estos comandos en el SQL Editor de Supabase
-- para limpiar/administrar las reacciones

-- 1. VER TODAS LAS REACCIONES ACTUALES
-- =====================================
SELECT 
    r.id,
    r.mensaje_id, 
    r.emoji, 
    r.session_id,
    r.created_at,
    m.contenido as mensaje_texto
FROM reacciones r
LEFT JOIN mensajes m ON r.mensaje_id = m.id
ORDER BY r.created_at DESC;

-- 2. CONTAR REACCIONES POR MENSAJE
-- ===============================
SELECT 
    r.mensaje_id,
    m.contenido as mensaje_texto,
    r.emoji,
    COUNT(*) as cantidad
FROM reacciones r
LEFT JOIN mensajes m ON r.mensaje_id = m.id
GROUP BY r.mensaje_id, m.contenido, r.emoji
ORDER BY r.mensaje_id, cantidad DESC;

-- 3. VER REACCIONES DE UNA SESIÓN ESPECÍFICA
-- ==========================================
-- Reemplaza 'TU_SESSION_ID_AQUI' por tu session_id real
SELECT * FROM reacciones 
WHERE session_id = 'TU_SESSION_ID_AQUI'
ORDER BY created_at DESC;

-- 4. ELIMINAR TODAS LAS REACCIONES (¡CUIDADO!)
-- ============================================
-- ⚠️ ESTO BORRARÁ TODAS LAS REACCIONES PERMANENTEMENTE
-- DELETE FROM reacciones;

-- 5. ELIMINAR REACCIONES DE UN MENSAJE ESPECÍFICO
-- ===============================================
-- Reemplaza 'MENSAJE_ID_AQUI' por el ID del mensaje
-- DELETE FROM reacciones 
-- WHERE mensaje_id = 'MENSAJE_ID_AQUI';

-- 6. ELIMINAR REACCIONES DE UNA SESIÓN ESPECÍFICA
-- ===============================================
-- Reemplaza 'TU_SESSION_ID_AQUI' por tu session_id real
-- DELETE FROM reacciones 
-- WHERE session_id = 'TU_SESSION_ID_AQUI';

-- 7. ELIMINAR SOLO REACCIONES DUPLICADAS (MANTENER UNA POR USUARIO)
-- =================================================================
-- Esto eliminará reacciones duplicadas de la misma sesión al mismo mensaje
DELETE FROM reacciones 
WHERE id NOT IN (
    SELECT DISTINCT ON (mensaje_id, session_id) id
    FROM reacciones
    ORDER BY mensaje_id, session_id, created_at DESC
);

-- 8. RESETEAR LA TABLA COMPLETA (ESTRUCTURA Y DATOS)
-- =================================================
-- ⚠️ ESTO BORRARÁ TODO Y REINICIARÁ LA TABLA
-- TRUNCATE reacciones RESTART IDENTITY;

-- 9. ESTADÍSTICAS RÁPIDAS
-- =======================
SELECT 
    COUNT(*) as total_reacciones,
    COUNT(DISTINCT mensaje_id) as mensajes_con_reacciones,
    COUNT(DISTINCT session_id) as usuarios_unicos,
    COUNT(DISTINCT emoji) as emojis_diferentes
FROM reacciones;

-- =====================================================
-- INSTRUCCIONES DE USO:
-- =====================================================
-- 1. Copia y pega las consultas que necesites en Supabase
-- 2. Para ver datos: usa las consultas SELECT (1-3, 9)
-- 3. Para eliminar: descomenta las líneas DELETE que necesites (4-8)
-- 4. ⚠️ Las operaciones DELETE son PERMANENTES - ten cuidado
-- 5. Siempre haz backup antes de eliminar datos importantes

-- COMANDO RÁPIDO PARA ELIMINAR TODO:
-- DELETE FROM reacciones;

-- COMANDO PARA VER TU SESSION_ID ACTUAL:
-- Revisa localStorage en el navegador o los logs de consola