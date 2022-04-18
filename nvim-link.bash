#!/usr/bin/env bash

set -u
DOTFILES="$HOME/Documents/git-repos/dotfiles"
BASE="$HOME/.config/nvim"

if [[ ! -f "$BASE/init.vim" ]]; then
	ln -f -s "$DOTFILES/config/nvim/init.lua" "$BASE/init.lua"
fi

for item in autocommands.lua filetypes.lua grep.lua;
do
	if [[ ! -f "$BASE/lua/$item" ]]; then
		ln -f -s "$DOTFILES/config/nvim/lua/$item" "$BASE/lua/$item"
	fi
done
