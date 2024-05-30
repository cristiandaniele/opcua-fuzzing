#!/usr/bin/env bash

# Install dependencies
apt-get update && apt-get install libssl-dev cmake -y

cd UA-AnsiC-Legacy-1.04.342

# Build legacy OPC UA ANSI-C stack
mkdir build
cd build
export AFL_HARDEN=1
cmake -DCMAKE_C_COMPILER=afl-clang-fast -DCMAKE_CXX_COMPILER=afl-clang-fast++ ..
cmake --build .