# IOP Hydra Core

<p align="center">
    <img src="banner.jpg" />
</p>

## Table of Contents <!-- omit in toc -->

- [Maintainers](#maintainers)
- [Introduction](#introduction)
- [Changelog](#changelog)
  - [2.6.31](#2631)
  - [2.6.10](#2610)
    - [Important Notes](#important-notes)
  - [2.5.9](#259)
- [Contributing](#contributing)
- [Documentation](#documentation)
  - [Developing IoP Hydra Core](#developing-iop-hydra-core)
    - [Prerequisites](#prerequisites)
    - [Cloning & Setup for hydra-core repo](#cloning--setup-for-hydra-core-repo)
- [Credits](#credits)
- [License](#license)

## Maintainers

-   [mudlee](https://github.com/mudlee)
-   [wigy](https://github.com/wigy-opensource-developer)
-   [bartmoss](https://github.com/izolyomi)

## Introduction

This repository contains the code for the IOP Hydra Blockchain. The IOP Hydra Blockchain is an ARK bridgechain and follows upstream changes as closely as possible.
Changes to naming schemes, documentation and other auxiliary files are thus kept to a minimum. If you want to learn more about the code, check out the original code base at [@ARKEcosystem](https://github.com/ARKEcosystem/core.git).

## Changelog

Below we describe what were the changes we made release by release compared to the original Ark code.

### 2.6.31+p3

-   IOP SSI updated to 4.0.2
-   Introduced IOP DNS (project Coeus).

### 2.6.31+p2

-   IOP SSI updated to 3.1.0

### 2.6.31+p1

-   IOP SSI updated to 2.0.6
-   Rate limiter settings changed
-   Wallet API emits event when started

### 2.6.31

-   Hydra Core updated to 2.6.31 (jemalloc can now be used as a default memory manager)
-   Jemalloc is used by the Docker images
-   IOP SSI updated to 2.0.5

### 2.6.10

-   IOP SSI added as a submodule (hence `plugins.js` config files were updated as well)
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

Please visit our [Developer Portal](https://iop-stack.iop.rocks/dids-and-claims/specification/#/).

### Developing IOP Hydra Core Locally

In the following section we help you to setup a local testnet where you update Hydra Core's code and test locally with a testnet setup.

#### Prerequisites

The following packages are required before you clone this repository.

1. [Nodejs](https://nodejs.org/en/)
2. [Git](https://git-scm.com/)
3. [Docker](https://www.docker.com/)
4. [Docker Compose](https://docs.docker.com/compose/install/)
5. [Yarn](https://yarnpkg.com/en/)

#### Step 1. Clone & Setup hydra-core Repo

```bash
# Clone the hydra core repo.
$ git clone git@github.com:Internet-of-People/hydra-core.git
$ cd hydra-core
```

```bash
# Install Python 2 if you don't have it, due to this bug: https://github.com/JoshuaWise/better-sqlite3/issues/310

# On Ubuntu
$ sudo apt install python2
```

##### Developing Hydra Core Only

```bash
# Move into the repo and run setup. `setup` hook will install all necessary Javascript dependencies to get you up and running with Hydra core.
$ yarn setup
```

##### Developing Morpheus/Coeus

If you'd like to develop Morpheus or Coeus code, run the below command to setup the code.
This command requires the [morpheus-ts repo](https://github.com/Internet-of-People/morpheus-ts) to be cloned out to the same directory, where `hydra-core` sits.

```bash
# Under the morpheus-ts repo, follow the installation procedure
$ npm install
$ npm run build
```

And then, go back to the `hydra-core` repo and run the following command:

```bash
$ ./init-iop-dev-env.sh
```

This command will symlink the morpheus-ts repo to the right place and sets up everything you need.

#### Step 2. Start PostgreSQL via Docker

First, navigate to the `docker/testnet` directory and unpack the default testnet config:

```bash
$ tar -xvf mountpoints.tar.gz
```

Second, run the command below to start a PostgreSQL container.

```bash
$ NETWORK=testnet MODE=normal FORGING_MODE=no_forge docker-compose up -d postgres
```

#### Step 3. Start Hydra Core

To start Hydra core, navigate back to the repo's root and then run the following commands:

```bash
# Reset/Create the config
$ ./packages/core/bin/run config:reset --network=testnet

# Start a local testnet
$ ./packages/core/bin/run core:run --network=testnet --ignoreMinimumNetworkReach --networkStart --env=test
```

## Credits

This project exists thanks to all the people who [contribute](../../contributors).

## License

Ark Core is released under the [MIT](LICENSE) © [ARK Ecosystem](https://ark.io)
Changes for IOP Hydra are released under the [MIT](LICENSE) © 2020 Decentralized Society Foundation PA
