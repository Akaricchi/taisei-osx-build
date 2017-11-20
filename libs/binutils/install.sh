#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv binutils-*
fi

PKG=$(get-pkg https://ftp.gnu.org/gnu/binutils/ binutils-2.29 tar.xz)

cd $PKG && \
./configure \
    --target="$HOST" \
    --prefix="$ROOT/local" \
    --enable-lto \
&& $MAKE && $MAKE install
