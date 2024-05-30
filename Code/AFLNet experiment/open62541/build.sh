#!/bin/sh

# Install APT packages
apt-get install cmake -y

# Remove previous repository
rm -r open62541

# Clone repository and check out specific commit
git clone https://github.com/open62541/open62541.git
cd open62541
git checkout 46d0395
git submodule update --init --recursive

# Copy modified server_ctt.c that allows for anonymous authentication
cp ../server_ctt.c examples

# Build open62541 with examples
AFL_HARDEN=1 cmake -DCMAKE_C_COMPILER=afl-clang-fast -DCMAKE_CXX_COMPILER=afl-clang-fast++ -DBUILD_SHARED_LIBS=ON -DUA_BUILD_EXAMPLES=ON DUA_ENABLE_ENCRYPTION=OFF ../open62541
make -j1
make install

# Copy server and build client
cd ..
cp open62541/bin/examples/server_ctt .
afl-clang-fast -std=c99 -DUA_ARCHITECTURE_POSIX client_anonymous.c -lopen62541 -o client_anonymous