#!/bin/bash

cd "$(dirname "$0")" || exit 1
pushd osxcross >/dev/null || exit 1
export UNATTENDED=1
rm -rf target || exit $?
./build.sh || ./build.sh || exit $?
popd >/dev/null || exit 1
libs/install-all.sh -c
