#!/usr/bin/env bash

set -u

NVIM_DOTFILES="${HOME}/Documents/git-repos/dotfiles/config/nvim"
NVIM_LINK="${HOME}/.config/nvim"

if [ ! -d "$NVIM_DOTFILES" ]; then
    {
        printf >&2 "nvim-link: early exit: no [%s]\n" "$NVIM_DOTFILES"
        exit 1
    }
fi

# Create a symbolic link from x to y. If y already exists, delete it and create
# a new symbolic link.
ln -f -s "$NVIM_DOTFILES" "$NVIM_LINK"
