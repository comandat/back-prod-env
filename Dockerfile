FROM n8nio/n8n:latest

USER root

# Instalăm Playwright Core (fără browsere, doar librăria)
RUN npm install -g playwright-core playwright-extra puppeteer-extra-plugin-stealth

# Permitem folosirea modulului
ENV NODE_FUNCTION_ALLOW_EXTERNAL=playwright-core,playwright-extra,puppeteer-extra-plugin-stealth

USER node
