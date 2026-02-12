## 💌 Valentine Card Project

Un proyecto Next.js interactivo para crear y compartir tarjetas personalizadas de San Valentín.

## ✨ Características

- 🎨 **Canvas de Dibujo**: Crea dibujos personalizados con texturas realistas
- 📝 **Mensajes Personalizados**: Nombres de emisor y receptor
- 💬 **Frases Románticas**: Selección de citas románticas
- 🔗 **Enlaces Compartibles**: Genera URLs únicas para compartir
- 🖼️ **Galería Pública**: Visualiza tarjetas compartidas por otros usuarios
- 📊 **Analíticas**: Seguimiento de tarjetas creadas (Supabase)
- 🌐 **Responsive**: Funciona en móvil y escritorio

## 🚀 Inicio Rápido

### 1. Configurar Supabase

1. Crea un proyecto en [Supabase](https://supabase.com)
2. Ejecuta el script `supabase-setup.sql` en el SQL Editor
3. Obtén tus credenciales (URL + Anon Key)

### 2. Configurar Variables de Entorno

Copia `.env.local` y agrega tus credenciales:

```env
NEXT_PUBLIC_SUPABASE_URL=https://tu-proyecto.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=tu-clave-aqui
```

### 3. Instalar y Ejecutar

```bash
pnpm install
pnpm dev
```

Abre [http://localhost:3000](http://localhost:3000)

## 📦 Estructura del Proyecto

```
valentine/
├── src/
│   ├── app/
│   │   ├── components/     # Componentes React
│   │   ├── lib/           # Cliente Supabase
│   │   └── utils/         # Utilidades (encode, templates)
├── public/                # Imágenes y assets estáticos
├── .env.local            # Variables de entorno (NO subir a Git)
├── supabase-setup.sql    # Script de configuración DB
└── DEPLOY.md             # Guía completa de despliegue
```

## 🗄️ Base de Datos

El proyecto usa 3 tablas en Supabase:

- **cards**: Galería pública de tarjetas
- **card_logs**: Analíticas de creación
- **shared_cards**: Tarjetas con enlaces cortos

Ver `supabase-setup.sql` para más detalles.

## 🌐 Despliegue

Ver la [Guía Completa de Despliegue](DEPLOY.md) para instrucciones detalladas.

### Despliegue Rápido en Vercel

[![Deploy with Vercel](https://vercel.com/button)](https://vercel.com/new)

1. Importa el repositorio en Vercel
2. Agrega las variables de entorno
3. Deploy automático

## 🛠️ Tecnologías

- **Next.js 16** - Framework React
- **TypeScript** - Tipado estático
- **Tailwind CSS 4** - Estilos
- **Supabase** - Base de datos y backend
- **Framer Motion** - Animaciones
- **Canvas API** - Dibujo personalizado
- **LZ-String** - Compresión de datos para URLs

## 📄 Licencia

Este proyecto es privado y parte del ecosistema **OurCorner**.

## 🔗 Enlaces

- **Proyecto Principal**: [OurCorner](https://github.com/tu-usuario/OurCorner)
- **Documentación Supabase**: [docs/SUPABASE-DOCS.md](../docs/README-SUPABASE.md)

---

**Hecho con ❤️ por el equipo OurCorner**

