# 1. Plecăm de la o imagine proaspătă de Linux (Debian 12)
FROM node:20-bookworm

# 2. Suntem automat root. Instalăm Chromium și dependențele de sistem.
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

# 3. Setăm calea către browser (folosim Chromium instalat mai sus)
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 4. Instalăm n8n și TOATE modulele necesare pentru Stealth și User Data
# Am adăugat: puppeteer-extra, stealth, user-data-dir și am păstrat user-preferences
RUN npm install -g n8n \
    puppeteer \
    n8n-nodes-puppeteer \
    puppeteer-extra \
    puppeteer-extra-plugin-stealth \
    puppeteer-extra-plugin-user-data-dir \
    puppeteer-extra-plugin-user-preferences

# 5. IMPORTANT: Configurare n8n pentru a permite importul modulelor externe
# Fără linia asta, n8n va bloca require('puppeteer-extra') din motive de securitate.
ENV NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer,puppeteer-extra,puppeteer-extra-plugin-stealth,puppeteer-extra-plugin-user-data-dir,puppeteer-extra-plugin-user-preferences

# 6. Trecem pe userul 'node' pentru a rula aplicația în siguranță
USER node

# 7. Pornim n8n
CMD ["n8n"]
