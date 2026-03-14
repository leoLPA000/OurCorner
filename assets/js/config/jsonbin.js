// Configuración de JSONBin.io para sincronización de firmas
const JSONBIN_CONFIG = {
  masterKey: '$2a$10$CEizI6AbZejb3vGYqCZ6v.pOnwA3rIk.LyY4B.zzDSCkYgtWKJjWG',
  binId: null, // Se creará automáticamente en el primer uso
  apiUrl: 'https://api.jsonbin.io/v3'
};

// Funciones para gestionar firmas sincronizadas
const FirmasSync = {
  // Obtener el Bin ID desde localStorage
  getBinId() {
    return localStorage.getItem('jsonbin_firmas_id');
  },

  // Guardar el Bin ID en localStorage
  setBinId(binId) {
    localStorage.setItem('jsonbin_firmas_id', binId);
    JSONBIN_CONFIG.binId = binId;
  },

  // Crear un nuevo bin para las firmas
  async crearBin() {
    try {
      const response = await fetch(`${JSONBIN_CONFIG.apiUrl}/b`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'X-Master-Key': JSONBIN_CONFIG.masterKey
        },
        body: JSON.stringify({
          evento1: '',
          evento2: '',
          evento3: '',
          evento4: ''
        })
      });

      if (!response.ok) {
        throw new Error('Error al crear el bin');
      }

      const data = await response.json();
      this.setBinId(data.metadata.id);
      return data.metadata.id;
    } catch (error) {
      console.error('Error creando bin:', error);
      return null;
    }
  },

  // Cargar firmas desde JSONBin
  async cargarFirmas() {
    let binId = this.getBinId();

    // Si no existe el bin, crearlo
    if (!binId) {
      binId = await this.crearBin();
      if (!binId) return null;
    }

    try {
      const response = await fetch(`${JSONBIN_CONFIG.apiUrl}/b/${binId}/latest`, {
        method: 'GET',
        headers: {
          'X-Master-Key': JSONBIN_CONFIG.masterKey
        }
      });

      if (!response.ok) {
        throw new Error('Error al cargar firmas');
      }

      const data = await response.json();
      return data.record;
    } catch (error) {
      console.error('Error cargando firmas:', error);
      return null;
    }
  },

  // Guardar firmas en JSONBin
  async guardarFirmas(firmas) {
    let binId = this.getBinId();

    // Si no existe el bin, crearlo
    if (!binId) {
      binId = await this.crearBin();
      if (!binId) return false;
    }

    try {
      const response = await fetch(`${JSONBIN_CONFIG.apiUrl}/b/${binId}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/json',
          'X-Master-Key': JSONBIN_CONFIG.masterKey
        },
        body: JSON.stringify(firmas)
      });

      if (!response.ok) {
        throw new Error('Error al guardar firmas');
      }

      return true;
    } catch (error) {
      console.error('Error guardando firmas:', error);
      return false;
    }
  },

  // Guardar una firma individual (debounced para no hacer muchas peticiones)
  debounceTimers: {},
  async guardarFirmaIndividual(eventoId, texto) {
    // Cancelar timer anterior si existe
    if (this.debounceTimers[eventoId]) {
      clearTimeout(this.debounceTimers[eventoId]);
    }

    // Esperar 2 segundos después de que el usuario deje de escribir
    this.debounceTimers[eventoId] = setTimeout(async () => {
      const firmasActuales = await this.cargarFirmas();
      if (firmasActuales) {
        firmasActuales[eventoId] = texto;
        await this.guardarFirmas(firmasActuales);
        console.log(`✅ Firma ${eventoId} sincronizada`);
      }
    }, 2000);
  }
};
