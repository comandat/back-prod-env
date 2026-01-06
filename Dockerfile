# 1. Plecam de la imaginea oficiala n8n (care acum este Debian-based)
FROM n8nio/n8n:latest

USER root

# 2. Actualizam lista de pachete si instalam Chromium + dependintele pentru Debian
# Folosim apt-get in loc de apk
RUN apt-get update && apt-get install -y \
    chromium \
    libnss3 \
    libfreetype6 \
    libharfbuzz0b \
    ca-certificates \
    fonts-freefont-ttf \
    nodejs \
    npm \
    && rm -rf /var/lib/apt/lists/*

# 3. Spunem sistemului unde se afla Chromium (pe Debian e in /usr/bin/chromium)
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 4. Instalam libraria Puppeteer global
RUN npm install -g puppeteer

USER node
