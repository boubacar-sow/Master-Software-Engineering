FROM node:18-slim
WORKDIR /usr/src/app
COPY package.json ./
RUN npm install --only=production
COPY app.js ./
EXPOSE 3000
CMD ["node", "app.js"]