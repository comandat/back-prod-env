# 1. Plecăm de la o imagine proaspătă de Linux (Debian 12)
FROM node:20-bookworm

# 2. Suntem automat root, dar e bine să știm. Instalam Chromium.
USER root

RUN apt-get update && apt-get install -y \
    chromium \
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

# 4. Instalăm n8n, Puppeteer și PLUGIN-UL LIPSA (tot ca root)
# Am adaugat 'puppeteer-extra-plugin-user-preferences' la finalul listei
RUN npm install -g n8n puppeteer n8n-nodes-puppeteer puppeteer-extra-plugin-user-preferences

# 5. IMPORTANT: Trecem pe userul 'node' pentru a rula aplicația în siguranță
USER node

# 6. Pornim n8n
CMD ["n8n"]
