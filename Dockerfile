FROM node:lts

RUN mkdir -p /usr/src/app && \
    chown -R node:node /usr/src/app
WORKDIR /usr/src/app

RUN apt-get update && apt-get install -y jq

ARG NODE_ENV

ENV NODE_ENV $NODE_ENV
ENV REDIS_HOST $REDIS_HOST
ENV REDIS_PASSWORD $REDIS_PASSWORD
ENV REDIS_PORT $REDIS_PORT

COPY --chown=node:node install/package.json /usr/src/app/package.json

COPY --chown=node:node create_config.sh /usr/src/app/create_config.sh

RUN /usr/src/app/create_config.sh

USER node

RUN npm install && \
    npm cache clean --force

COPY --chown=node:node . /usr/src/app

ENV NODE_ENV=production \
    daemon=false \
    silent=false

EXPOSE 4567

CMD test -n "${SETUP}" && ./nodebb setup || node ./nodebb build; node ./nodebb start
