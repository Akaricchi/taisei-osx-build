#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv build
fi

PKG=$(get-pkg https://downloads.sourceforge.net/project/libjpeg-turbo/1.5.3/ libjpeg-turbo-1.5.3 tar.gz)

set-cross-env

mkdir -p build && \
cd build && \
../$PKG/configure "${CONFIGURE_COMMON[@]}" \
    --with-jpeg8 \
    --without-turbojpeg \
&& $MAKE install
