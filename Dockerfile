# Use the official n8n image as the base image
FROM docker.n8n.io/n8nio/n8n:latest

# Install Puppeteer and Chromium as root
USER root
RUN npm install -g puppeteer
RUN apk add --no-cache chromium

# Switch back to the node user for security and compliance with best practices
USER node
