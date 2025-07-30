# Usando Node 22 para desenvolvimento
FROM node:22 as base

RUN apt-get update \
    && apt-get install -y vim socat \
# Limpa o cache e desabilita pacotes do apt
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Define diretório de trabalho
RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

FROM base AS builder

# Instala as dependencias NODE antes de copiar os arquivos da aplicação para diminuir a quantidade de builds quando eles forem alterados
COPY package.json /usr/src/app/
RUN yarn install \
    && npx browserslist@latest --update-db

COPY . .

# Não é definida no ENV porque depois que o container é montado a imagem não consegue redefinir o seu valor
ARG CURRENT_VERSION
RUN mkdir -p /opt/project.d \
    && echo "CURRENT_VERSION=\"${CURRENT_VERSION}\"" >> /opt/project.d/project.conf

# Copia os arquivos da aplicação e gera o build
COPY . /usr/src/app

RUN yarn build

FROM base

COPY --from=builder /usr/src/app /usr/src/app

CMD ["yarn", "start"]