# Hydra Core

<p align="center">
    <img src="banner.jpg" />
</p>

## Table of Contents <!-- omit in toc -->

-   [Maintainers](#maintainers)
-   [Introduction](#introduction)
-   [Changelog](#changelog)
-   [Contributing](#contributing)
-   [Documentation](#documentation)
    -   [Developing on Devnet](#developing-on-devnet)
        -   [Prerequisites](#prerequisites)
        -   [Cloning & Setup for hydra-core repo](#cloning--setup-for-hydra-core-repo)
        -   [Steps to Setup Devnet](#steps-to-setup-devnet)
-   [API Documentation](#api-documentation)
-   [Credits](#credits)
-   [License](#license)

## Maintainers

-   [Anfauglith](https://github.com/Anfauglith)
-   [mudlee](https://github.com/mudlee)
-   [wigy](https://github.com/wigy-opensource-developer)

## Introduction

This repository contains the code for the Hydra Blockchain. The Hydra Blockchain is an ARK bridgechain and follows upstream changes as closely as possible.
Changes to naming schemes, documentation and other auxiliary files are thus kept to a minimum. If you want to learn more about the code, check out the original code base at [@ARKEcosystem](https://github.com/ARKEcosystem/core.git).

## Changelog

Below we describe what were the changes we made release by release compared to the original Ark code.

### 2.6.10

-   Morpheus Plugin added as a submodule (hence `plugins.js` config files were updated as well)
-   Custom Docker scripts and [images](https://hub.docker.com/repository/docker/internetofpeople/hydra-core) are updated
-   Fix: During `BlockApplied` and `BlockReverted` events the block's data must contain the transactions:
    -   at: <https://github.com/ArkEcosystem/core/blob/master/packages/core-database/src/database-service.ts#L92>
    -   and: <https://github.com/ArkEcosystem/core/blob/master/packages/core-database/src/database-service.ts#L448>

#### Important Notes

This is a mandatory upgrade. To be able to use Hydra, you must upgrade your `plugins.js` file in order to be part of the consensus.

##### Core Controller

If you are using [core-controler](https://github.com/Internet-of-People/core-control), we have now there a `develop` and soon a `master` branch where you can read how you can upgrade your code.

##### Docker

If you are using Docker, we provide a `mountpoints.tar.gz` file for each network which you can unpack (and overwrite) as it's described in our Docker documentation.

### 2.5.9

-   Custom Docker scripts added
-   Chain network (p2p, api, webhook ports), config (database password/user/dbname, peers, delegates) and crypto (milestones, exceptions, genesis block, network) parameters are changed
-   Added a delegate guide
-   Fix: Removed genesis block hacking from <https://github.com/ArkEcosystem/core/blob/master/packages/crypto/src/blocks/block.ts#L100>

## Contributing

PRs that are inline with our goals to the core IOP user experience are
more than welcome. To avoid losing precious time you spend on coding, you could
open an issue first and discuss what you are up to before forking and sending us
a PR.

Small note: If editing the README, please conform to the
[standard-readme](https://github.com/RichardLitt/standard-readme) specification.

## Documentation

-   Development: <https://docs.ark.io/guidebook/core/development.html>
-   Docker: <https://docs.ark.io/guidebook/core/docker.html>

### Developing on Devnet

#### Prerequisites

The following packages are required before you clone this repository.

1. [Nodejs](https://nodejs.org/en/)
2. [Git](https://git-scm.com/)
3. [Docker](https://www.docker.com/)
4. [Yarn](https://yarnpkg.com/en/)

#### Cloning & Setup for hydra-core repo

```bash
# Clone the hydra core repo.
$ git clone git@github.com:Internet-of-People/hydra-core.git
$ cd hydra-core
```

```bash
# Update the morpheus plugin to its latest version.
$ git submodule update --init --force --remote
```

```bash
# Move into the repo and run setup. `setup` hook will install all necessary Javascript dependencies to get you up and running with Hydra core.
$ yarn setup
```

#### Steps to Setup Devnet

##### Setup Postgres DB

Run the following command. Check that you dont already have a volume setup for `postgres-hydra`.

```bash
docker volumes ls
```

If you don't have `postgres-hydra` volume already, set it up using the following command.

```bash
# From core, navigate to `docker/production`. From within this directory, run the following command. This will start up a Postgres container with the necessary settings to work with Hydra core.
NETWORK=devnet MODE=normal FORGING_MODE=no_forge docker-compose up -d postgres
```

##### Setup Config and Start devnet

This will reset the config and enable you to start the `devnet` with your new configs.

```bash
./packages/core/bin/run config:reset --network=devnet
./packages/core/bin/run relay:run --network=devnet
```

##### Stop and Restart

Use ctrl+c to stop and `./packages/core/bin/run relay:run --network=devnet` to restart.

## API Documentation

-   API v1: <https://docs.ark.io/api/public/v1/>
-   API v2: <https://docs.ark.io/api/public/v2/>

## Credits

This project exists thanks to all the people who [contribute](../../contributors).

## License

Ark Core is released under the [MIT](LICENSE) © [ARK Ecosystem](https://ark.io)
Changes for Hydra are released under the [MIT](LICENSE) © 2020 Decentralized Society Foundation PA
