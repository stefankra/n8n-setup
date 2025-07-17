# n8n custom build with Playwright + Tesseract (DE/EN/ES) + libs
FROM n8nio/n8n:1.97.1

USER root
RUN apt-get update && apt-get install -y \
    libnss3 libatk1.0-0 libatk-bridge2.0-0 libx11-xcb1 libxcb1 \
    libxcomposite1 libxdamage1 libxrandr2 libgbm1 libasound2 \
    libpangocairo-1.0-0 libcairo2 fonts-liberation libxss1 \
    libleptonica-dev tesseract-ocr tesseract-ocr-deu \
    tesseract-ocr-eng tesseract-ocr-spa \
 && rm -rf /var/lib/apt/lists/*; \
 echo "Deps installed."

USER node
WORKDIR /home/node/.n8n

# Local (not global) installs so n8n can require() them.
RUN npm install \
      playwright \
      cheerio \
      dayjs \
      luxon \
      lodash \
  && npx playwright install --with-deps

EXPOSE 5678
CMD ["n8n"]
