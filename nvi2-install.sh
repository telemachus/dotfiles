#!/usr/bin/env dash

set -u

die() {
    printf >&2 '%s: %s\n' "${0##*/}" "$1"
    exit 1
}

BUILD_ROOT="${HOME}/Downloads/src"
BUILD_FULL="${BUILD_ROOT}/nvi2"
GIT_REPO='https://github.com/lichray/nvi2.git'
INSTALL_DIR="${HOME}/local/nvi2"

for DEP in ninja cmake git; do
    hash "$DEP" 2>/dev/null || die "$(printf 'missing requirement: %s' "$DEP")"
done

if [ ! -d "$BUILD_ROOT" ]; then
    mkdir -p "$BUILD_ROOT" || die "$(printf '`mkdir -p %s` failed' "$BUILD_ROOT")"
fi
cd "$BUILD_ROOT" || die "$(printf '`cd %s` failed' "$BUILD_ROOT")"

if [ ! -d "$BUILD_FULL" ]; then
    git clone "$GIT_REPO" || die "$(printf '`git clone %s` failed' "$GIT_REPO")"
fi
cd "$BUILD_FULL" || die "$(printf '`cd %s` failed' "$BUILD_FULL")"
git pull || die '`git pull` failed'

if [ "${1:-}" = "--clean" ]; then
    rm -rf build || die '`rm -rf build` failed'
fi

cmake -G "Ninja Multi-Config" -B build \
    -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR" \
    -DUSE_ICONV=ON \
    -DUSE_WIDECHAR=ON || die '`cmake` failed'

ninja -C build -f build-Release.ninja || die '`ninja` failed'

# Manual installation since there's no install target
rm -rf "$INSTALL_DIR" || die "$(printf '`rm -rf %s` failed' "$INSTALL_DIR")"
mkdir -p "$INSTALL_DIR/bin" || die "$(printf '`mkdir -p %s/bin` failed' "$INSTALL_DIR")"
mkdir -p "$INSTALL_DIR/share/man/man1" || die "$(printf '`mkdir -p %s/share/man/man1` failed' "$INSTALL_DIR")"

cp -v build/Release/nvi "$INSTALL_DIR/bin/nvi" || die '`cp nvi` failed'
cp -v man/vi.1 "$INSTALL_DIR/share/man/man1/nvi.1" || die '`cp manpage` failed'

cd "$INSTALL_DIR/bin" || die "$(printf '`cd %s/bin` failed' "$INSTALL_DIR")"
ln -s nvi nex || die '`ln -s nvi nex` failed'
printf 'ln -s %s/bin/nex -> %s/bin/nvi\n' "$INSTALL_DIR" "$INSTALL_DIR"
