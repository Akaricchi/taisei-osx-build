#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv build
fi

PKG=$(get-pkg https://zlib.net/ zlib-1.2.11 tar.xz)
#PKG=$(get-pkg https://sortix.org/libz/release/ libz-1.2.8.2015.12.26 tar.gz)

set-cross-env

mkdir -p build && \
cd build && \
../$PKG/configure \
    --prefix="$PREFIX" \
    --libdir="$PREFIX/lib" \
    --static \
    --64 \
&& $MAKE install
