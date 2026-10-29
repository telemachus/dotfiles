#!/usr/bin/env dash
# Build vis editor with all dependencies isolated in $HOME/local/vis
# Dependencies: C compiler, make, autoconf, automake, libtool, git, curl
set -eu

PREFIX="$HOME/local/vis"
SRCDIR="$HOME/Downloads/src/vis-build"
WRAPPER="$HOME/bin/vise"

# URLs for tarballs
LUA_VERSION="5.3.6"
LUA_URL="https://www.lua.org/ftp/lua-${LUA_VERSION}.tar.gz"

LIBTERMKEY_VERSION="0.22"
LIBTERMKEY_URL="http://www.leonerd.org.uk/code/libtermkey/libtermkey-${LIBTERMKEY_VERSION}.tar.gz"

LPEG_VERSION="1.1.0"
LPEG_URL="http://www.inf.puc-rio.br/~roberto/lpeg/lpeg-${LPEG_VERSION}.tar.gz"

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
    printf 'ERROR: %s\n' "$1" >&2
    exit 1
}

check_command() {
    command -v "$1" >/dev/null 2>&1 || die "Required command not found: $1"
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
mkdir -p "$PREFIX/bin" || die "Cannot create $PREFIX/bin"
mkdir -p "$PREFIX/lib/pkgconfig" || die "Cannot create $PREFIX/lib/pkgconfig"
mkdir -p "$PREFIX/include" || die "Cannot create $PREFIX/include"
mkdir -p "$PREFIX/share" || die "Cannot create $PREFIX/share"
mkdir -p "$SRCDIR" || die "Cannot create $SRCDIR"

export PKG_CONFIG_PATH="$PREFIX/lib/pkgconfig:${PKG_CONFIG_PATH:-}"

# ----------------------------------------------------------------------
# Build Lua 5.3
# ----------------------------------------------------------------------

info "Building Lua ${LUA_VERSION}"
cd "$SRCDIR"

if [ ! -d "lua-${LUA_VERSION}" ]; then
    curl -LO "$LUA_URL"
    tar xf "lua-${LUA_VERSION}.tar.gz"
fi

cd "lua-${LUA_VERSION}"
make clean 2>/dev/null || true
make macosx MYCFLAGS="-fPIC"
make install INSTALL_TOP="$PREFIX"

# Create pkg-config file for Lua
cat > "$PREFIX/lib/pkgconfig/lua5.3.pc" << EOF
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
ln -sf lua5.3.pc "$PREFIX/lib/pkgconfig/lua.pc"

# ----------------------------------------------------------------------
# Build unibilium
# ----------------------------------------------------------------------

info "Building unibilium"
cd "$SRCDIR"

if [ ! -d "unibilium" ]; then
    git clone "$UNIBILIUM_REPO"
else
    cd unibilium
    git pull
    cd ..
fi

cd unibilium
make clean 2>/dev/null || true
make PREFIX="$PREFIX"
make install PREFIX="$PREFIX"

# ----------------------------------------------------------------------
# Build libtermkey
# ----------------------------------------------------------------------

info "Building libtermkey"
cd "$SRCDIR"

if [ ! -d "libtermkey-${LIBTERMKEY_VERSION}" ]; then
    curl -LO "$LIBTERMKEY_URL"
    tar xf "libtermkey-${LIBTERMKEY_VERSION}.tar.gz"
fi

cd "libtermkey-${LIBTERMKEY_VERSION}"
make clean 2>/dev/null || true
make PREFIX="$PREFIX" PKG_CONFIG_PATH="$PKG_CONFIG_PATH"
make install PREFIX="$PREFIX"

# ----------------------------------------------------------------------
# Build lpeg
# ----------------------------------------------------------------------

info "Building lpeg"
cd "$SRCDIR"

if [ ! -d "lpeg-${LPEG_VERSION}" ]; then
    curl -LO "$LPEG_URL"
    tar xf "lpeg-${LPEG_VERSION}.tar.gz"
fi

cd "lpeg-${LPEG_VERSION}"
make clean 2>/dev/null || true

# Build object files manually (the makefile tries to build a .so which fails)
cc -O2 -fPIC -I"$PREFIX/include" -c lpvm.c
cc -O2 -fPIC -I"$PREFIX/include" -c lpcap.c
cc -O2 -fPIC -I"$PREFIX/include" -c lptree.c
cc -O2 -fPIC -I"$PREFIX/include" -c lpcode.c
cc -O2 -fPIC -I"$PREFIX/include" -c lpprint.c
cc -O2 -fPIC -I"$PREFIX/include" -c lpcset.c

ar rcs liblpeg.a lpvm.o lpcap.o lptree.o lpcode.o lpprint.o lpcset.o
cp liblpeg.a "$PREFIX/lib/"

# Create pkg-config file for lpeg
cat > "$PREFIX/lib/pkgconfig/lpeg.pc" << EOF
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
cd "$SRCDIR"

if [ ! -d "tre" ]; then
    git clone "$TRE_REPO"
else
    cd tre
    git pull
    cd ..
fi

cd tre
./utils/autogen.sh
./configure --prefix="$PREFIX" --enable-static --disable-shared
make clean 2>/dev/null || true
make
make install

# ----------------------------------------------------------------------
# Build vis
# ----------------------------------------------------------------------

info "Building vis"
cd "$SRCDIR"

if [ ! -d "vis" ]; then
    git clone "$VIS_REPO" --branch cursor-shape
else
    cd vis
    git pull
    cd ..
fi

cd vis

# Set up environment for configure
export CFLAGS="-I$PREFIX/include"
export LDFLAGS="-L$PREFIX/lib"

./configure \
    --prefix="$PREFIX" \
    --enable-lpeg-static \
    --enable-tre

make clean 2>/dev/null || true
make
make install

# ----------------------------------------------------------------------
# Create wrapper script
# ----------------------------------------------------------------------

info "Creating wrapper script at $WRAPPER"
mkdir -p "$(dirname "$WRAPPER")"

cat > "$WRAPPER" << EOF
#!/bin/sh
# Wrapper for vis editor with isolated dependencies
exec "$PREFIX/bin/vis" "\$@"
EOF

chmod +x "$WRAPPER"

# ----------------------------------------------------------------------
# Done
# ----------------------------------------------------------------------

info "Build complete!"
printf 'vis installed to: %s\n' "$PREFIX"
printf 'Wrapper script:   %s\n' "$WRAPPER"
printf '\nTest with: %s -v\n' "$WRAPPER"
printf '\nYour user config goes in: ~/.config/vis/visrc.lua\n'
printf 'Remember to add: require("vis")\n'
