FROM nucleodev/nginx:latest

# Instala as dependências do sistema
RUN apt-get update

COPY nginx/server-conf/. /etc/nginx

