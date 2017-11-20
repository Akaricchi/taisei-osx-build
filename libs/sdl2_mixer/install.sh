#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv *.tar.* build
fi

PKG=$(get-pkg https://www.libsdl.org/projects/SDL_mixer/release/ SDL2_mixer-2.0.2 tar.gz)

CFLAGS+="-I$ROOT/local/include "
CFLAGS+="-I$ROOT/local/include/vorbis "
CFLAGS+="-L$ROOT/local/lib "
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
    --enable-music-ogg \
    --disable-music-ogg-shared \
    --disable-music-cmd \
    --disable-music-mp3 \
    --disable-music-mod \
    --disable-music-midi \
    --disable-music-flac \
    --disable-smpegtest \
&& $MAKE install
