/**
 * 💌 SUPABASE EDGE FUNCTION: send-push
 * Envío de notificaciones Web Push reales con firma VAPID y gestión de suscripciones obsoletas.
 * 
 * Requisitos en Supabase Secrets:
 * - VAPID_PUBLIC_KEY
 * - VAPID_PRIVATE_KEY
 * - VAPID_SUBJECT (ej: mailto:tu-email@gmail.com)
 */

import { serve } from "https://deno.land/std@0.177.0/http/server.ts";
import { createClient } from "https://esm.sh/@supabase/supabase-js@2.39.0";
import webpush from "npm:web-push@3.6.7";

const corsHeaders = {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "authorization, x-client-info, apikey, content-type",
    "Access-Control-Allow-Methods": "POST, OPTIONS"
};

interface PushPayload {
    recipient_id?: string;
    title: string;
    body: string;
    icon?: string;
    badge?: string;
    url?: string;
    tag?: string;
    actions?: Array<{ action: string; title: string }>;
}

serve(async (req: Request) => {
    // 1. Manejar preflight CORS
    if (req.method === "OPTIONS") {
        return new Response("ok", { headers: corsHeaders });
    }

    try {
        // 2. Variables de entorno de Supabase
        const supabaseUrl = Deno.env.get("SUPABASE_URL") ?? "";
        const serviceRoleKey = Deno.env.get("SUPABASE_SERVICE_ROLE_KEY") ?? "";
        const vapidPublicKey = Deno.env.get("VAPID_PUBLIC_KEY") ?? "";
        const vapidPrivateKey = Deno.env.get("VAPID_PRIVATE_KEY") ?? "";
        const vapidSubject = Deno.env.get("VAPID_SUBJECT") ?? "mailto:ourcorner@love.local";

        if (!vapidPublicKey || !vapidPrivateKey) {
            console.error("❌ Faltan claves VAPID en Supabase Secrets");
            return new Response(
                JSON.stringify({
                    error: "Configuración incompleta: VAPID_PUBLIC_KEY y VAPID_PRIVATE_KEY requeridas en Supabase Secrets"
                }),
                { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
            );
        }

        // Configurar webpush con VAPID
        webpush.setVapidDetails(vapidSubject, vapidPublicKey, vapidPrivateKey);

        // 3. Cliente Supabase con privilegios administrativos (service_role)
        const supabaseAdmin = createClient(supabaseUrl, serviceRoleKey);

        // 4. Validar autenticación del emisor
        const authHeader = req.headers.get("Authorization");
        if (!authHeader) {
            return new Response(
                JSON.stringify({ error: "Cabecera Authorization requerida" }),
                { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } }
            );
        }

        const token = authHeader.replace("Bearer ", "");
        const { data: { user }, error: authError } = await supabaseAdmin.auth.getUser(token);

        if (authError || !user) {
            return new Response(
                JSON.stringify({ error: "Token de autenticación inválido o expirado" }),
                { status: 401, headers: { ...corsHeaders, "Content-Type": "application/json" } }
            );
        }

        // 5. Parsear cuerpo de la petición
        const body: PushPayload = await req.json();
        const { recipient_id, title, body: messageBody, icon, badge, url, tag, actions } = body;

        if (!title || !messageBody) {
            return new Response(
                JSON.stringify({ error: "Los campos 'title' y 'body' son obligatorios" }),
                { status: 400, headers: { ...corsHeaders, "Content-Type": "application/json" } }
            );
        }

        // 6. Consultar suscripciones del destinatario
        let query = supabaseAdmin.from("push_subscriptions").select("*");

        if (recipient_id) {
            query = query.eq("user_id", recipient_id);
        } else {
            // Si no se especifica destinatario, solo super_admin puede enviar a todos
            const { data: roleData } = await supabaseAdmin
                .from("user_roles")
                .select("role")
                .eq("user_id", user.id)
                .single();

            if (roleData?.role !== "super_admin") {
                return new Response(
                    JSON.stringify({ error: "Se requiere 'recipient_id' para enviar notificaciones" }),
                    { status: 403, headers: { ...corsHeaders, "Content-Type": "application/json" } }
                );
            }
        }

        const { data: subscriptions, error: subsError } = await query;

        if (subsError) {
            console.error("❌ Error consultando push_subscriptions:", subsError);
            throw subsError;
        }

        if (!subscriptions || subscriptions.length === 0) {
            return new Response(
                JSON.stringify({
                    success: true,
                    message: "El usuario destinatario no tiene suscripciones push activas",
                    sent: 0,
                    purged: 0
                }),
                { status: 200, headers: { ...corsHeaders, "Content-Type": "application/json" } }
            );
        }

        // 7. Preparar payload de la notificación
        const pushPayload = JSON.stringify({
            title,
            body: messageBody,
            icon: icon || "./assets/images/icons/icon-192.png",
            badge: badge || "./assets/images/icons/favicon-64.png",
            url: url || "./index.html",
            tag: tag || "ourcorner-push",
            actions: actions || [{ action: "open", title: "Abrir OurCorner" }]
        });

        // 8. Enviar Web Push a todas las suscripciones autorizadas
        let sentCount = 0;
        let failCount = 0;
        const purgedIds: string[] = [];

        await Promise.all(
            subscriptions.map(async (sub) => {
                const pushSubscription = {
                    endpoint: sub.endpoint,
                    keys: {
                        p256dh: sub.p256dh,
                        auth: sub.auth
                    }
                };

                try {
                    await webpush.sendNotification(pushSubscription, pushPayload);
                    sentCount++;
                } catch (err: any) {
                    failCount++;
                    const statusCode = err?.statusCode;
                    console.warn(`[WebPush] Fallo al enviar a sub ${sub.id}: Status ${statusCode}`);

                    // Códigos 404 Not Found o 410 Gone indican que la suscripción ya no existe o la app fue desinstalada
                    if (statusCode === 404 || statusCode === 410) {
                        purgedIds.push(sub.id);
                    }
                }
            })
        );

        // 9. Purgar suscripciones definitivamente inválidas
        if (purgedIds.length > 0) {
            console.log(`🧹 [WebPush] Eliminando ${purgedIds.length} suscripciones inválidas/expiradas...`);
            await supabaseAdmin.from("push_subscriptions").delete().in("id", purgedIds);
        }

        return new Response(
            JSON.stringify({
                success: true,
                sent: sentCount,
                failed: failCount,
                purged: purgedIds.length
            }),
            { status: 200, headers: { ...corsHeaders, "Content-Type": "application/json" } }
        );

    } catch (error: any) {
        console.error("❌ Error fatal en send-push:", error);
        return new Response(
            JSON.stringify({ error: error.message || "Error interno del servidor" }),
            { status: 500, headers: { ...corsHeaders, "Content-Type": "application/json" } }
        );
    }
});
