FROM traefik:v3.5

# Instala mkcert e dependências
RUN apk add --no-cache curl nss openssl \
    && curl -L https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64 -o /usr/local/bin/mkcert \
    && chmod +x /usr/local/bin/mkcert \
    && mkcert -install
