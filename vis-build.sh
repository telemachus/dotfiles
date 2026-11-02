#!/usr/bin/env dash
# Build vis editor with all dependencies isolated in $HOME/local/vis
# Dependencies: C compiler, make, autoconf, automake, libtool, git, curl
set -u

PREFIX="$HOME/local/vis"
SRCDIR="$HOME/Downloads/src/vis-build"
WRAPPER="$HOME/bin/vise"

# URLs for tarballs
LUA_VERSION="5.3.6"
LUA_URL="https://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz"

LIBTERMKEY_VERSION="0.22"
LIBTERMKEY_URL="https://www.leonerd.org.uk/code/libtermkey/libtermkey-${LIBTERMKEY_VERSION}.tar.gz"

LPEG_VERSION="1.1.0"
LPEG_URL="https://www.inf.puc-rio.br/~roberto/lpeg/lpeg-${LPEG_VERSION}.tar.gz"

# Git repos
UNIBILIUM_REPO="https://github.com/mauke/unibilium.git"
TRE_REPO="https://github.com/laurikari/tre.git"
VIS_REPO="https://github.com/telemachus/vis.git"

# ----------------------------------------------------------------------
# Helper functions
# ----------------------------------------------------------------------

info() {
    printf '\n==> %s\n\n' "$1"
}

die() {
    fmt=$1
    shift
    printf >&2 "ERROR: $fmt\n" "$@"
    exit 1
}

check_command() {
    command -v "$1" >/dev/null 2>&1 || die 'Required command not found: %s' "$1"
}

# ----------------------------------------------------------------------
# Preflight checks
# ----------------------------------------------------------------------

info "Checking dependencies"
check_command cc
check_command make
check_command git
check_command curl
check_command autoconf
check_command automake
check_command libtool
check_command glibtool
check_command ar

# ----------------------------------------------------------------------
# Setup directories
# ----------------------------------------------------------------------

info "Creating directories"
mkdir -p "$PREFIX/bin" || die 'Cannot create %s/bin' "$PREFIX"
mkdir -p "$PREFIX/lib/pkgconfig" || die 'Cannot create %s/lib/pkgconfig' "$PREFIX"
mkdir -p "$PREFIX/include" || die 'Cannot create %s/include' "$PREFIX"
mkdir -p "$PREFIX/share" || die 'Cannot create %s/share' "$PREFIX"
mkdir -p "$SRCDIR" || die 'Cannot create %s' "$SRCDIR"

export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:${PKG_CONFIG_PATH:-}"

# ----------------------------------------------------------------------
# Build Lua 5.3
# ----------------------------------------------------------------------

info "Building Lua ${LUA_VERSION}"
cd "$SRCDIR" || die 'cd %s failed' "$SRCDIR"

if [ ! -d "lua-${LUA_VERSION}" ]; then
    curl -fsSLO "$LUA_URL" || die 'Cannot download %s' "$LUA_URL"
    tar xf "lua-${LUA_VERSION}.tar.gz" || die 'Cannot unpack lua-%s.tar.gz' "$LUA_VERSION"
fi

cd "lua-${LUA_VERSION}" || die 'cd lua-%s failed' "$LUA_VERSION"
make clean 2>/dev/null
make macosx MYCFLAGS="-fPIC" || die 'Lua build failed'
make install INSTALL_TOP="$PREFIX" || die 'Lua install failed'

# Create pkg-config file for Lua
cat >"$PREFIX/lib/pkgconfig/lua5.3.pc" <<EOF || die 'Cannot write lua5.3.pc'
prefix=$PREFIX
exec_prefix=\${prefix}
libdir=\${prefix}/lib
includedir=\${prefix}/include

Name: Lua
Description: Lua 5.3
Version: ${LUA_VERSION}
Libs: -L\${libdir} -llua -lm
Cflags: -I\${includedir}
EOF

# Also create a generic lua.pc symlink
ln -sf lua5.3.pc "$PREFIX/lib/pkgconfig/lua.pc" || die 'Cannot link lua.pc'

# ----------------------------------------------------------------------
# Build unibilium
# ----------------------------------------------------------------------

info "Building unibilium"
cd "$SRCDIR" || die 'cd %s failed' "$SRCDIR"

if [ -d unibilium ]; then
    git -C unibilium pull || die 'git pull failed for unibilium'
else
    git clone "$UNIBILIUM_REPO" || die 'Cannot clone %s' "$UNIBILIUM_REPO"
fi

cd unibilium || die 'cd unibilium failed'
make clean 2>/dev/null
make PREFIX="$PREFIX" || die 'unibilium build failed'
make install PREFIX="$PREFIX" || die 'unibilium install failed'

# ----------------------------------------------------------------------
# Build libtermkey
# ----------------------------------------------------------------------

info "Building libtermkey"
cd "$SRCDIR" || die 'cd %s failed' "$SRCDIR"

if [ ! -d "libtermkey-${LIBTERMKEY_VERSION}" ]; then
    curl -fsSLO "$LIBTERMKEY_URL" || die 'Cannot download %s' "$LIBTERMKEY_URL"
    tar xf "libtermkey-${LIBTERMKEY_VERSION}.tar.gz" ||
        die 'Cannot unpack libtermkey-%s.tar.gz' "$LIBTERMKEY_VERSION"
fi

cd "libtermkey-${LIBTERMKEY_VERSION}" || die 'cd libtermkey-%s failed' "$LIBTERMKEY_VERSION"
make clean 2>/dev/null
make PREFIX="$PREFIX" PKG_CONFIG_PATH="$PKG_CONFIG_PATH" || die 'libtermkey build failed'
make install PREFIX="$PREFIX" || die 'libtermkey install failed'

# ----------------------------------------------------------------------
# Build lpeg
# ----------------------------------------------------------------------

info "Building lpeg"
cd "$SRCDIR" || die 'cd %s failed' "$SRCDIR"

if [ ! -d "lpeg-${LPEG_VERSION}" ]; then
    curl -fsSLO "$LPEG_URL" || die 'Cannot download %s' "$LPEG_URL"
    tar xf "lpeg-${LPEG_VERSION}.tar.gz" || die 'Cannot unpack lpeg-%s.tar.gz' "$LPEG_VERSION"
fi

cd "lpeg-${LPEG_VERSION}" || die 'cd lpeg-%s failed' "$LPEG_VERSION"
make clean 2>/dev/null

# Build object files manually (the makefile tries to build a .so which fails)
for src in lpvm lpcap lptree lpcode lpprint lpcset; do
    cc -O2 -fPIC -I"$PREFIX/include" -c "${src}.c" || die 'Cannot compile %s.c' "$src"
done

ar rcs liblpeg.a lpvm.o lpcap.o lptree.o lpcode.o lpprint.o lpcset.o ||
    die 'Cannot create liblpeg.a'
cp liblpeg.a "$PREFIX/lib/" || die 'Cannot copy liblpeg.a to %s/lib' "$PREFIX"

# Create pkg-config file for lpeg
cat >"$PREFIX/lib/pkgconfig/lpeg.pc" <<EOF || die 'Cannot write lpeg.pc'
prefix=$PREFIX
libdir=\${prefix}/lib
includedir=\${prefix}/include

Name: lpeg
Description: Parsing Expression Grammars for Lua
Version: ${LPEG_VERSION}
Libs: -L\${libdir} -llpeg
Cflags: -I\${includedir}
EOF

# ----------------------------------------------------------------------
# Build TRE
# ----------------------------------------------------------------------

info "Building TRE"
cd "$SRCDIR" || die 'cd %s failed' "$SRCDIR"

if [ -d tre ]; then
    git -C tre pull || die 'git pull failed for tre'
else
    git clone "$TRE_REPO" || die 'Cannot clone %s' "$TRE_REPO"
fi

cd tre || die 'cd tre failed'
./utils/autogen.sh || die 'TRE autogen.sh failed'
./configure --prefix="$PREFIX" --enable-static --disable-shared || die 'TRE configure failed'
make clean 2>/dev/null
make || die 'TRE build failed'
make install || die 'TRE install failed'

# ----------------------------------------------------------------------
# Build vis
# ----------------------------------------------------------------------

info "Building vis"
cd "$SRCDIR" || die 'cd %s failed' "$SRCDIR"

if [ -d vis ]; then
    git -C vis pull || die 'git pull failed for vis'
else
    git clone "$VIS_REPO" --branch cursor-shape || die 'Cannot clone %s' "$VIS_REPO"
fi

cd vis || die 'cd vis failed'

# Set up environment for configure
export CFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"

./configure \
    --prefix="$PREFIX" \
    --enable-lpeg-static \
    --enable-tre || die 'vis configure failed'

make clean 2>/dev/null
make || die 'vis build failed'
make install || die 'vis install failed'

# ----------------------------------------------------------------------
# Create wrapper script
# ----------------------------------------------------------------------

info "Creating wrapper script at $WRAPPER"
mkdir -p "${WRAPPER%/*}" || die 'Cannot create %s' "${WRAPPER%/*}"

cat >"$WRAPPER" <<EOF || die 'Cannot write %s' "$WRAPPER"
#!/bin/sh
# Wrapper for vis editor with isolated dependencies
exec "$PREFIX/bin/vis" "\$@"
EOF

chmod +x "$WRAPPER" || die 'chmod +x %s failed' "$WRAPPER"

# ----------------------------------------------------------------------
# Done
# ----------------------------------------------------------------------

info "Build complete!"
printf 'vis installed to: %s\n' "$PREFIX"
printf 'Wrapper script:   %s\n' "$WRAPPER"
printf '\nTest with: %s -v\n' "$WRAPPER"
printf '\nYour user config goes in: ~/.config/vis/visrc.lua\n'
printf 'Remember to add: require("vis")\n'
