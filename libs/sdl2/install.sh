#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv build
fi

mkdir -p build && \
cd build && \
xtool cmake ../SDL-mirror -GNinja \
    -DVIDEO_X11=OFF \
    -DVIDEO_VULKAN=OFF \
    -DSDL_RENDER=OFF \
    -DSDL_SHARED=ON \
    -DSDL_STATIC=ON \
&& ninja && ninja install && ninja || exit $?

# sdl's install rule seems broken here, doesn't install the actual dylib for some reason
find . -maxdepth 1 -type f -name '*.dylib' | while read f; do
    cp -v "$f" "$ROOT/local/lib/" || exit 1
done
