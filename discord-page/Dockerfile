FROM node:alpine as dependencies
WORKDIR /my-project
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile

FROM node:alpine as builder
ARG DISCORD_INVITE
ENV DISCORD_INVITE $DISCORD_INVITE
WORKDIR /my-project
COPY . .
COPY --from=dependencies /my-project/node_modules ./node_modules
RUN echo "NEXT_PUBLIC_DISCORD_INVITE=${DISCORD_INVITE}" >> .env.local
RUN yarn build

FROM node:alpine as runner
WORKDIR /my-project
ENV NODE_ENV production

# If you are using a custom next.config.js file, uncomment this line.
# COPY --from=builder /my-project/next.config.js ./
COPY --from=builder /my-project/.env.local ./
COPY --from=builder /my-project/public ./public
COPY --from=builder /my-project/.next ./.next
COPY --from=builder /my-project/node_modules ./node_modules
COPY --from=builder /my-project/package.json ./package.json

EXPOSE 3000
CMD ["yarn", "start"]