#!/bin/bash

echo -n "Your BIP39 Passphrase: "
read -s passphrase

echo -n $passphrase > ./mountpoints/config_overwrite/bip39

MODE=normal FORGING_MODE=auto_forge docker-compose up -d postgres
MODE=normal FORGING_MODE=auto_forge docker-compose up -d core
