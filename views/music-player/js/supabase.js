import { createClient } from 'https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm';

const SB_URL = 'https://lrjbpnzkvueralkqrsfd.supabase.co';
const SB_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImxyamJwbnprdnVlcmFsa3Fyc2ZkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjIzNzE4MTMsImV4cCI6MjA3Nzk0NzgxM30.ybbfydRMmAMbaRi2UaF0kq-NiVxBzwS3oX54tCm5EXE';

let _client = null;

export async function getClient() {
  if (_client) return _client;
  _client = createClient(SB_URL, SB_KEY);
  return _client;
}

/**
 * Fetch all public songs from the `canciones` table.
 * Returns an array shaped for the audio player:
 *   { id, title, artist, url, tipo }
 */
export async function fetchCanciones() {
  const sb = await getClient();
  const { data, error } = await sb
    .from('canciones')
    .select('id, titulo, artista, url, path, tipo, creado_en')
    .eq('publico', true)
    .order('creado_en', { ascending: false });

  if (error) throw new Error(`Supabase error: ${error.message}`);

  return (data || []).map((row) => ({
    id:     row.id,
    title:  row.titulo  || 'Sin título',
    artist: row.artista || 'Artista desconocido',
    url:    row.url,
    tipo:   row.tipo    || 'cancion',
    art:    null,
  }));
}
