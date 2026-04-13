FROM node:20-alpine

WORKDIR /app
RUN apk update && apk upgrade
COPY package*.json ./

RUN npm ci --only=production

COPY . .

USER node

EXPOSE 8080

CMD ["node", "server.js"]
