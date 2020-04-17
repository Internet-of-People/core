# IoP Hydra Core Docker

## Introduction

Official Production ready IoP Hydra Core images available now at [Docker Hub](https://hub.docker.com/r/internetofpeople/hydra-core).

## Usage

### Install

To be able to use IoP Hydra with docker, you need two things from either the `testnet`, `devnet` or `mainnet` folder:

-   The `docker-compose.yml` file.
-   The `mountpoints.tar.gz` file unpacked to the same directory level where you put the `docker-compose.yml`.

### Overwrite Config

If you need to overwrite the published configs under `~/.config/hydra-core/[testnet|devnet|mainnet]`, you can put files under `mountpoints/config_overwrite`. These files will be copied over to the config directory when the Docker container starts up.
Use this if you need to update the `delegates.json` for example.

### Start

#### Full Stack

```bash
# Start Database, Hydra, Explorer
$ NETWORK=[testnet|devnet|mainnet] MODE=[genesis|normal] FORGING_MODE=[auto_forge|no_forge] docker-compose up -d
```

#### IoP Hydra Only

```bash
# Start Database, Hydra
$ NETWORK=[testnet|devnet|mainnet] MODE=[genesis|normal] FORGING_MODE=[auto_forge|no_forge] docker-compose up -d postgres
$ NETWORK=[testnet|devnet|mainnet] MODE=[genesis|normal] FORGING_MODE=[auto_forge|no_forge] docker-compose up -d core
```

### Upgrading

If you'd like to upgrade to the newest Hydra, you only have to pull new images then restart the services.

```bash
$ NETWORK=[testnet|devnet|mainnet] MODE=[genesis|normal] FORGING_MODE=[auto_forge|no_forge] docker-compose pull core
$ docker-compose stop core
$ docker-compose start core
```

## Development

> NOTE: you must build images from the root of the hydra-core repository.
> NOTE: you must have morpheus submodule already intialized and updated with `git submodule update --init --recursive --remote`.

```bash
# Build
$ docker build -f docker/Dockerfile -t internetofpeople/hydra-core:latest-[testnet|devnet|mainnet] -t internetofpeople/hydra-core:[SEMANTIC_VERSION]-[testnet|devnet|mainnet] .
```

```bash
# Publish
$ docker login
$ docker push internetofpeople/hydra-core
```
