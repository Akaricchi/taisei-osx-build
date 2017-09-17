#!/bin/bash

SRCDIR="$1"; shift
BUILDDIR="$1"; shift

if [[ -z "$SRCDIR" ]] || [[ -z "$BUILDDIR" ]]; then
    >&2 echo "Usage: $0 <taisei source dir> <build dir>"
    exit 1
fi

pushd "$SRCDIR" >/dev/null || exit $?
SRCDIR="$PWD"
popd >/dev/null || exit $?

pushd "$BUILDDIR" >/dev/null || exit $?
BUILDDIR="$PWD"
popd >/dev/null || exit $?

cd "$(dirname "$0")" >/dev/null || exit $?
source common.sh || exit $?
TOOLROOT="$PWD"

mkdir -p "$BUILDDIR" || exit $?
cd "$BUILDDIR" || exit $?

cat << EOF > reconfigure.sh
#!/bin/bash
exec "$(readlink -f $0)" "$SRCDIR" "$BUILDDIR" "\$@"
EOF

chmod +x reconfigure.sh || exit $?
xtool cmake "$SRCDIR" -GNinja \
    -DCMAKE_INSTALL_PREFIX:FILEPATH="$BUILDDIR/install" \
    -DOSX_LIB_PATH="$ROOT/local/lib" \
    -DOSX_TOOL_PATH="$ROOT/bin:$ROOT/local/bin" \
    -DOSX_TOOL_PREFIX="$HOST-" \
"$@"
