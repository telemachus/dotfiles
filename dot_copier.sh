#!/usr/bin/env bash

set -e

[ "$1" = "-v" ] && V="-v"
: "${DOTFILES:=$HOME/Documents/git-clones/dotfiles}"

for item in ".bash_aliases" ".bash_completion" ".bash_functions" \
    ".bashrc" ".profile" ".inputrc" ".hushlogin" ".gitignore_global"; do
    # Adapted from https://wiki.ubuntu.com/DashAsBinSh
    item_no_dot=$(printf '%s' "$item" | awk '{ print substr($1, 2); }')
    if [ -h "$HOME/$item" ] && [ -e "$DOTFILES/${item_no_dot}" ]; then
        rm "$V" "$HOME/$item"
    fi
done

for item in "bash_aliases" "bash_completion" "bash_functions" \
    "bashrc" "profile""inputrc" "hushlogin" "gitignore_global"; do
    if [ -e "$DOTFILES/$item" ]; then
        cp "$V" "$DOTFILES/$item" "$HOME/.$item"
    fi
done
