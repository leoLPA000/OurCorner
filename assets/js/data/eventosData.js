/**
 * Datos de Eventos Especiales
 * Sistema de gestión de eventos temporales para OurCorner
 */

const eventosEspeciales = [
    {
        id: 'navidad-2024',
        nombre: 'Calendario de Adviento',
        icono: '🎄',
        fecha: '24 de Diciembre, 2024',
        descripcion: 'Cuenta regresiva especial hacia Navidad con sorpresas cada día',
        url: 'calendario-adviento.html',
        activo: true,
        color: '#2d5016' // Verde navideño
    },
    {
        id: 'anio-nuevo-2025',
        nombre: 'Fuegos de Año Nuevo',
        icono: '🎆',
        fecha: '31 de Diciembre, 2024',
        descripcion: 'Celebremos juntos la llegada del nuevo año con fuegos artificiales mágicos',
        url: 'fuegos-artificiales.html',
        activo: true,
        color: '#ffd700' // Dorado festivo
    },
    {
        id: 'san-valentin-2025',
        nombre: 'Día del Amor',
        icono: '💝',
        fecha: '14 de Febrero, 2025',
        descripcion: 'Celebración especial de nuestro amor con mensajes románticos y sorpresas',
        url: '#', // Evento de prueba
        activo: true,
        color: '#ff1744' // Rojo amor
    },
    {
        id: 'aniversario-2025',
        nombre: 'Nuestro Aniversario',
        icono: '🎂',
        fecha: '8 de Octubre, 2025',
        descripcion: 'Un año juntos celebrando nuestro amor infinito',
        url: '#', // Evento de prueba
        activo: true,
        color: '#e91e63' // Rosa celebración
    },
    {
        id: 'primavera-2025',
        nombre: 'Bienvenida Primavera',
        icono: '🌸',
        fecha: '21 de Marzo, 2025',
        descripcion: 'Celebremos la llegada de la primavera con flores y amor',
        url: '#', // Evento de prueba
        activo: true,
        color: '#f48fb1' // Rosa primavera
    },
    {
        id: 'verano-2025',
        nombre: 'Aventuras de Verano',
        icono: '☀️',
        fecha: '21 de Junio, 2025',
        descripcion: 'Recuerdos especiales de nuestro verano juntos',
        url: '#', // Evento de prueba
        activo: true,
        color: '#ffb300' // Amarillo sol
    }
    // Más eventos se pueden agregar aquí
    // Ejemplo:
    // {
    //     id: 'san-valentin-2025',
    //     nombre: 'Día del Amor',
    //     icono: '💝',
    //     fecha: '14 de Febrero, 2025',
    //     descripcion: 'Celebración especial de nuestro amor',
    //     url: 'san-valentin.html',
    //     activo: true,
    //     color: '#ff1744'
    // }
];

/**
 * Obtener todos los eventos
 */
function obtenerEventos() {
    return eventosEspeciales;
}

/**
 * Obtener eventos activos
 */
function obtenerEventosActivos() {
    return eventosEspeciales.filter(evento => evento.activo);
}

/**
 * Obtener evento por ID
 */
function obtenerEventoPorId(id) {
    return eventosEspeciales.find(evento => evento.id === id);
}

/**
 * Obtener total de páginas del libro (2 eventos por página)
 */
function obtenerTotalPaginas() {
    return Math.ceil(eventosEspeciales.length / 2);
}
