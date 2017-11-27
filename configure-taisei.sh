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

cat << EOF > xtool
#!/bin/bash
exec "$TOOLROOT/xtool.sh" "\$@"
EOF

cat << EOF > htool
#!/bin/bash
exec "$TOOLROOT/htool.sh" "\$@"
EOF

cat << EOF > meson
#!/bin/bash
exec "$TOOLROOT/xtool.sh" meson "\$@"
EOF

cat << EOF > ninja
#!/bin/bash
exec "$TOOLROOT/htool.sh" ninja "\$@"
EOF

chmod +x xtool htool meson ninja || exit $?

xtool meson "$SRCDIR" \
    --backend ninja \
    --prefix="$BUILDDIR/install" \
    -Dmacos_lib_path="$ROOT/local/lib" \
    -Dmacos_tool_path="$ROOT/bin:$ROOT/local/bin" \
    -Dmacos_tool_prefix="$HOST-" \
"$@"
