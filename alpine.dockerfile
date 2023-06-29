FROM node:20-alpine3.17

LABEL maintainer="Gatovsky | L20530228@cancun.tecnm.mx"

RUN apk update && apk upgrade \
    && apk add --no-cache git \
    wget \
    curl \
    ca-certificates \
    openssl \
    vim \
    npm \
    bash

RUN npm install -g sass && \
    npm install --force -g npm@9.7.2 \
    && npm install --force -g expo-cli \
    && npm install --force -g yarn

WORKDIR /home/node/salsona
RUN chown -R node:node /home/node/salsona
USER node

RUN echo "alias l='ls -aF'" > ~/.bash_aliases \
    && echo "alias ll='ls -ahlF'" > ~/bash_aliases \
    && echo "alias ls='ls --color=auto --group-directories-first'" > bash_aliases

CMD [ "bash" ]
