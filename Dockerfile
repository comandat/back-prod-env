# 1. Imaginea de bază
FROM node:20-bookworm

# 2. Instalări (root)
USER root

# Instalăm chromium, xvfb și utilitarele necesare
RUN apt-get update && apt-get install -y \
    chromium \
    xvfb \
    libnss3 \
    libfreetype6 \
    libharfbuzz0b \
    ca-certificates \
    fonts-freefont-ttf \
    git \
    && rm -rf /var/lib/apt/lists/*

# 3. Variabile de mediu
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium \
    # IMPORTANT: Permitem modulele externe
    NODE_FUNCTION_ALLOW_EXTERNAL=puppeteer,puppeteer-extra,puppeteer-extra-plugin-stealth,puppeteer-extra-plugin-user-data-dir,puppeteer-extra-plugin-user-preferences

# 4. Instalăm modulele Puppeteer Extra
RUN npm install -g n8n \
    puppeteer \
    n8n-nodes-puppeteer \
    puppeteer-extra \
    puppeteer-extra-plugin-stealth \
    puppeteer-extra-plugin-user-data-dir \
    puppeteer-extra-plugin-user-preferences

# 5. Trecem pe userul 'node'
USER node

# 6. COMANDA CHEIE (Aici folosim xvfb-run)
# --auto-servernum: Găsește singur un port liber (evită erorile de lock)
# --server-args: Setează rezoluția ecranului virtual la 1920x1080
# n8n: Comanda finală care va rula în acest mediu grafic
CMD ["xvfb-run", "--auto-servernum", "--server-args=-screen 0 1920x1080x24", "n8n"]
