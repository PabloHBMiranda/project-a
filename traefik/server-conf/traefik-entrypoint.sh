#!/bin/sh

CERT_DIR="etc/traefik/certs"
CERT_PATH="$CERT_DIR/cert.crt"
KEY_PATH="$CERT_DIR/cert.key"

echo "[traefik-entrypoint] Verificando certificados..."

# Verifica se mkcert está disponível
if ! command -v mkcert > /dev/null 2>&1; then
    echo "[traefik-entrypoint] ERRO: mkcert não encontrado."
    exit 1
fi

# Verifica se as variáveis estão definidas
if [ -z "$FRONTEND_DOMAIN" ] || [ -z "$BACKEND_DOMAIN" ]; then
    echo "[traefik-entrypoint] ERRO: FRONTEND_DOMAIN ou BACKEND_DOMAIN não definidos."
    exit 1
fi

# Cria pasta se não existir
mkdir -p /etc/traefik/certs

# Verifica se certificados já existem
if [ ! -f "$CERT_PATH" ] || [ ! -f "$KEY_PATH" ]; then
    echo "[traefik-entrypoint] Certificado não encontrado. Gerando com mkcert..."
    mkcert -cert-file "$CERT_PATH" -key-file "$KEY_PATH" "$FRONTEND_DOMAIN" "$BACKEND_DOMAIN"
else
    echo "[traefik-entrypoint] Certificados já existentes."
fi

LOG_DIR="/var/log"
LOG_FILE="$LOG_DIR/traefik.log"

if [ ! -f "$LOG_FILE" ]; then
  echo "[traefik-entrypoint] Arquivo de log não existe. Criando arquivo..."
  touch "$LOG_FILE"
fi

# Inicia o Traefik
echo "[traefik-entrypoint] Iniciando Traefik..."
exec traefik