
[ -f "common.sh" ] || exit 7

HOST=x86_64-apple-darwin15
ROOT="$PWD/osxcross/target"
CUSTOM="$PWD/osxcross-custom"
MAKE="make -j$(nproc)"

export PATH="$ROOT/local/bin:$PATH"
export PATH="$ROOT/bin:$PATH"
export PATH="$CUSTOM/bin:$PATH"

export CC=$HOST-clang
export CXX=$HOST-clang++
export AR=$HOST-ar
export RANLIB=$HOST-ranlib
export LD=$HOST-ld

export MACOSX_DEPLOYMENT_TARGET=10.7
export OSXCROSS_PKG_CONFIG_NO_MP_INC=1
unset OSXCROSS_PKG_CONFIG_USE_NATIVE_VARIABLES
unset OSXCROSS_PKG_CONFIG_PATH

for p in "$ROOT"/{local,.}/{lib,share}/pkgconfig; do
    if [ -z "$OSXCROSS_PKG_CONFIG_PATH" ]; then
        OSXCROSS_PKG_CONFIG_PATH="$p"
    else
        OSXCROSS_PKG_CONFIG_PATH="$OSXCROSS_PKG_CONFIG_PATH:$p"
    fi
done

export OSXCROSS_PKG_CONFIG_PATH

function xtool
{
    local tool="$HOST-$1"
    shift
    $tool "$@"
}

function get-src
{
    name="$1"
    url="$2"
    ext="$3"

    if [ ! -d "$name" ]; then
        wget "$url" || return 1
        tar xvf "$name.$ext" || return 1
    fi
}

function get-pkg
{
    url_prefix="$1"
    name="$2"
    ext="$3"

    get-src "${name}" "${url_prefix}${name}.${ext}" "${ext}" 1>&2

    printf "%s" "$name"
}

function log
{
    >&2 printf "%s: %s\n" "$0" "$1"
}
