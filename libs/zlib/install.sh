#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv *.tar.* build
fi

PKG=$(get-pkg https://zlib.net/ zlib-1.2.11 tar.xz)

mkdir -p build && \
cd build && \
xtool cmake ../$PKG -GNinja \
    -DAMD64=ON \
&& ninja install
