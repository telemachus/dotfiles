#!/usr/bin/env dash

set -u

die() {
    fmt=$1
    shift
    printf >&2 "%s: $fmt\n" "${0##*/}" "$@"
    exit 1
}

BUILD_ROOT="${HOME}/Downloads/src"
BUILD_FULL="${BUILD_ROOT}/nvi2"
# GIT_REPO='https://github.com/lichray/nvi2.git'
GIT_REPO='https://github.com/telemachus/nvi2.git'
INSTALL_DIR="${HOME}/local/nvi2"
DOTFILES="${HOME}/Documents/git-repos/dotfiles"

for DEP in ninja cmake git; do
    hash "$DEP" 2>/dev/null || die 'missing requirement: %s' "$DEP"
done

if [ ! -d "$BUILD_ROOT" ]; then
    mkdir -p "$BUILD_ROOT" || die '`mkdir -p %s` failed' "$BUILD_ROOT"
fi
cd "$BUILD_ROOT" || die '`cd %s` failed' "$BUILD_ROOT"

if [ ! -d "$BUILD_FULL" ]; then
    git clone --branch cq "$GIT_REPO" ||
        die '`git clone %s` failed' "$GIT_REPO"
fi
cd "$BUILD_FULL" || die '`cd %s` failed' "$BUILD_FULL"
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
rm -rf "$INSTALL_DIR" || die '`rm -rf %s` failed' "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR/bin" || die '`mkdir -p %s/bin` failed' "$INSTALL_DIR"
mkdir -p "$INSTALL_DIR/share/man/man1" || die '`mkdir -p %s/share/man/man1` failed' "$INSTALL_DIR"

cp -v build/Release/nvi "$INSTALL_DIR/bin/nvi" || die '`cp nvi` failed'
cp -v man/vi.1 "$INSTALL_DIR/share/man/man1/nvi.1" || die '`cp manpage` failed'

cd "$INSTALL_DIR/bin" || die '`cd %s/bin` failed' "$INSTALL_DIR"
ln -sf nvi nex || die '`ln -s nvi nex` failed'
printf 'ln -sf %s/bin/nex -> %s/bin/nvi\n' "$INSTALL_DIR" "$INSTALL_DIR"

ln -sf "${DOTFILES}/nexrc" "${HOME}/.nexrc"
printf 'ln -sf %s/nexrc -> %s/.nexrc\n' "$DOTFILES" "$HOME"
