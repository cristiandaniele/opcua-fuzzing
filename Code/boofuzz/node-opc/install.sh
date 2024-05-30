#!/usr/bin/env bash

apt-get update && apt-get install -y npm

curl -sL https://deb.nodesource.com/setup_14.x | bash -
apt-get install -y nodejs

npm install node-opcua@2.107.0 --save

git clone https://github.com/node-opcua/node-opcua -b v2.107.0

cp targets/node-opc/target target

exit 0
