#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv build
fi

PKG=$(get-pkg https://libzip.org/download/ libzip-1.5.1 tar.xz)

set-cross-env

mkdir -p build && \
cd build && \
xtool cmake ../$PKG \
&& $MAKE install
