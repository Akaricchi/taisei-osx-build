#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd .. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

TARGETS=(
    zlib
    binutils
    libpng
    libogg
    libvorbis
    freetype
    libzip
    sdl2
    sdl2_mixer
    sdl2_ttf
)

for target in ${TARGETS[*]}; do
    echo " *** TARGET: $target"
    $target/install.sh "$@" || exit 1
done
