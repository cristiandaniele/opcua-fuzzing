#!/bin/sh

# Install cmake
apt-get update && apt-get install cmake -y

# Clone repository
git clone https://github.com/freeopcua/freeopcua.git
cd freeopcua
git checkout 6eac097

# Install dependencies using apt-get command listed in debian.soft
sed -i 's/libmbedtls-dev/libmbedtls-dev -y/g' debian.soft # Add -y to the end of apt-get command
./debian.soft

# Build freeopcua
mkdir build
cd build
AFL_HARDEN=1 cmake -DCMAKE_C_COMPILER=afl-clang-fast -DCMAKE_CXX_COMPILER=afl-clang-fast++ ..
make
