#!/usr/bin/env dash

set -e

[ "$1" = "-v" ] && V="-v"
: ${DOTFILES:=$HOME/code/dotfiles}

for item in ".bash_aliases" ".bash_completion" ".bash_functions" \
    ".bashrc" ".profile" ".gemrc" ".irbrc" ".inputrc" ".hushlogin" \
    ".gitignore_global" ".minicpanrc" ".procmailrc"
do
    # Adapted from https://wiki.ubuntu.com/DashAsBinSh
    item_no_dot=$(printf $item | awk '{ print substr($1, 2); }')
    if [ -e "$HOME/$item" -a -e "$DOTFILES/${item_no_dot}" ]; then
        mv $V "$HOME/$item" "$HOME/old_${item_no_dot}"
    fi
done

for item in "bash_aliases" "bash_completion" "bash_functions" \
    "bashrc" "profile" "gemrc" "irbrc" "inputrc" "hushlogin" \
    "gitignore_global" "minicpanrc" "procmailrc"
do
    if [ -e "$DOTFILES/$item" ]; then
        ln -s $V "$DOTFILES/$item" "$HOME/.$item"
    fi
done
