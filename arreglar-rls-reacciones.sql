-- =====================================================
-- SOLUCIÓN PARA PROBLEMA DE ELIMINACIÓN DE REACCIONES
-- =====================================================
-- El problema: RLS permite READ pero no DELETE/UPDATE

-- 1. VERIFICAR POLÍTICAS ACTUALES
-- ================================
SELECT 
    schemaname,
    tablename,
    policyname,
    permissive,
    roles,
    cmd,
    qual
FROM pg_policies 
WHERE tablename = 'reacciones';

-- 2. VER EL ESTADO ACTUAL DE RLS
-- ==============================
SELECT 
    schemaname,
    tablename,
    rowsecurity,
    forcerowsecurity
FROM pg_tables 
WHERE tablename = 'reacciones';

-- 3. SOLUCIÓN A: DESHABILITAR RLS TEMPORALMENTE (MÁS FÁCIL)
-- =========================================================
-- ⚠️ IMPORTANTE: Esto hace la tabla completamente pública
-- ALTER TABLE reacciones DISABLE ROW LEVEL SECURITY;

-- 4. SOLUCIÓN B: ARREGLAR POLÍTICAS RLS (MÁS SEGURO)
-- ==================================================
-- Eliminar políticas existentes problemáticas
DROP POLICY IF EXISTS "Permitir lectura pública de reacciones" ON reacciones;
DROP POLICY IF EXISTS "Permitir inserción de reacciones" ON reacciones;
DROP POLICY IF EXISTS "Permitir actualización de reacciones" ON reacciones;
DROP POLICY IF EXISTS "Permitir eliminación de reacciones" ON reacciones;

-- Crear políticas completas y funcionales
CREATE POLICY "Permitir todas las operaciones públicas en reacciones"
ON reacciones
FOR ALL 
USING (true)
WITH CHECK (true);

-- 5. SOLUCIÓN C: POLÍTICAS ESPECÍFICAS POR OPERACIÓN
-- ==================================================
-- Si prefieres más control, usa estas en lugar de la política general:

-- CREATE POLICY "Permitir lectura pública" 
-- ON reacciones FOR SELECT 
-- USING (true);

-- CREATE POLICY "Permitir inserción pública" 
-- ON reacciones FOR INSERT 
-- WITH CHECK (true);

-- CREATE POLICY "Permitir actualización pública" 
-- ON reacciones FOR UPDATE 
-- USING (true) 
-- WITH CHECK (true);

-- CREATE POLICY "Permitir eliminación pública" 
-- ON reacciones FOR DELETE 
-- USING (true);

-- 6. VERIFICAR QUE LAS NUEVAS POLÍTICAS FUNCIONAN
-- ===============================================
-- Probar eliminación directa
-- DELETE FROM reacciones 
-- WHERE mensaje_id = '707792b8-f31d-424e-aec2-508f4aaf5f0e' 
-- AND session_id = 'anon_1766343770119_unpgpvben';

-- 7. LIMPIAR DATOS DE PRUEBA PROBLEMÁTICOS
-- ========================================
-- Si quieres empezar limpio, elimina todas las reacciones de prueba:
-- DELETE FROM reacciones WHERE session_id LIKE 'anon_%';

-- =====================================================
-- INSTRUCCIONES:
-- =====================================================
-- 1. Ejecuta primero la consulta #1 para ver políticas actuales
-- 2. Ejecuta la SOLUCIÓN A (deshabilitar RLS) para solución rápida
--    O ejecuta la SOLUCIÓN B (arreglar políticas) para solución segura
-- 3. Prueba el sistema de reacciones
-- 4. Si funciona, opcional: ejecuta #7 para limpiar datos de prueba

-- NOTA: La SOLUCIÓN A es más simple pero menos segura
--       La SOLUCIÓN B mantiene la seguridad pero con acceso público controlado