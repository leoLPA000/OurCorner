import type { Metadata, Viewport } from "next";
import { Geist, Geist_Mono, Chewy } from "next/font/google";
import { Analytics } from "@vercel/analytics/next"
import "./globals.css";

const geistSans = Geist({
  variable: "--font-geist-sans",
  subsets: ["latin"],
});

const geistMono = Geist_Mono({
  variable: "--font-geist-mono",
  subsets: ["latin"],
});

const chewy = Chewy({
  weight: "400",
  subsets: ["latin"],
  variable: "--font-chewy",
});

export const viewport: Viewport = {
  themeColor: "#FF2D55",
  colorScheme: "light",
  width: "device-width",
  initialScale: 1,
  maximumScale: 5,
  userScalable: true,
};

export const metadata: Metadata = {
  metadataBase: new URL("https://tu-dominio-aqui.vercel.app"),
  title: "Will You Be My Valentine?",
  description: "Una forma única e interactiva de preguntar '¿Quieres ser mi San Valentín?'. Una experiencia personalizada con dibujos y mensajes especiales.",
  applicationName: "Valentine Card",
  authors: [{ name: "OurCorner" }],
  generator: "Next.js",
  keywords: [
    "will you be my valentine",
    "will you be my valentine game",
    "will you be my valentine online",
    "will you be my valentine link",
    "will you be my valentine card",
    "will you be my valentine website",
    "will you be my valentine free",
    "valentine",
    "valentines day",
    "valentine card",
    "valentine ideas",
    "willyoubemyvalentine",
    "14 feb",
    "14 february",
    "14 feb 2026",
    "digital valentine",
    "valentine link",
    "online valentine",
    "valentine game",
    "valentine app",
    "ask valentine online",
    "send valentine link",
    "create valentine card",
    "interactive valentine proposal",
    "how to ask valentine 2026",
    "cute valentine ways",
    "funny valentine ask",
    "free valentine website",
    "no login valentine card"
  ],
  referrer: "origin-when-cross-origin",
  creator: "OurCorner Team",
  publisher: "OurCorner Team",
  robots: {
    index: true,
    follow: true,
    googleBot: {
      index: true,
      follow: true,
      "max-video-preview": -1,
      "max-image-preview": "large",
      "max-snippet": -1,
    },
  },
  openGraph: {
    type: "website",
    locale: "es_ES",
    url: "https://tu-dominio-aqui.vercel.app",
    title: "Will You Be My Valentine?",
    description: "Una forma única e interactiva de preguntar '¿Quieres ser mi San Valentín?'. ¡Envía una experiencia personalizada que no podrán rechazar! 💌",
    siteName: "Valentine Card",
    images: [
      {
        url: "/willyoubemyvalentine.webp",
        width: 1200,
        height: 630,
        alt: "Will you be my Valentine Preview",
      },
    ],
  },
  twitter: {
    card: "summary_large_image",
    title: "Will You Be My Valentine?",
    description: "Una forma única e interactiva de preguntar '¿Quieres ser mi San Valentín?'. ¡Envía una experiencia personalizada! 💌",
    images: ["/willyoubemyvalentine.webp"],
    creator: "@ourcorner_app",
  },
  icons: {
    icon: "/favicon.ico",
    shortcut: "/favicon.ico",
    apple: "/apple-touch-icon.png",
  },
  alternates: {
    canonical: "https://tu-dominio-aqui.vercel.app",
  },
};

const jsonLd = {
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "WebSite",
      "name": "Will you be my valentine ?",
      "url": "https://tu-dominio-aqui.vercel.app",
      "potentialAction": {
        "@type": "SearchAction",
        "target": "https://tu-dominio-aqui.vercel.app/?q={search_term_string}",
        "query-input": "required name=search_term_string"
      }
    },
    {
      "@type": "SoftwareApplication",
      "name": "Will You Be My Valentine Game",
      "applicationCategory": "GameApplication",
      "operatingSystem": "Any",
      "offers": {
        "@type": "Offer",
        "price": "0",
        "priceCurrency": "USD"
      }
    },
    {
      "@type": "FAQPage",
      "mainEntity": [
        {
          "@type": "Question",
          "name": "What is the best way to ask 'Will you be my Valentine'?",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "The best way to ask is with a creative, interactive surprise that they can't say no to. Our 'Will you be my Valentine' game lets you send a personalized link that reveals the big question in a fun, memorable way."
          }
        },
        {
          "@type": "Question",
          "name": "How to ask 'Will you be my valentine' appropriately?",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "The best way is to be unique and personal. Sending a creative digital experience like our interactive 'Will You Be My Valentine' game is a fun, low-pressure way to ask the big question."
          }
        },
        {
          "@type": "Question",
          "name": "What is a unique digital valentine idea?",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "Instead of a generic e-card, use an interactive web app where your partner can play a game, scratch a card, or see a personalized drawing. It shows effort and creativity."
          }
        },
        {
          "@type": "Question",
          "name": "Is this Valentine website free to use?",
          "acceptedAnswer": {
            "@type": "Answer",
            "text": "Yes, this interactive Valentine proposal tool is 100% free to use and share with your loved one."
          }
        }
      ]
    }
  ]
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body
        className={`${geistSans.variable} ${geistMono.variable} ${chewy.variable} antialiased`}
      >
        {children}
        <Analytics />
        <script
          type="application/ld+json"
          dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
        />
      </body>
    </html>
  );
}
