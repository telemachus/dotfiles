#!/usr/bin/env dash

# Link dotfiles from this repository into $HOME.
# A real file or directory in the way is moved to ~/old_<name>.
# A symlink in the way is replaced.
#
# -n: show what would happen, but change nothing
# -v: show each change as it happens

set -u

prog=${0##*/}

usage() {
    printf 'usage: %s [-n] [-v]\n' "$prog" >&2
    exit 2
}

dry_run=false
verbose=false
while getopts nv opt; do
    case $opt in
        n)
            dry_run=true
            verbose=true
            ;;
        v) verbose=true ;;
        *) usage ;;
    esac
done
shift $((OPTIND - 1))
[ $# -eq 0 ] || usage

: "${DOTFILES:=$HOME/Documents/git-repos/dotfiles}"

say() {
    if $verbose; then
        printf '%s\n' "$*"
    fi
}

warn() {
    printf '%s: %s\n' "$prog" "$*" >&2
}

run() {
    say "$*"
    if ! $dry_run; then
        "$@"
    fi
}

# link SRC DEST links $DOTFILES/SRC to $HOME/DEST.
link() {
    local src="$DOTFILES/$1"
    local dest="$HOME/$2"
    local backup="$HOME/old_${2#.}"

    if [ ! -e "$src" ]; then
        warn "missing $src"
        return 1
    fi

    if [ -L "$dest" ]; then
        if [ "$(readlink "$dest")" = "$src" ]; then
            say "ok $dest"
            return 0
        fi
        run rm "$dest" || return
    elif [ -e "$dest" ]; then
        if [ -e "$backup" ] || [ -L "$backup" ]; then
            warn "$backup exists; leaving $dest alone"
            return 1
        fi
        run mv "$dest" "$backup" || return
    fi

    run ln -s "$src" "$dest"
}

status=0
while read -r src dest; do
    link "$src" "$dest" || status=1
done <<EOF
config .config
zshenv .zshenv
vim/vimrc .vimrc
nexrc .nexrc
gitconfig .gitconfig
gitignore_global .gitignore_global
hushlogin .hushlogin
EOF

exit $status
