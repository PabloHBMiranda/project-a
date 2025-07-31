#!/bin/sh
set -e

CERT_DIR="/etc/traefik/certs"
CERT_PATH="$CERT_DIR/cert.pem"
KEY_PATH="$CERT_DIR/key.pem"

echo "[traefik-entrypoint] Verificando certificados..."

# Verifica se as variáveis de domínio estão definidas
if [ -z "$FRONTEND_DOMAIN" ] || [ -z "$BACKEND_DOMAIN" ]; then
    echo "[traefik-entrypoint] ERRO: As variáveis FRONTEND_DOMAIN ou BACKEND_DOMAIN não estão definidas."
    exit 1
fi

# Cria o diretório de certificados se ele não existir
mkdir -p "$CERT_DIR"

# Gera os certificados apenas se eles não existirem
if [ ! -f "$CERT_PATH" ] || [ ! -f "$KEY_PATH" ]; then
    echo "[traefik-entrypoint] Certificados não encontrados. Gerando com mkcert..."
    mkcert -cert-file "$CERT_PATH" -key-file "$KEY_PATH" "$FRONTEND_DOMAIN" "$BACKEND_DOMAIN"

    # Garante que a chave privada seja legível pelo processo do Traefik
    chmod 644 "$KEY_PATH"
    echo "[traefik-entrypoint] Permissões da chave privada ajustadas."
else
    echo "[traefik-entrypoint] Certificados já existentes."
fi

# Inicia o processo principal do Traefik
echo "[traefik-entrypoint] Iniciando Traefik..."
exec traefik
