# 1. Plecăm de la o imagine proaspătă de Linux (Debian 12)
FROM node:20-bookworm

# 2. Suntem automat root. Instalăm Chromium, Xvfb și dependențele de sistem.
USER root

# Am adăugat 'xvfb' în lista de pachete
RUN apt-get update && apt-get install -y \
    chromium \
    xvfb \
    libnss3 \
    libfreetype6 \
    libharfbuzz0b \
    ca-certificates \
    fonts-freefont-ttf \
    nodejs \
    npm \
    git \
    && rm -rf /var/lib/apt/lists/*

# 3. Setăm calea către browser
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 4. Instalăm n8n și modulele necesare (Stealth, Extra, User-Data)
RUN npm install -g n8n \
    puppeteer \
    n8n-nodes-puppeteer \
    puppeteer-extra \
    puppeteer-extra-plugin-stealth \
    puppeteer-extra-plugin-user-data-dir \
    puppeteer-extra-plugin-user-preferences

# ... (restul fișierului rămâne la fel până la pasul 5) ...

# 5. Configurare n8n
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer,puppeteer-extra,puppeteer-extra-plugin-stealth,puppeteer-extra-plugin-user-data-dir,puppeteer-extra-plugin-user-preferences

# 6. Setăm variabila DISPLAY global (Astfel orice proces va ști unde e ecranul)
ENV DISPLAY=:99

# 7. Trecem pe userul 'node'
USER node

# 8. Comanda de start modificată:
# Pornim Xvfb pe portul 99 în background (&), așteptăm 2 secunde să se inițieze, apoi pornim n8n
CMD ["sh", "-c", "Xvfb :99 -screen 0 1920x1080x24 -ac & sleep 2 && n8n"]
