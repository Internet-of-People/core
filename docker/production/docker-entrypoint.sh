#!/bin/sh
set -e

if [ ! -d "$HOME/.config/hydra-core" ]; then
  echo "Configs need to be generated..."
  /root/core-hydra/packages/core/bin/run config:publish --network=$1
  cp -a /root/config_overwrite/. "/root/.config/hydra-core/$1"
  mv /root/.config/hydra-core/$1/$1.env /root/.config/hydra-core/$1/.env

  if [ -f /root/.config/hydra-core/$1/bip39 ]; then
    bip39=$(cat /root/.config/hydra-core/$1/bip39)
    echo "Got BIP39 passphrase, updating config..."
    /root/core-hydra/packages/core/bin/run config:forger:bip39 --bip39 "$bip39"
  fi

  echo "Configs generated."
fi

if [ $3 = "auto_forge" ]; then
  if [ $2 = "genesis" ]; then
    echo "Starting in genesis mode with auto forging..."
    /root/core-hydra/packages/core/bin/run core:start --network=$1 --ignoreMinimumNetworkReach --networkStart --no-daemon
    echo "Started."
  else
    echo "Starting in normal mode with auto forging..."
    /root/core-hydra/packages/core/bin/run core:start --network=$1 --no-daemon
    echo "Started."
  fi
else
  if [ $2 = "genesis" ]; then
    echo "Starting in genesis mode with relay only..."
    /root/core-hydra/packages/core/bin/run relay:start --network=$1 --ignoreMinimumNetworkReach --networkStart --no-daemon
    echo "Started."
  else
    echo "Starting in normal mode with relay only..."
    /root/core-hydra/packages/core/bin/run relay:start --network=$1 --no-daemon
    echo "Started."
  fi  
fi
