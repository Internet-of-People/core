FROM node:12-alpine

COPY ./ /root/core-hydra

RUN apk add --update git python make g++

RUN cd ~/core-hydra && yarn setup

COPY docker/production/docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["testnet","genesis","auto_forge"]
