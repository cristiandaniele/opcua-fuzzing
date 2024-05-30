#!/usr/bin/env bash

# Install dependencies
apt-get update && apt-get install libssl-dev cmake -y

cd targets/legacy-stack/UA-AnsiC-Legacy-1.04.342

# Build legacy OPC UA ANSI-C stack
mkdir build
cd build
cmake ..
cmake --build .

# Create symbolic link to target (example server)
cd ../../../../
ln -s targets/legacy-stack/UA-AnsiC-Legacy-1.04.342/build/bin/AnsiCServer /opt/app/target

exit 0
