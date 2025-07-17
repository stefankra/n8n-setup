# ─── Basis: offizielles n8n Alpine Image ──────────────────────────────
FROM n8nio/n8n:1.97.1

USER root

# ─── System‑Pakete via apk (kein apt‑get!) ─────────────────────────────
RUN apk add --no-cache \
      libnss3 libatk1.0 \
      libatk-bridge2.0 libx11-xcb libxcb \
      libxcomposite libxdamage libxrandr libgbm \
      libasound libxss \
      libleptonica tesseract-ocr tesseract-ocr-data-deu \
      tesseract-ocr-data-eng tesseract-ocr-data-spa

USER node
WORKDIR /home/node/.n8n           # → persistenter Volume‑Mount

# ─── Node‑Pakete lokal installieren (kein -g!) ─────────────────────────
RUN npm install \
      playwright \
      cheerio \
      dayjs \
      luxon \
      lodash && \
    npx playwright install --with-deps

EXPOSE 5678
CMD ["n8n"]
