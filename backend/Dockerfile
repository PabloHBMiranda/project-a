# Etapa base (com pacotes extras)
FROM node:22 AS base

RUN apt-get update \
    && apt-get install -y vim socat \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Define diretório de trabalho
RUN mkdir -p /usr/src/app

WORKDIR /usr/src/app

# Etapa builder
FROM base AS builder

# Copia apenas arquivos de dependências primeiro (cache eficiente)
COPY package.json yarn.lock ./

# Instala dependências incluindo devDependencies
RUN yarn install --frozen-lockfile

# Copia o restante do código
COPY . .

# Copia .env (se necessário)
COPY .env ./

# Build do projeto
RUN yarn build

# Etapa final (produção)
FROM base AS production

WORKDIR /usr/src/app

# Copia package.json e yarn.lock
COPY package.json yarn.lock ./

# Instala apenas dependências de produção
RUN yarn install --frozen-lockfile --production

# Copia apenas dist e arquivos necessários
COPY --from=builder /usr/src/app/dist ./dist

# Exposição da porta
EXPOSE 3001

# Comando para rodar a aplicação
CMD ["node", "dist/main.js"]