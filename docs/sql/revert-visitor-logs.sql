-- ============================================================================
-- 🔐 REVERTIR VISITOR_LOGS A PERMISIVO (ES PARA ANALYTICS)
-- ============================================================================

DROP POLICY IF EXISTS "Visitor logs - INSERT autenticado" ON visitor_logs;

CREATE POLICY "Visitor logs - INSERT pÃºblico"
ON visitor_logs FOR INSERT
WITH CHECK (true);

-- ============================================================================
-- ✅ VISITOR_LOGS VUELVE A PERMITIR INSERCIÓN ANÓNIMA
-- ============================================================================
