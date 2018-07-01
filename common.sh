
[ -f "common.sh" ] || exit 7

HOST=x86_64-apple-darwin15
ROOT="$PWD/osxcross/target"
CUSTOM="$PWD/osxcross-custom"
MAKE="make -j$(nproc)"

CONFIGURE_COMMON=(
    --disable-option-checking
    --host="$HOST"
    --prefix="$ROOT/local"
    --libdir="$ROOT/local/lib"
    --disable-shared
    --enable-static
    --disable-docs
    --disable-examples
    --disable-sdltest
    --disable-silent-rules
)

if [ -z "${__TAISEIOSXCROSS_COMMON_INCLUDED}" ]; then
    export __TAISEIOSXCROSS_COMMON_INCLUDED="yes"

    export PATH="$ROOT/local/bin:$PATH"
    export PATH="$ROOT/bin:$PATH"
    export PATH="$CUSTOM/bin:$PATH"

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
fi

function set-cross-env {
    export PREFIX="$ROOT/local"
    export CC=$HOST-clang
    export CXX=$HOST-clang++
    export AR=$HOST-ar
    export RANLIB=$HOST-ranlib
    export LD=$HOST-ld

    local optflags="-O3 -march=core2 -mtune=intel -flto"
    local cppflags="-D_FORTIFY_SOURCE=2 -I${PREFIX}/include"
    local cflags="-fpic -fstack-protector-strong"
    local ldflags="$optflags -fpic -L${PREFIX}/lib"

    export CFLAGS="$CFLAGS $cflags $cppflags $optflags"
    export CPPFLAGS="$CFLAGS $cppflags"
    export CXXFLAGS="$CXXFLAGS $cflags $cppflags $optflags"
    export LDFLAGS="$LDFLAGS $ldflags"
}

function xtool {
    local tool="$HOST-$1"
    shift
    $tool "$@"
}

function xwhich {
    which ${HOST}-$1
}

function get-src {
    name="$1"
    url="$2"
    ext="$3"

    if [ ! -d "$name" ]; then
        wget "$url" || return 1
        tar xvf "$name.$ext" || return 1
    fi
}

function get-pkg {
    url_prefix="$1"
    name="$2"
    ext="$3"

    get-src "${name}" "${url_prefix}${name}.${ext}" "${ext}" 1>&2

    printf "%s" "$name"
}

function log {
    >&2 printf "%s: %s\n" "$0" "$1"
}
