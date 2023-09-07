#!/usr/bin/env bash

set -u
DOTFILES="$HOME/Documents/git-repos/dotfiles"
BASE="$HOME/.config/nvim"

ln -f -s "$DOTFILES/config/nvim/init.lua" "$BASE/init.lua"

for item in autocommands.lua filetypes.lua lsp.lua mappings.lua usercommands.lua;
do
	# Create a symbolic link from x to y. If y already exists, delete it
	# and create a new symbolic link.
	ln -f -s "$DOTFILES/config/nvim/lua/$item" "$BASE/lua/$item"
done
