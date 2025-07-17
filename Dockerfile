FROM n8nio/n8n:1.97.1

USER root
RUN apt-get update && apt-get install -y \
    # Playwright-Prereqs:
    gconf-service libasound2 libatk1.0-0 libcups2 libdbus-1-3 \
    libgconf-2-4 libgtk-3-0 libx11-xcb1 libxcomposite1 libxdamage1 \
    libxrandr2 libgbm1 libpango1.0-0 libxss1 libxtst6 \
    fonts-liberation libnss3 lsb-release xdg-utils wget \
    # Tesseract-Prereqs:
    libleptonica-dev tesseract-ocr tesseract-ocr-deu \
    tesseract-ocr-eng tesseract-ocr-spa \
  && rm -rf /var/lib/apt/lists/*

USER node
WORKDIR /home/node/.n8n

COPY package.json package-lock.json ./
RUN npm ci
RUN npm install playwright cheerio dayjs luxon lodash \
  && npx playwright install --with-deps

EXPOSE 5678
CMD ["n8n"]
