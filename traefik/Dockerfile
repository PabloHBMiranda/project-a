# Use uma imagem completa para baixar o mkcert
FROM alpine:3.18 as cert_builder

# Instala as dependências necessárias para gerar certificados com openssl
RUN apk add --no-cache openssl

# Imagem final do Traefik
FROM traefik:v3.5

# Copia o executável do openssl da imagem de build
COPY --from=cert_builder /usr/bin/openssl /usr/bin/openssl