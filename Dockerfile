FROM node:alpine
WORKDIR /usr/yourapplication-name
COPY package.json .
RUN yarn
COPY . .
RUN npm run build
CMD ["node", "./dist/index.js"]