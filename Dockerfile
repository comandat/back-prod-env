# 1. Folosim explicit versiunea DEBIAN (asta garanteaza ca apt-get exista)
FROM n8nio/n8n:latest-debian

USER root

# 2. Instalam Chromium si dependintele necesare (metoda sigura Debian/Ubuntu)
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

# 3. Setam variabilele pentru Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium

# 4. Instalam Puppeteer global SI n8n-nodes-puppeteer (ca sa ai si nodul dorit!)
RUN npm install -g puppeteer n8n-nodes-puppeteer

# 5. Instalam plugin-ul in folderul n8n ca sa apara in meniu
RUN mkdir -p /home/node/.n8n/nodes && \
    cd /home/node/.n8n/nodes && \
    npm install n8n-nodes-puppeteer

USER node
