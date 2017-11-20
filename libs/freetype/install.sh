#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv *.tar.* build
fi

PKG=$(get-pkg https://download.savannah.gnu.org/releases/freetype/ freetype-2.8 tar.gz)

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
    --disable-shared \
    --enable-static \
    --disable-biarch-config \
    --with-harfbuzz=no \
&& $MAKE install
