#!/usr/bin/env dash

set -e

BUNDLE_HOME="$HOME"/.vim/bundle

info() { printf "$1\n"; }
warn() { info "$1" 1>&2; }

get_remote_url() {
    git config --get remote.origin.url
}

git_dirty() {
    if ! git diff-index --quiet HEAD; then
        warn "Uncommitted changes in $PWD."
    fi

    if [ -n "$(git ls-files --exclude-standard --others)" ]; then
        warn "Untracked files in $PWD."
    fi
}

git_unpushed_changes() {
    num=$(git rev-list origin..HEAD | wc -l)
    if [ $num -gt 0 ]; then
        warn "Commits that need to be pushed in $PWD"
    fi
}

cd "$BUNDLE_HOME"
for item in *
do
    if [ -d "$BUNDLE_HOME/$item" ]; then
        cd "$BUNDLE_HOME/$item"
        info "git clone $(get_remote_url)"
    fi
done

cd "$BUNDLE_HOME"
for item in *
do
    if [ -d "$BUNDLE_HOME/$item" ]; then
        cd "$BUNDLE_HOME/$item"
        git_dirty
        git_unpushed_changes
    fi
done
