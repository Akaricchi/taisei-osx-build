#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd ../.. >/dev/null || exit 1
source common.sh || exit 1
popd >/dev/null || exit 1

if [[ "$1" = "-c" ]]; then
    rm -rfv *.tar.* build
fi

xtool meson -Dlib_type=static bzip2 build || exit $?
ninja -C build || exit $?
ninja -C build install || exit $?
