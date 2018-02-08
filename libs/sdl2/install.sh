#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv build
fi

set-cross-env

mkdir -p build && \
cd build && \
../SDL-mirror/configure "${CONFIGURE_COMMON[@]}" \
    --enable-assertions=release \
    --disable-render \
    --disable-haptic \
    --disable-power \
    --disable-libsamplerate-shared \
    --disable-video-x11 \
    --disable-video-opengles1 \
    --disable-video-vulkan \
    --disable-dbus \
&& $MAKE install

echo 'Requires.private: samplerate' >> "$ROOT/local/lib/pkgconfig/sdl2.pc"
