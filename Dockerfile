# ─── 1. Basis und System‐Deps ─────────────────────────────────────
FROM n8nio/n8n:1.97.1-debian
USER root

RUN apt-get update && apt-get install -y \
      libnss3 libatk1.0-0 libatk-bridge2.0-0 libx11-xcb1 libxcb1 \
      libxcomposite1 libxdamage1 libxrandr2 libgbm1 libasound2 \
      libpangocairo-1.0-0 libcairo2 fonts-liberation libxss1 \
      libleptonica-dev tesseract-ocr tesseract-ocr-deu \
      tesseract-ocr-eng tesseract-ocr-spa \
    && rm -rf /var/lib/apt/lists/*

# ─── 2. Node‐Deps lokal installieren ─────────────────────────────
USER node
WORKDIR /home/node/.n8n

RUN npm install \
      playwright \
      cheerio \
      dayjs \
      luxon \
      lodash \
    && npx playwright install --with-deps

EXPOSE 5678
CMD ["n8n"]
