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

# 5. Configurare n8n pentru a permite importul modulelor externe
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer,puppeteer-extra,puppeteer-extra-plugin-stealth,puppeteer-extra-plugin-user-data-dir,puppeteer-extra-plugin-user-preferences

# 6. Trecem pe userul 'node'
USER node

# 7. Pornim n8n în spatele unui monitor virtual (Xvfb)
# Setăm rezoluția la 1920x1080 pentru a părea un PC normal
CMD ["sh", "-c", "xvfb-run --auto-servernum --server-args='-screen 0 1920x1080x24' n8n"]
