# Hydra Core Docker

## Introduction

Official Production ready Hydra Core images available now at [Docker Hub](https://hub.docker.com/r/internetofpeople/hydra-core).

## API Documentation

-   API v1 : https://docs.ark.io/api/public/v1/
-   API v2 : https://docs.ark.io/api/public/v2/

## Usage

**Overwrite Config**
If you need to overwrite the published configs under `~/.config/hydra-core/[testnet|devnet|mainnet]`, you can put files under `docker/mountpoints/config_overwrite`. These files will be copied over to the config directory.
Use this if you need to update the delegates.json for example.

**Start**

```bash
$ export NETWORK=[testnet|devnet|mainnet] && export MODE=[genesis|normal] && export FORGING_MODE=[auto_forge|no_forge] && docker-compose up -d
```

## Development

> NOTE: you must build images from the root of the hydra-core.

```bash
# Build
$ docker build -f docker/production/Dockerfile -t internetofpeople/hydra-core:[SEMANTIC_VERSION] -t internetofpeople/hydra-core:latest .
```

```bash
# Publish
$ docker login
$ docker push internetofpeople/hydra-core
```
