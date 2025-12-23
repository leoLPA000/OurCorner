/*
Supabase configuration for NuestroMes

Usage:
1) Add the Supabase UMD SDK in your `index.html` (before your other scripts):
   <script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js/dist/umd/supabase.min.js"></script>
2) Then include this file right after the SDK so `supabaseClient` is available globally:
   <script src="js/supabaseConfig.js"></script>

This file exposes `supabaseClient` as a global window variable.
DO NOT put the `service_role` key here. Only use the `anon` (public) key in the frontend.
*/

// Replace the URL and anon key below if you ever rotate them.
const SUPABASE_URL = 'https://lrjbpnzkvueralkqrsfd.supabase.co';
const SUPABASE_ANON_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxyamJwbnprdnVlcmFsa3Fyc2ZkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIzNzE4MTMsImV4cCI6MjA3Nzk0NzgxM30.ybbfydRMmAMbaRi2UaF0kq-NiVxBzwS3oX54tCm5EXE';

// Create a Supabase client using the global `supabase` from the UMD bundle.
// The UMD bundle exposes `supabase` global. Example in index.html: <script src=".../supabase.min.js"></script>
const supabaseClient = typeof supabase !== 'undefined'
  ? supabase.createClient(SUPABASE_URL, SUPABASE_ANON_KEY)
  : null;

if (!supabaseClient) {
  console.warn('Supabase UMD SDK not found. Make sure you loaded the script from CDN before supabaseConfig.js');
}

// Expose globally for other scripts
window.supabaseClient = supabaseClient;

// Helper exports for convenience (can be used directly from other scripts as window.supabaseClient)
// Example usage in other JS files:
// const { data, error } = await window.supabaseClient.storage.from('archivos').upload(...)

console.log('Supabase client initialized:', !!supabaseClient);
