#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv build
fi

PKG=libwebp

set-cross-env

cd "$PKG" && \
./autogen.sh && \
cd .. && \
mkdir -p build && \
cd build && \
../$PKG/configure "${CONFIGURE_COMMON[@]}" \
    --disable-everything \
    --enable-threading \
    --enable-libwebpdecoder \
    --disable-gif \
    --disable-gl \
    --disable-jpeg \
    --disable-png \
    --disable-sdl \
    --disable-tiff \
    --disable-wic \
&& $MAKE install
