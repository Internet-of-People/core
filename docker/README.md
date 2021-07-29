# IOP Hydra Core Docker

## Introduction

Official, production-ready IOP Hydra Core images available at [Docker Hub](https://hub.docker.com/r/internetofpeople/hydra-core).

## Run with Docker

Run these command below under the `docker` directory, after read the notes below as well.

### 1. Start PostgreSQL locally

    ```bash
    $ docker run -it --rm --name postgres-hydra -e POSTGRES_DB=hydra_[testnet|devnet|mainnet] -e POSTGRES_USER=hydra -e POSTGRES_PASSWORD=password postgres:11-alpine
    ```

### 2. Start Hydra Core locally

You can start the Hydra Core as a relay or forger; in normal or genesis mode; connecting to testnet/devnet/mainnet. You can do that by providing some extra parameters to the end of the docker command. If you provide none, it will use `testnet genesis auto_forge`.

```bash
# Observe the optional parameters in the end of the command:
$ docker ... internetofpeople/hydra-core:latest-[testnet|devnet|mainnet] [normal|genesis] [auto_forge|no_forge]
```

#### Example: Starting Up Forgers

```bash
# testnet
$ docker run --link postgres-hydra -it -p 4700:4700 -p 4703:4703 -p 4040:4040 --name core --rm --mount type=bind,src=${PWD}/config,dst=/root/config_overwrite internetofpeople/hydra-core:latest-testnet testnet normal auto_forge

# devnet
$ docker run --link postgres-hydra -it -p 4702:4702 -p 4703:4703 -p 4040:4040 --name core --rm --mount type=bind,src=${PWD}/config,dst=/root/config_overwrite internetofpeople/hydra-core:latest-devnet devnet normal auto_forge

# mainnet
$ docker run --link postgres-hydra -it -p 4701:4701 -p 4703:4703 -p 4040:4040 --name core --rm --mount type=bind,src=${PWD}/config,dst=/root/config_overwrite internetofpeople/hydra-core:latest-mainnet mainnet normal auto_forge
```

### 3. Start Hydra Block Explorer

By starting it you can connect to the either locally running Hydra Core or IOP's testnet/devnet/mainnet.

```bash
$ docker run --link core -it -p 80 --name explorer --rm internetofpeople/hydra-core:latest-[local|testnet|devnet|mainnet]
```

> Notes:
>
> -   you must have a `config` directory containing a [testnet|devnet|mainnet].env file. Under `docker` directory you have one by default for all networks.
> -   if you'd like to run a delegate, you can configurate it by providing its passphrase in the `config/delegates.json` file in a format: `{"secrets":["YOUR_DELEGATE_PASSPHRASE"]}`

## Run with Docker Compose

Docker Compose defines IOP's whole stack all together: database, Hydra Core and a block explorer.

You can start up these at once by running:

```bash
$ docker-compose -f docker-compose.[testnet|devnet|mainnet].yml up
```

> Notes:
>
> -   By default the node starts as a genesis, forging enabled. You can adjust it by editing the compose file.
> -   You can edit the configuration by editing the `config/[testnet|devnet|mainnet].env` file.
> -   In these compose scripts, the explorer connects to the locally running testnet/devnet/mainnet. You can connect to the IOP's testnet/devnet/mainnet too via adjusting explorer's image in the compose file to `latest-[testnet|devnet|mainnet].

## Upgrading

If you'd like to upgrade to the newest Hydra, you only have to pull new images then restart the services.

```bash
# Docker
$ docker pull internetofpeople/hydra-core:latest-[testnet|devnet|mainnet]
$ docker container restart core

# Docker Compose
$ docker-compose pull core
$ docker-compose up -d core
```

## Development

> NOTE: you must build images from the root of the hydra-core repository.

```bash
# Build
$ docker build -f docker/Dockerfile -t internetofpeople/hydra-core:latest-[testnet|devnet|mainnet] -t internetofpeople/hydra-core:[SEMANTIC_VERSION]-[testnet|devnet|mainnet] .
```

```bash
# Publish
$ docker login
$ docker push internetofpeople/hydra-core --all-tags # BE CAREFUL when publishing mainnet images.
```

### Local Testing Without Publishing

You can use the development package registry at npm.iop.technology by providing an extra build argument to docker. This way in the container yarn will use IOP's registry to install packages for Hydra Core, hence you can test easily new Hydra Plugin versions.

```bash
# Build
$ docker build -f docker/Dockerfile --build-arg USE_DEV_NPM=yes -t internetofpeople/hydra-core:rc-[testnet|devnet|mainnet] .
```
