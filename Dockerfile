FROM node:20.11.0-alpine

VOLUME node_modules:/app/webshop/node_modules

WORKDIR /app/webshop

COPY package.json .
COPY package-lock.json .

RUN npm install

COPY . /app/webshop/

RUN npm run build

ENV NUXT_HOST=0.0.0.0
ENV NUXT_PORT=3000


EXPOSE 3000

ENTRYPOINT ["node", ".output/server/index.mjs"]

# Run command: "docker build . -t nuxt_webshop && docker run -it -p 3000:3000 nuxt_webshop"