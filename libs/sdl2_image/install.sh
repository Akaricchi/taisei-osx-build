#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv build
fi

PKG=$(get-pkg https://www.libsdl.org/projects/SDL_image/release/ SDL2_image-2.0.3 tar.gz)

set-cross-env

mkdir -p build && \
cd build && \
../$PKG/configure "${CONFIGURE_COMMON[@]}" \
    --disable-imageio \
    --disable-bmp \
    --disable-gif \
    --disable-lbm \
    --enable-pcx \
    --enable-png \
    --disable-png-shared \
    --disable-pnm \
    --disable-svg \
    --disable-tga \
    --disable-tif \
    --disable-tif-shared \
    --disable-xcf \
    --disable-xpm \
    --disable-xv \
    --disable-webp \
    --disable-webp-shared \
    --enable-jpg \
    --disable-jpg-shared \
&& $MAKE install

echo 'Requires.private: libpng, libjpeg' >> "$ROOT/local/lib/pkgconfig/SDL2_image.pc"
