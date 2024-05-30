#!/bin/sh

# Install dependencies
sudo apt-get install git make llvm-dev clang graphviz-dev libgraphviz-dev libcap-dev -y

# Clone repository
git clone https://github.com/aflnet/aflnet.git aflnet
cd aflnet
git checkout 213c9cf

# Copy modified AFLNet source code
cp ../{aflnet.h,aflnet.c,aflnet-replay.c,afl-fuzz.c} .

# Build AFLNet
make clean all

export LLVM_CONFIG=llvm-config-10
cd llvm_mode
make

# Export environment variables
cd ../..
export AFLNET=$(pwd)/aflnet
export WORKDIR=$(pwd)
export PATH=$PATH:$AFLNET
export AFL_PATH=$AFLNET