#!/usr/bin/env bash

set -u
DOTFILES="${HOME}/Documents/git-repos/dotfiles"
BASE="${HOME}/.config/nvim"

ln -f -s "${DOTFILES}/config/nvim/init.lua" "${BASE}/init.lua"

rm "${BASE}/lua/"*

for ITEM in autocommands.lua filetypes.lua headless.lua lsp.lua mappings.lua \
	packages.lua
do
	# Create a symbolic link from x to y. If y already exists, delete it
	# and create a new symbolic link.
	ln -f -s "${DOTFILES}/config/nvim/lua/${ITEM}" "${BASE}/lua/${ITEM}"
done
