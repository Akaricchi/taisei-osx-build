#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv *.tar.* build
fi

PKG=$(get-pkg https://www.libsdl.org/projects/SDL_ttf/release/ SDL2_ttf-2.0.14 tar.gz)

CFLAGS+="-I$ROOT/local/include "
CPPFLAGS+="$CFLAGS"

export CFLAGS
export CPPFLAGS

set-cross-env

mkdir -p build && \
cd build && \
../$PKG/configure \
    --host="$HOST" \
    --prefix="$ROOT/local" \
    --enable-shared \
    --enable-static \
    --disable-sdltest \
&& $MAKE install
