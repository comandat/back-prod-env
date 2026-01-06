# 1. Plecam de la imaginea oficiala n8n
FROM n8nio/n8n:latest

# 2. Trecem pe userul root ca sa putem instala programe
USER root

# 3. Instalam Chromium si dependintele necesare pentru Puppeteer
# Acestea sunt bibliotecile de sistem ca sa ruleze browserul pe server
RUN apk add --no-cache \
    chromium \
    nss \
    freetype \
    harfbuzz \
    ca-certificates \
    ttf-freefont \
    nodejs \
    npm

# 4. Spunem sistemului unde se afla Chromium si sa nu-l mai descarce Puppeteer
ENV PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true \
    PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

# 5. Instalam libraria Puppeteer global ca sa o vada n8n
RUN npm install -g puppeteer

# 6. Ne intoarcem la userul 'node' pentru securitate (standard n8n)
USER node
