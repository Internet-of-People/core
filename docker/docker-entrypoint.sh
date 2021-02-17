#!/bin/sh
set -e


if [ ! -d "$HOME/.config/hydra-core" ]; then
  echo "Configs need to be generated..."
  /root/core-hydra/packages/core/bin/run config:publish --network=$1

  if [ -d "/root/config_overwrite/" ]; then
    echo "Config overwrides provided, copying to its final place..."
    cp -a /root/config_overwrite/. "/root/.config/hydra-core/$1"
    mv /root/.config/hydra-core/$1/$1.env /root/.config/hydra-core/$1/.env
  fi

  if [ ! -z "$DONT_USE_ENV_FILE" ]; then
    echo "Instructed NOT to use .env file. Deleting it..."
    rm /root/.config/hydra-core/$1/.env
  fi

  if [ -f /root/.config/hydra-core/$1/bip39 ]; then
    bip39=$(cat /root/.config/hydra-core/$1/bip39)
    echo "Got BIP39 passphrase, updating config..."
    /root/core-hydra/packages/core/bin/run config:forger:bip39 --bip39 "$bip39"
  fi

  echo "Configs generated."
fi

if [ $1 = "testnet" ]; then
  env="test"
else
  env="production"
fi

if [ $3 = "auto_forge" ]; then
  if [ $2 = "genesis" ]; then
    echo "Starting in genesis mode with auto forging..."
    /root/core-hydra/packages/core/bin/run core:run --network=$1 --ignoreMinimumNetworkReach --networkStart --env=$env
    echo "Started."
  else
    echo "Starting in normal mode with auto forging..."
    /root/core-hydra/packages/core/bin/run core:run --network=$1
    echo "Started."
  fi
else
  if [ $2 = "genesis" ]; then
    echo "Starting in genesis mode with relay only..."
    /root/core-hydra/packages/core/bin/run relay:run --network=$1 --ignoreMinimumNetworkReach --networkStart --env=$env
    echo "Started."
  else
    echo "Starting in normal mode with relay only..."
    /root/core-hydra/packages/core/bin/run relay:run --network=$1
    echo "Started."
  fi  
fi
