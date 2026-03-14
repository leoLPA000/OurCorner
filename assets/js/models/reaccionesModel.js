// reacciones.js
// Funciones para manejar reacciones con Supabase
// Requiere que `supabaseClient` esté inicializado en `supabaseConfig.js` y disponible globalmente (window.supabaseClient).

// Emojis por defecto que mostraremos (puedes personalizar)
const DEFAULT_EMOJIS = ['❤️', '😂', '😍'];

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
  if (!window.authService || !window.authService.isAuthenticated()) {
    alert('⚠️ Debes iniciar sesión para reaccionar');
    window.location.href = '/OurCorner/views/login.html?return=' + encodeURIComponent(window.location.pathname);
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
    // Buscar si existe alguna reacción para este mensaje (sin importar session_id)
    console.log(`🔍 Buscando reacción existente para mensaje: ${mensajeId}`);

    const { data: reacciones, error: errorCheck } = await client
      .from('reacciones')
      .select('id, emoji')
      .eq('mensaje_id', mensajeId)
      .limit(1);

    console.log(`📊 Resultado de búsqueda:`, { reacciones, errorCheck });

    if (errorCheck) {
      console.error('Error verificando reacciones existentes:', errorCheck);
      throw errorCheck;
    }

    const existente = reacciones && reacciones.length > 0 ? reacciones[0] : null;
    console.log(`✅ Reacción existente encontrada:`, existente);

    if (existente) {
      if (existente.emoji === emoji) {
        // Si es la misma reacción, la eliminamos (toggle off)
        console.log('🗑️ Eliminando reacción:', existente);

        const { error: errorDelete } = await client
          .from('reacciones')
          .delete()
          .eq('id', existente.id);

        if (errorDelete) {
          console.error('❌ Error al eliminar:', errorDelete);
          throw errorDelete;
        }

        console.log('✅ Reacción eliminada');
        return { action: 'removed', emoji };
      } else {
        // Si es diferente reacción, la actualizamos
        console.log('🔄 Actualizando emoji:', existente.emoji, '→', emoji);

        const { error: errorUpdate } = await client
          .from('reacciones')
          .update({ emoji, session_id: sessionId })
          .eq('id', existente.id);

        if (errorUpdate) {
          console.error('❌ Error al actualizar:', errorUpdate);
          throw errorUpdate;
        }

        console.log('✅ Emoji actualizado');
        return { action: 'updated', emoji, previous: existente.emoji };
      }
    } else {
      // No existe, crear nueva
      console.log('➕ Creando nueva reacción:', emoji);

      const { error } = await client
        .from('reacciones')
        .insert([{ mensaje_id: mensajeId, emoji, session_id: sessionId }]);

      if (error) {
        console.error('❌ Error al crear:', error);
        throw error;
      }

      console.log('✅ Reacción creada');
      return { action: 'added', emoji };
    }
  } catch (err) {
    console.error('Error en insertarOActualizarReaccion:', err);
    throw err;
  }
}

async function obtenerEmojiActual(mensajeId) {
  const client = window.supabaseClient;
  if (!client) return null;

  try {
    const { data, error } = await client
      .from('reacciones')
      .select('emoji')
      .eq('mensaje_id', mensajeId)
      .maybeSingle();

    if (error) {
      console.error('❌ Error obteniendo emoji actual:', error);
      return null;
    }

    const emoji = data ? data.emoji : null;
    console.log(`📝 Emoji actual para ${mensajeId}:`, emoji);
    return emoji;
  } catch (err) {
    console.error('Error en obtenerEmojiActual:', err);
    return null;
  }
}

async function obtenerConteosPorMensaje(mensajeId) {
  if (!mensajeId) return {};

  try {
    const emoji = await obtenerEmojiActual(mensajeId);
    return emoji ? { [emoji]: 1 } : {};
  } catch (err) {
    console.error('Error obteniendo conteos:', err);
    return {};
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

// Helper para montar botón de reacciones con menú desplegable
async function montarBotonesDeReaccion(contenedor, mensajeId, initialCounts = {}) {
  console.log('🔧 Montando botón de reacciones para mensaje:', mensajeId);

  // 🔐 Verificar permisos
  const canReact = window.rolesService ? await window.rolesService.canModify() : true;
  console.log('🔐 Usuario puede reaccionar:', canReact);

  // Limpiar contenedor
  contenedor.innerHTML = '';
  contenedor.classList.add('reacciones-container');

  // Crear contenedor principal
  const reactionContainer = document.createElement('div');
  reactionContainer.className = 'reaction-main-container';

  // Botón principal con contador total
  const btnPrincipal = document.createElement('button');
  btnPrincipal.className = 'btn-reaction-main';

  // Calcular total inicial
  const totalReacciones = Object.values(initialCounts).reduce((sum, count) => sum + count, 0);

  // Obtener emoji actual y actualizar botón
  obtenerEmojiActual(mensajeId).then(emoji => {
    const hasReaction = !!emoji;
    console.log(`📝 Emoji actual para ${mensajeId}:`, emoji, '- tiene reacción:', hasReaction);
    updateMainButton(btnPrincipal, emoji, hasReaction);
  }).catch(err => {
    console.warn('Error obteniendo emoji actual:', err);
    // Fallback: sin reacción
    updateMainButton(btnPrincipal, null, false);
  });

  // Menú desplegable
  const menuReacciones = document.createElement('div');
  menuReacciones.className = 'reaction-menu hidden';

  const emojisDisponibles = ['😂', '❤️', '😍', '🥹', '🫂'];
  emojisDisponibles.forEach(emoji => {
    const btnEmoji = document.createElement('button');
    btnEmoji.className = 'reaction-option';
    btnEmoji.textContent = emoji;
    btnEmoji.dataset.emoji = emoji;

    // Efecto hover - resaltar y crecer
    btnEmoji.addEventListener('mouseenter', () => {
      btnEmoji.style.transform = 'scale(1.5) translateY(-10px)';
      btnEmoji.setAttribute('data-highlighted', 'true');
    });

    btnEmoji.addEventListener('mouseleave', () => {
      btnEmoji.style.transform = 'scale(1) translateY(0)';
      btnEmoji.removeAttribute('data-highlighted');
    });

    btnEmoji.addEventListener('click', async (e) => {
      e.stopPropagation();
      console.log('🎯 Emoji clickeado:', emoji);
      hideMenu();
      await handleReaction(mensajeId, emoji, btnPrincipal, contenedor);
    });

    // Touch: prevenir selección de texto
    btnEmoji.addEventListener('touchstart', (e) => {
      e.preventDefault();
      e.stopPropagation();
    });

    // Al soltar sobre un emoji resaltado, seleccionar ese
    btnEmoji.addEventListener('touchend', async (e) => {
      if (btnEmoji.getAttribute('data-highlighted') === 'true') {
        e.preventDefault();
        e.stopPropagation();
        console.log('🎯 Emoji seleccionado (touch):', emoji);
        hideMenu();
        await handleReaction(mensajeId, emoji, btnPrincipal, contenedor);
      }
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
      console.log(`🎯 Estado del botón: ${hasReacted ? 'reaccionado' : 'no reaccionado'}`);

      if (hasReacted) {
        // Ya hay reacción, obtenerla y quitarla
        const currentEmoji = await obtenerEmojiActual(mensajeId);
        console.log('🗑️ Quitando reacción con click rápido:', currentEmoji);
        await handleReaction(mensajeId, currentEmoji, btnPrincipal, contenedor);
      } else {
        // No hay reacción, agregar el emoji mostrado
        const emojiElement = btnPrincipal.querySelector('.reaction-emoji');
        const emojiToAdd = emojiElement ? emojiElement.textContent : '❤️';
        console.log('💕 Agregando reacción con click rápido:', emojiToAdd);
        await handleReaction(mensajeId, emojiToAdd, btnPrincipal, contenedor);
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
    e.stopPropagation();
    console.log('📱 Touch start en botón');
    holdTimeout = setTimeout(() => {
      isHolding = true;
      console.log('📱 Hold detectado, mostrando menú');
      showMenu();
    }, 500);
  });

  btnPrincipal.addEventListener('touchend', async (e) => {
    clearTimeout(holdTimeout);
    console.log('📱 Touch end, isHolding:', isHolding);
    
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
      console.log(`🎯 Estado del botón (touch): ${hasReacted ? 'reaccionado' : 'no reaccionado'}`);

      if (hasReacted) {
        // Ya hay reacción, obtenerla y quitarla
        const currentEmoji = await obtenerEmojiActual(mensajeId);
        console.log('🗑️ Quitando reacción con touch rápido:', currentEmoji);
        await handleReaction(mensajeId, currentEmoji, btnPrincipal, contenedor);
      } else {
        // No hay reacción, agregar el emoji mostrado
        const emojiElement = btnPrincipal.querySelector('.reaction-emoji');
        const emojiToAdd = emojiElement ? emojiElement.textContent : '❤️';
        console.log('💕 Agregando reacción con touch rápido:', emojiToAdd);
        await handleReaction(mensajeId, emojiToAdd, btnPrincipal, contenedor);
      }
    }
    isHolding = false;
  });

  // Cancelar hold si se levanta el dedo rápido
  btnPrincipal.addEventListener('touchcancel', (e) => {
    clearTimeout(holdTimeout);
    isHolding = false;
  });

  // Detectar emoji bajo el dedo mientras deslizas (en el menú)
  let lastHighlightedEmoji = null;
  
  menuReacciones.addEventListener('touchmove', (e) => {
    // No prevenir si el menú no es visible
    if (!menuReacciones.classList.contains('show')) return;
    
    try {
      const touch = e.touches[0];
      const elementoEnPosicion = document.elementFromPoint(touch.clientX, touch.clientY);
      
      // Buscar si es un botón de emoji
      const emojiBtn = elementoEnPosicion?.closest('.reaction-option');
      
      if (emojiBtn && emojiBtn !== lastHighlightedEmoji) {
        // Remover resaltado del anterior
        if (lastHighlightedEmoji) {
          lastHighlightedEmoji.style.transform = 'scale(1) translateY(0)';
          lastHighlightedEmoji.removeAttribute('data-highlighted');
        }
        
        // Resaltar el actual
        emojiBtn.style.transform = 'scale(1.5) translateY(-10px)';
        emojiBtn.setAttribute('data-highlighted', 'true');
        lastHighlightedEmoji = emojiBtn;
        
        // Prevenir scroll solo si estamos sobre un emoji
        e.preventDefault();
      } else if (!emojiBtn && lastHighlightedEmoji) {
        // Quitamos del menú, remover resaltado
        lastHighlightedEmoji.style.transform = 'scale(1) translateY(0)';
        lastHighlightedEmoji.removeAttribute('data-highlighted');
        lastHighlightedEmoji = null;
      }
    } catch (err) {
      console.warn('Error en touchmove:', err);
    }
  }, { passive: false });

  function showMenu() {
    menuReacciones.classList.remove('hidden');
    menuReacciones.classList.add('show');
    
    // En móviles, esperar un frame para que se renderice antes de posicionar
    requestAnimationFrame(() => {
      posicionarMenuInteligentemente();
    });
  }

  function hideMenu() {
    menuReacciones.classList.remove('show');
    setTimeout(() => menuReacciones.classList.add('hidden'), 200);
  }

  function posicionarMenuInteligentemente() {
    const btnRect = btnPrincipal.getBoundingClientRect();
    const menuRect = menuReacciones.getBoundingClientRect();
    const viewportHeight = window.innerHeight;
    const viewportWidth = window.innerWidth;
    
    let top, left;
    
    // Intentar posicionar encima del botón (muy cerca)
    let positionAbove = btnRect.top - menuRect.height - 5; // Solo 5px de separación
    
    if (positionAbove > 0) {
      // Hay espacio arriba
      top = positionAbove;
    } else {
      // No hay espacio arriba, posicionar abajo
      top = btnRect.bottom + 5; // Solo 5px de separación
    }
    
    // Centrar horizontalmente relativo al botón
    left = btnRect.left + (btnRect.width / 2) - (menuRect.width / 2);
    
    // Ajustar si se sale por los lados
    const padding = 10;
    if (left < padding) {
      left = padding;
    } else if (left + menuRect.width > viewportWidth - padding) {
      left = viewportWidth - menuRect.width - padding;
    }
    
    // Aplicar la posición
    menuReacciones.style.top = top + 'px';
    menuReacciones.style.left = left + 'px';
    
    console.log('📍 Menú posicionado en:', { top, left });
  }

  // Ocultar menú al hacer click fuera
  document.addEventListener('click', (e) => {
    if (!reactionContainer.contains(e.target)) {
      hideMenu();
    }
  });

  // No cerrar menú si hay touch activo en él
  menuReacciones.addEventListener('touchstart', (e) => {
    e.stopPropagation();
  });

  // Reposicionar menú cuando cambie el tamaño de la ventana
  window.addEventListener('resize', () => {
    if (menuReacciones.classList.contains('show')) {
      setTimeout(() => posicionarMenuInteligentemente(), 50);
    }
  });

  reactionContainer.appendChild(btnPrincipal);
  reactionContainer.appendChild(menuReacciones);
  contenedor.appendChild(reactionContainer);
}

function updateMainButton(btn, emoji, hasReaction) {
  const displayEmoji = emoji || '❤️';
  const countText = hasReaction ? ' • 1' : '';

  btn.innerHTML = `
    <span class="reaction-emoji">${displayEmoji}</span>
    <span class="reaction-text"></span>
    <span class="reaction-count">${countText}</span>
  `;

  btn.className = `btn-reaction-main ${hasReaction ? 'reacted' : ''}`;
  console.log(`🔄 Botón actualizado - emoji: ${displayEmoji}, resaltado: ${hasReaction}`);
}


async function handleReaction(mensajeId, emoji, btnPrincipal, contenedor) {
  try {
    btnPrincipal.disabled = true;
    console.log(`${emoji} Procesando reacción...`);

    // 🔐 Verificar permisos antes de reaccionar
    if (window.rolesService && !await window.rolesService.canModify()) {
      alert('⚠️ Los invitados no pueden reaccionar a los mensajes.');
      return;
    }

    const result = await insertarOActualizarReaccion(mensajeId, emoji);
    console.log('✅ Resultado:', result);

    // Obtener estado actual después de la operación
    const currentEmoji = await obtenerEmojiActual(mensajeId);
    const hasReaction = !!currentEmoji;

    updateMainButton(btnPrincipal, currentEmoji, hasReaction);
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
    obtenerEmojiActual,
    suscribirReacciones,
    montarBotonesDeReaccion,
    DEFAULT_EMOJIS
  };
}
