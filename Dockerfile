# ===================================================================
# Finales Dockerfile für ein robustes n8n-Setup (Version mit Fix)
# ===================================================================

# ===== Basis-Image: Hier wird die n8n-Version festgelegt =====
# Für ein Update einfach diese Zeile anpassen (z.B. auf n8nio/n8n:1.41.0)
FROM n8nio/n8n:1.39.1

# Wechsel zum root-Benutzer, um System-Pakete zu installieren
USER root

# ----- System-Abhängigkeiten für Playwright & Tesseract -----
# Diese sind für das Ausführen von Browsern und OCR notwendig
# Wir verwenden die ["/bin/sh", "-c", "..."] Form, um Shell-Fehler zu vermeiden.
RUN ["/bin/sh", "-c", "apt-get update && apt-get install -y libnss3 libatk1.0-0 libatk-bridge2.0-0 libx11-xcb1 libxcb1 libxcomposite1 libxdamage1 libxrandr2 libgbm1 libasound2 libpangocairo-1.0-0 libcairo2 fonts-liberation libxss1 libleptonica-dev tesseract-ocr tesseract-ocr-deu tesseract-ocr-eng tesseract-ocr-spa && rm -rf /var/lib/apt/lists/*"]

# Wechsel zurück zum Standard-Benutzer 'node'
USER node

# Arbeitsverzeichnis setzen. n8n nutzt dieses Verzeichnis für Daten,
# Konfiguration und das Laden von Modulen. Es wird auf ein Volume gemappt.
WORKDIR /home/node/.n8n

# ----- Node-Pakete (lokal im Arbeitsverzeichnis installieren) -----
# Wichtig: KEIN '-g' (global) Flag verwenden.
RUN npm install \
    playwright \
    cheerio \
    dayjs \
    luxon \
    lodash
    # ⇢ Zukünftige Pakete einfach hier in der Liste ergänzen.

# Notwendige Browser-Binaries für Playwright installieren
RUN npx playwright install --with-deps

# Den Port freigeben, auf dem n8n lauscht
EXPOSE 5678

# Standardbefehl zum Starten von n8n
CMD ["n8n"]
