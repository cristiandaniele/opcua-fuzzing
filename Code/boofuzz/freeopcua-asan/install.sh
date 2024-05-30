#!/usr/bin/env bash

# Clone repository
git clone https://github.com/freeopcua/freeopcua.git
cd freeopcua
git checkout 6eac097

# Install cmake
apt-get update && apt-get install cmake -y

# Install dependencies listed in debian.soft
sed -i 's/libmbedtls-dev/libmbedtls-dev -y/g' debian.soft # Add -y to the end of apt-get command
./debian.soft

# Build freeopcua
mkdir build
cd build
cmake -DCMAKE_CXX_FLAGS="-fsanitize=address -fno-omit-frame-pointer" ..
make

# Copy example server
cp bin/example_server /opt/app/target

cd ../../

exit 0
