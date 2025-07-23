# ===============================
# 1. Stage: Dependências
# ===============================
FROM node:22-alpine AS deps
WORKDIR /app
COPY package*.json ./
RUN npm install

# ===============================
# 2. Stage: Build
# ===============================
FROM node:20-alpine AS builder
WORKDIR /app
COPY . .
COPY --from=deps /app/node_modules ./node_modules
RUN npm run build

# ===============================
# 3. Stage: Produção
# ===============================
FROM node:20-alpine AS runner
WORKDIR /app
ENV NODE_ENV=production
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/package*.json ./
RUN npm install --omit=dev
EXPOSE 3000
CMD ["npm", "run", "start:prod"]