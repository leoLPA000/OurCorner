// reacciones.js
// Funciones para manejar reacciones con Supabase
// Requiere que `supabaseClient` esté inicializado en `supabaseConfig.js` y disponible globalmente (window.supabaseClient).

// Emojis por defecto que mostraremos (puedes personalizar)
const DEFAULT_EMOJIS = ['❤️', '😂', '😍'];

// Nombre de cada reacción, al estilo Facebook (❤️ "Me encanta", etc.)
const NOMBRES_REACCION = {
  '😂': 'Me divierte',
  '❤️': 'Me encanta',
  '😍': 'Me fascina',
  '🥹': 'Me conmueve',
  '🫂': 'Te abrazo'
};

// Obtener ID del usuario autenticado
function obtenerIdSesion() {
  // 🔐 Verificar autenticación
  if (window.authService && window.authService.isAuthenticated()) {
    const user = window.authService.getCurrentUser();
    return user.id;
  }

  // Si no está autenticado, retornar null
  return null;
}

async function insertarOActualizarReaccion(mensajeId, emoji) {
  if (!mensajeId || !emoji) throw new Error('mensajeId y emoji son requeridos');

  // 🔐 Verificar autenticación
  if (!requireLogin('⚠️ Debes iniciar sesión para reaccionar')) {
    throw new Error('Usuario no autenticado');
  }

  // 🔐 Verificar permisos de rol (solo admin y super_admin pueden reaccionar)
  if (window.rolesService && !await window.rolesService.canModify()) {
    alert('⚠️ Los invitados no pueden reaccionar a los mensajes.\nSolo los administradores tienen este permiso.');
    throw new Error('Usuario sin permisos para reaccionar');
  }

  const client = window.supabaseClient;
  if (!client) throw new Error('Supabase no inicializado');

  const sessionId = obtenerIdSesion();
  if (!sessionId) throw new Error('No se pudo obtener ID de usuario');

  try {
    // Buscar si YO (usuario actual) ya reaccioné a este mensaje.
    // Antes esta consulta no filtraba por session_id, así que encontraba la
    // reacción de CUALQUIER usuario y la trataba como "la" reacción del
    // mensaje — por eso una cuenta veía "ya reaccionado" con la reacción de otra.
    appLog(`🔍 Buscando mi reacción existente para mensaje: ${mensajeId}`);

    const { data: reacciones, error: errorCheck } = await client
      .from('reacciones')
      .select('id, emoji')
      .eq('mensaje_id', mensajeId)
      .eq('session_id', sessionId)
      .limit(1);

    appLog(`📊 Resultado de búsqueda:`, { reacciones, errorCheck });

    if (errorCheck) {
      console.error('Error verificando reacciones existentes:', errorCheck);
      throw errorCheck;
    }

    const existente = reacciones && reacciones.length > 0 ? reacciones[0] : null;
    appLog(`✅ Mi reacción existente:`, existente);

    if (existente) {
      if (existente.emoji === emoji) {
        // Si es la misma reacción, la eliminamos (toggle off)
        appLog('🗑️ Eliminando mi reacción:', existente);

        const { error: errorDelete } = await client
          .from('reacciones')
          .delete()
          .eq('id', existente.id);

        if (errorDelete) {
          console.error('❌ Error al eliminar:', errorDelete);
          throw errorDelete;
        }

        appLog('✅ Reacción eliminada');
        return { action: 'removed', emoji };
      } else {
        // Si es diferente reacción, la actualizamos (solo mi propia fila)
        appLog('🔄 Actualizando mi emoji:', existente.emoji, '→', emoji);

        const { error: errorUpdate } = await client
          .from('reacciones')
          .update({ emoji })
          .eq('id', existente.id);

        if (errorUpdate) {
          console.error('❌ Error al actualizar:', errorUpdate);
          throw errorUpdate;
        }

        appLog('✅ Emoji actualizado');
        return { action: 'updated', emoji, previous: existente.emoji };
      }
    } else {
      // No existe MI reacción a este mensaje, crear una nueva propia
      appLog('➕ Creando nueva reacción propia:', emoji);

      const { error } = await client
        .from('reacciones')
        .insert([{ mensaje_id: mensajeId, emoji, session_id: sessionId, user_id: sessionId }]);

      if (error) {
        console.error('❌ Error al crear:', error);
        throw error;
      }

      appLog('✅ Reacción creada');
      return { action: 'added', emoji };
    }
  } catch (err) {
    console.error('Error en insertarOActualizarReaccion:', err);
    throw err;
  }
}

// Devuelve el emoji con el que el usuario ACTUAL reaccionó a un mensaje, o null.
async function obtenerEmojiActual(mensajeId) {
  const client = window.supabaseClient;
  const sessionId = obtenerIdSesion();
  if (!client || !sessionId) return null;

  try {
    const { data, error } = await client
      .from('reacciones')
      .select('emoji')
      .eq('mensaje_id', mensajeId)
      .eq('session_id', sessionId)
      .maybeSingle();

    if (error) {
      console.error('❌ Error obteniendo mi emoji actual:', error);
      return null;
    }

    const emoji = data ? data.emoji : null;
    appLog(`📝 Mi emoji actual para ${mensajeId}:`, emoji);
    return emoji;
  } catch (err) {
    console.error('Error en obtenerEmojiActual:', err);
    return null;
  }
}

// Devuelve el conteo agregado de TODAS las reacciones de un mensaje (de todos
// los usuarios), ej: { '❤️': 3, '😂': 1 } — usado para el resumen estilo Facebook.
async function obtenerConteosPorMensaje(mensajeId) {
  const client = window.supabaseClient;
  if (!client || !mensajeId) return {};

  try {
    const { data, error } = await client
      .from('reacciones')
      .select('emoji')
      .eq('mensaje_id', mensajeId);

    if (error) {
      console.error('❌ Error obteniendo conteos:', error);
      return {};
    }

    const counts = {};
    (data || []).forEach(r => {
      counts[r.emoji] = (counts[r.emoji] || 0) + 1;
    });
    return counts;
  } catch (err) {
    console.error('Error obteniendo conteos:', err);
    return {};
  }
}

// Trae las reacciones de VARIOS mensajes en UNA sola consulta (en vez de 2 consultas
// por mensaje). Devuelve { conteos: {mensajeId: {emoji: cantidad}}, misReacciones: {mensajeId: emoji} }.
// Pensado para pantallas con listas largas (ej. mis-mensajes.html), donde antes se
// disparaban ~2 peticiones a Supabase por cada mensaje mostrado.
async function obtenerReaccionesDeMensajes(mensajeIds) {
  const client = window.supabaseClient;
  if (!client || !mensajeIds || mensajeIds.length === 0) {
    return { conteos: {}, misReacciones: {} };
  }

  const sessionId = obtenerIdSesion();

  try {
    const { data, error } = await client
      .from('reacciones')
      .select('mensaje_id, emoji, session_id')
      .in('mensaje_id', mensajeIds);

    if (error) {
      console.error('❌ Error obteniendo reacciones en lote:', error);
      return { conteos: {}, misReacciones: {} };
    }

    const conteos = {};
    const misReacciones = {};

    (data || []).forEach(r => {
      if (!conteos[r.mensaje_id]) conteos[r.mensaje_id] = {};
      conteos[r.mensaje_id][r.emoji] = (conteos[r.mensaje_id][r.emoji] || 0) + 1;

      if (sessionId && r.session_id === sessionId) {
        misReacciones[r.mensaje_id] = r.emoji;
      }
    });

    appLog(`📦 Reacciones en lote obtenidas para ${mensajeIds.length} mensajes`);
    return { conteos, misReacciones };
  } catch (err) {
    console.error('Error en obtenerReaccionesDeMensajes:', err);
    return { conteos: {}, misReacciones: {} };
  }
}


// Suscribirse a cambios en la tabla reacciones para actualizar en tiempo real
// callback recibirá ({ mensajeId, emoji, event })
function suscribirReacciones(onUpdate) {
  const client = window.supabaseClient;
  if (!client || !client.channel) {
    console.warn('La versión del cliente supabase no soporta realtime via channel.');
    return null;
  }

  // Crear canal público para reacciones
  const channel = client
    .channel('public:reacciones')
    .on('postgres_changes', { event: '*', schema: 'public', table: 'reacciones' }, payload => {
      const event = payload.eventType || payload.event || payload.type;
      const record = payload.new || payload.record || payload;
      const old = payload.old || payload.previous || null;

      const mensajeId = (record && record.mensaje_id) || (old && old.mensaje_id) || null;
      const emoji = (record && record.emoji) || (old && old.emoji) || null;

      if (onUpdate) onUpdate({ mensajeId, emoji, event });
    })
    .subscribe();

  return channel;
}

// Arma el resumen agregado estilo Facebook (emojis usados + total), oculto si no hay reacciones
function renderResumenReacciones(el, counts) {
  if (!el) return;
  const entries = Object.entries(counts || {}).filter(([, c]) => c > 0);

  if (entries.length === 0) {
    el.innerHTML = '';
    el.classList.remove('visible');
    return;
  }

  entries.sort((a, b) => b[1] - a[1]);
  const total = entries.reduce((sum, [, c]) => sum + c, 0);
  const iconos = entries.slice(0, 3).map(([emoji]) => `<span class="resumen-emoji">${emoji}</span>`).join('');

  el.innerHTML = `${iconos}<span class="resumen-total">${total}</span>`;
  el.classList.add('visible');
}

// Helper para montar botón de reacciones con menú desplegable
async function montarBotonesDeReaccion(contenedor, mensajeId, initialCounts = {}, miReaccionInicial, canReactInicial) {
  appLog('🔧 Montando botón de reacciones para mensaje:', mensajeId);

  // 🔐 Verificar permisos. Si el llamador ya lo calculó (ej. una sola vez para
  // toda una lista de mensajes), se reutiliza en vez de volver a consultar.
  const canReact = canReactInicial !== undefined
    ? canReactInicial
    : (window.rolesService ? await window.rolesService.canModify() : true);
  appLog('🔐 Usuario puede reaccionar:', canReact);

  // Limpiar contenedor
  contenedor.innerHTML = '';
  contenedor.classList.add('reacciones-container');

  // Crear contenedor principal
  const reactionContainer = document.createElement('div');
  reactionContainer.className = 'reaction-main-container';

  // Botón principal
  const btnPrincipal = document.createElement('button');
  btnPrincipal.className = 'btn-reaction-main';
  updateMainButton(btnPrincipal, null, false);

  // Resumen agregado (estilo Facebook: emojis usados + total, de todos los usuarios)
  const resumenReacciones = document.createElement('div');
  resumenReacciones.className = 'reaction-summary';
  renderResumenReacciones(resumenReacciones, initialCounts);

  // Obtener MI emoji actual y actualizar botón.
  // Si ya se pasó `miReaccionInicial` (consulta en lote hecha por el llamador),
  // se usa directo y se evita una consulta a Supabase por cada mensaje.
  if (miReaccionInicial !== undefined) {
    updateMainButton(btnPrincipal, miReaccionInicial, !!miReaccionInicial);
  } else {
    obtenerEmojiActual(mensajeId).then(emoji => {
      const hasReaction = !!emoji;
      appLog(`📝 Mi emoji actual para ${mensajeId}:`, emoji, '- tiene reacción:', hasReaction);
      updateMainButton(btnPrincipal, emoji, hasReaction);
    }).catch(err => {
      console.warn('Error obteniendo mi emoji actual:', err);
      updateMainButton(btnPrincipal, null, false);
    });
  }

  // Menú desplegable
  const menuReacciones = document.createElement('div');
  menuReacciones.className = 'reaction-menu hidden';

  const emojisDisponibles = ['😂', '❤️', '😍', '🥹', '🫂'];
  emojisDisponibles.forEach(emoji => {
    const btnEmoji = document.createElement('button');
    btnEmoji.className = 'reaction-option';
    btnEmoji.textContent = emoji;
    btnEmoji.dataset.emoji = emoji;
    btnEmoji.title = NOMBRES_REACCION[emoji] || '';

    btnEmoji.addEventListener('click', async (e) => {
      e.stopPropagation();
      hideMenu();
      await handleReaction(mensajeId, emoji, btnPrincipal, contenedor, resumenReacciones);
    });

    menuReacciones.appendChild(btnEmoji);
  });

  // Variables para hold detection
  let holdTimeout;
  let isHolding = false;

  // 🔐 Si no tiene permisos, deshabilitar interacciones
  if (!canReact) {
    btnPrincipal.disabled = true;
    btnPrincipal.title = 'Solo los administradores pueden reaccionar';
    btnPrincipal.style.opacity = '0.5';
    btnPrincipal.style.cursor = 'not-allowed';
    reactionContainer.appendChild(btnPrincipal);
    reactionContainer.appendChild(menuReacciones);
    contenedor.appendChild(reactionContainer);
    contenedor.appendChild(resumenReacciones);
    return; // No agregar eventos si no tiene permisos
  }

  // Eventos para mostrar menú al mantener presionado
  btnPrincipal.addEventListener('mousedown', (e) => {
    holdTimeout = setTimeout(() => {
      isHolding = true;
      showMenu();
    }, 500); // 500ms para mostrar menú
  });

  btnPrincipal.addEventListener('mouseup', async (e) => {
    clearTimeout(holdTimeout);
    if (!isHolding) {
      // 🔐 VERIFICAR PERMISOS ANTES DE PROCESAR
      if (window.rolesService && !await window.rolesService.canModify()) {
        alert('⚠️ Los invitados no pueden reaccionar a los mensajes.');
        isHolding = false;
        return;
      }

      // Click rápido - verificar estado actual del botón
      const hasReacted = btnPrincipal.classList.contains('reacted');
      appLog(`🎯 Estado del botón: ${hasReacted ? 'reaccionado' : 'no reaccionado'}`);

      if (hasReacted) {
        // Ya hay reacción mía, quitarla
        const currentEmoji = await obtenerEmojiActual(mensajeId);
        appLog('🗑️ Quitando mi reacción con click rápido:', currentEmoji);
        await handleReaction(mensajeId, currentEmoji, btnPrincipal, contenedor, resumenReacciones);
      } else {
        // No hay reacción mía, agregar el emoji por defecto
        const emojiToAdd = '❤️';
        appLog('💕 Agregando reacción con click rápido:', emojiToAdd);
        await handleReaction(mensajeId, emojiToAdd, btnPrincipal, contenedor, resumenReacciones);
      }
    }
    isHolding = false;
  });

  btnPrincipal.addEventListener('mouseleave', () => {
    clearTimeout(holdTimeout);
    isHolding = false;
  });

  // Touch events para móvil
  btnPrincipal.addEventListener('touchstart', (e) => {
    holdTimeout = setTimeout(() => {
      isHolding = true;
      showMenu();
    }, 500);
  });

  btnPrincipal.addEventListener('touchend', async (e) => {
    clearTimeout(holdTimeout);
    if (!isHolding) {
      e.preventDefault();

      // 🔐 VERIFICAR PERMISOS ANTES DE PROCESAR
      if (window.rolesService && !await window.rolesService.canModify()) {
        alert('⚠️ Los invitados no pueden reaccionar a los mensajes.');
        isHolding = false;
        return;
      }

      // Touch rápido - verificar estado actual del botón
      const hasReacted = btnPrincipal.classList.contains('reacted');
      appLog(`🎯 Estado del botón (touch): ${hasReacted ? 'reaccionado' : 'no reaccionado'}`);

      if (hasReacted) {
        const currentEmoji = await obtenerEmojiActual(mensajeId);
        appLog('🗑️ Quitando mi reacción con touch rápido:', currentEmoji);
        await handleReaction(mensajeId, currentEmoji, btnPrincipal, contenedor, resumenReacciones);
      } else {
        const emojiToAdd = '❤️';
        appLog('💕 Agregando reacción con touch rápido:', emojiToAdd);
        await handleReaction(mensajeId, emojiToAdd, btnPrincipal, contenedor, resumenReacciones);
      }
    }
    isHolding = false;
  });

  function showMenu() {
    // Quitar "hidden" primero para poder medir su ancho real (display distinto de none)
    menuReacciones.classList.remove('hidden');

    // Centrar el menú sobre el botón y ajustar (clamp) para que no se corte
    // en pantallas angostas. Se calcula en píxeles absolutos por JS en vez de
    // usar `transform: translateX(calc(-50% + var(...)))`, porque al combinar
    // una variable CSS dentro de un calc() de una propiedad con `transition`
    // el navegador no siempre recalcula el valor mostrado.
    const contRect = reactionContainer.getBoundingClientRect();
    const menuWidth = menuReacciones.offsetWidth;
    let left = (contRect.width / 2) - (menuWidth / 2);

    const margen = 8;
    const menuLeftAbs = contRect.left + left;
    const menuRightAbs = menuLeftAbs + menuWidth;
    if (menuLeftAbs < margen) {
      left += margen - menuLeftAbs;
    } else if (menuRightAbs > window.innerWidth - margen) {
      left -= menuRightAbs - (window.innerWidth - margen);
    }

    menuReacciones.style.left = `${left}px`;
    menuReacciones.classList.add('show');
  }

  function hideMenu() {
    menuReacciones.classList.remove('show');
    setTimeout(() => menuReacciones.classList.add('hidden'), 200);
  }

  // Ocultar menú al hacer click fuera
  document.addEventListener('click', (e) => {
    if (!reactionContainer.contains(e.target)) {
      hideMenu();
    }
  });

  reactionContainer.appendChild(btnPrincipal);
  reactionContainer.appendChild(menuReacciones);
  contenedor.appendChild(reactionContainer);
  contenedor.appendChild(resumenReacciones);
}

function updateMainButton(btn, emoji, hasReaction) {
  const displayEmoji = emoji || '❤️';
  const label = hasReaction ? (NOMBRES_REACCION[emoji] || 'Reaccionaste') : 'Reaccionar';

  btn.innerHTML = `
    <span class="reaction-emoji">${displayEmoji}</span>
    <span class="reaction-text">${label}</span>
  `;

  btn.className = `btn-reaction-main ${hasReaction ? 'reacted' : ''}`;
  appLog(`🔄 Botón actualizado - emoji: ${displayEmoji}, resaltado: ${hasReaction}`);
}


async function handleReaction(mensajeId, emoji, btnPrincipal, contenedor, resumenReacciones) {
  try {
    btnPrincipal.disabled = true;
    appLog(`${emoji} Procesando reacción...`);

    // 🔐 Verificar permisos antes de reaccionar
    if (window.rolesService && !await window.rolesService.canModify()) {
      alert('⚠️ Los invitados no pueden reaccionar a los mensajes.');
      return;
    }

    const result = await insertarOActualizarReaccion(mensajeId, emoji);
    appLog('✅ Resultado:', result);

    // Refrescar mi estado y el resumen agregado de todos los usuarios
    const [miReaccion, counts] = await Promise.all([
      obtenerEmojiActual(mensajeId),
      obtenerConteosPorMensaje(mensajeId)
    ]);

    updateMainButton(btnPrincipal, miReaccion, !!miReaccion);
    renderResumenReacciones(resumenReacciones, counts);
    showReactionFeedback(contenedor, result.action, emoji);

  } catch (err) {
    console.error('❌ Error al reaccionar:', err);
    console.error('📋 Detalles del error:', {
      message: err.message,
      stack: err.stack,
      name: err.name
    });
    alert('❌ Error al procesar la reacción: ' + (err.message || 'Error desconocido'));
  } finally {
    btnPrincipal.disabled = false;
  }
}

function showReactionFeedback(contenedor, action, emoji) {
  const feedback = document.createElement('div');
  feedback.className = 'reaction-feedback';

  const messages = {
    'added': `Reaccionaste con ${emoji}`,
    'updated': `Cambiaste tu reacción a ${emoji}`,
    'removed': 'Reacción eliminada'
  };

  feedback.textContent = messages[action] || 'Reacción procesada';
  contenedor.appendChild(feedback);

  setTimeout(() => {
    feedback.classList.add('fade-out');
    setTimeout(() => feedback.remove(), 300);
  }, 2000);
}

// Exportar como módulo si el entorno lo permite
if (typeof window !== 'undefined') {
  window.Reacciones = {
    insertarOActualizarReaccion,
    obtenerConteosPorMensaje,
    obtenerReaccionesDeMensajes,
    obtenerEmojiActual,
    suscribirReacciones,
    montarBotonesDeReaccion,
    DEFAULT_EMOJIS
  };
}
