#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv build
fi

PKG=$(get-pkg https://download.savannah.gnu.org/releases/freetype/ freetype-2.9 tar.gz)

set-cross-env

mkdir -p build && \
cd build && \
../$PKG/configure "${CONFIGURE_COMMON[@]}" \
    --disable-biarch-config \
    --with-harfbuzz=no \
&& $MAKE install
