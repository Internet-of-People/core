#!/bin/sh

# Backups configurations before local building Hydra core
cp plugins/iop/package.json plugins/iop/package.json.bak
cp plugins/iop/package.json.dev plugins/iop/package.json
cp package.json package.json.bak
cp lerna.json lerna.json.bak
python3 -c "import sys, json; f = open('./lerna.json','rt'); j = json.load(f); j['packages'].append('morpheus/packages/*'); open('./lerna.json','w').write(json.dumps(j, indent=4))"
python3 -c "import sys, json; f = open('./package.json','rt'); j = json.load(f); j['workspaces'].append('morpheus/packages/*'); open('./package.json','w').write(json.dumps(j, indent=4))"

# Symlinks the iop-ts repo to the root
ln -s -T ../morpheus-ts ./morpheus > /dev/null 2>&1
rm -rf ./morpheus/node_modules > /dev/null 2>&1
find ./morpheus/packages/ -iname dist -exec rm -rf \{\} \; > /dev/null 2>&1
find ./morpheus/packages/ -iname node_modules -exec rm -rf \{\} \; > /dev/null 2>&1
mkdir -p ./node_modules
ln -s -T ../hydra-core/node_modules ../morpheus-ts/node_modules

# Setup Hydra core
yarn setup

# Restores the original configs
mv plugins/iop/package.json.bak plugins/iop/package.json
mv lerna.json.bak lerna.json
mv package.json.bak package.json