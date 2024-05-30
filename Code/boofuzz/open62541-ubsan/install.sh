#!/usr/bin/env bash

apt-get update && apt-get install -y build-essential cmake

git clone https://github.com/open62541/open62541.git
(
  cd open62541 || exit 1
  
  git checkout 46d0395

  git submodule update --init --recursive
)

cp /opt/app/targets/open62541-ubsan/CMakeLists.txt /opt/app/open62541

mkdir -p target_build
(
  cd target_build || exit 1

  cmake -DBUILD_SHARED_LIBS=ON -DUA_BUILD_EXAMPLES=ON ../open62541

  make -j1

  make install
)

cp target_build/bin/examples/server_ctt target

exit 0
