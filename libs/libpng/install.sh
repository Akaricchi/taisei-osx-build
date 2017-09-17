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
xtool cmake ../libpng -GNinja \
    -DPNG_SHARED=ON \
    -DPNG_TESTS=OFF \
    -DPNGARG=ON \
&& ninja install
