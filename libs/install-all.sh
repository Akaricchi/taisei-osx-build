#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd .. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

TARGETS=(
    zlib
    bzip2
    binutils
    libpng
    libjpeg-turbo
    libogg
    libvorbis
    libsamplerate
    freetype
    libzip
    sdl2
    sdl2_mixer
    sdl2_ttf
    sdl2_image
)

for target in ${TARGETS[*]}; do
    echo " *** TARGET: $target"
    $target/install.sh "$@" || exit 1
done
