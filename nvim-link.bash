#!/usr/bin/env bash

set -u
DOTFILES="$HOME/Documents/git-repos/dotfiles"
BASE="$HOME/.config/nvim"

ln -f -s "$DOTFILES/config/nvim/init.lua" "$BASE/init.lua"

for item in autocommands.lua filetypes.lua grep.lua usercommands.lua;
do
	ln -f -s "$DOTFILES/config/nvim/lua/$item" "$BASE/lua/$item"
done
