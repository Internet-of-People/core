FROM node:11-alpine

COPY ./ /root/core-hydra

RUN apk add --update git python make g++

# PM2
RUN yarn global add pm2 && \
    echo 'export PATH=$PATH:/root/.yarn/bin' >> ~/.bashrc && \
    source ~/.bashrc

RUN cd ~/core-hydra && yarn setup

COPY docker/production/docker-entrypoint.sh /usr/local/bin/
RUN ln -s usr/local/bin/docker-entrypoint.sh / # backwards compat

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["testnet","genesis","auto_forge"]