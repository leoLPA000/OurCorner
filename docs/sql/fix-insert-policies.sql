-- ============================================================================
-- 🔐 ARREGLAR POLÍTICAS INSERT CON (true) → REQUIEREN AUTENTICACIÓN
-- ============================================================================

-- ============================================================================
-- 1. CANCIONES - Requiere autenticación para INSERT
-- ============================================================================

DROP POLICY IF EXISTS "Canciones - INSERT permitido" ON canciones;

CREATE POLICY "Canciones - INSERT autenticado"
ON canciones FOR INSERT
WITH CHECK (auth.role() = 'authenticated');

-- ============================================================================
-- 2. MENSAJES - Requiere autenticación para INSERT
-- ============================================================================

DROP POLICY IF EXISTS "Mensajes - INSERT permitido" ON mensajes;

CREATE POLICY "Mensajes - INSERT autenticado"
ON mensajes FOR INSERT
WITH CHECK (auth.role() = 'authenticated');

-- ============================================================================
-- 3. REACCIONES - Requiere autenticación para INSERT
-- ============================================================================

DROP POLICY IF EXISTS "Reacciones - INSERT público" ON reacciones;

CREATE POLICY "Reacciones - INSERT autenticado"
ON reacciones FOR INSERT
WITH CHECK (auth.role() = 'authenticated');

-- ============================================================================
-- 4. USER_PROFILES - Requiere autenticación para INSERT
-- ============================================================================

DROP POLICY IF EXISTS "User profiles - INSERT permitido" ON user_profiles;

CREATE POLICY "User profiles - INSERT autenticado"
ON user_profiles FOR INSERT
WITH CHECK (auth.role() = 'authenticated');

-- ============================================================================
-- 5. VISITOR_LOGS - Mantener permisivo (analytics)
-- ============================================================================
-- Esta tabla es para tracking, mantenerla permisiva es OK

-- ============================================================================
-- 6. CARDS - Si existe
-- ============================================================================

DROP POLICY IF EXISTS "Allow public insert to cards" ON cards;

CREATE POLICY "Cards - INSERT autenticado"
ON cards FOR INSERT
WITH CHECK (auth.role() = 'authenticated');

-- ============================================================================
-- 7. CARD_LOGS - Si existe
-- ============================================================================

DROP POLICY IF EXISTS "Allow public insert to card_logs" ON card_logs;

CREATE POLICY "Card logs - INSERT autenticado"
ON card_logs FOR INSERT
WITH CHECK (auth.role() = 'authenticated');

-- ============================================================================
-- 8. SHARED_CARDS - Si existe
-- ============================================================================

DROP POLICY IF EXISTS "Allow public insert to shared_cards" ON shared_cards;

CREATE POLICY "Shared cards - INSERT autenticado"
ON shared_cards FOR INSERT
WITH CHECK (auth.role() = 'authenticated');

-- ============================================================================
-- ✅ FIN - Todas las políticas INSERT ahora requieren autenticación
-- ============================================================================
