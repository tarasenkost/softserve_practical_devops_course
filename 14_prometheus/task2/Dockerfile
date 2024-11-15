FROM node:18-alpine

WORKDIR /app

ENV APP_PORT="3000" \
    REDIS_ADDRESS="redis" \ 
    REDIS_PORT="6379" 

COPY package.json package-lock.json* ./

RUN npm ci && npm cache clean --force

COPY . .

EXPOSE 3000

CMD ["node", "./src/app.js"]
