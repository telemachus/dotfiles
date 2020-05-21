#!/usr/bin/env bash

set -e

[ "$1" = "-v" ] && V="-v"
: "${DOTFILES:=/Users/telemachus/Documents/git-repos/dotfiles}"

for item in ".bash_aliases" ".bash_completion" ".bash_functions" \
	".bashrc" ".profile" ".inputrc" ".hushlogin" ".gitignore_global"
do
	# TODO: fixme
	# Adapted from https://wiki.ubuntu.com/DashAsBinSh
	item_no_dot=$(printf "%s" "$item" | awk '{ print substr($1, 2); }')
	if [ -h "$HOME/$item" ] && [ -e "$DOTFILES/${item_no_dot}" ]; then
		rm $V "$HOME/$item"
	fi

	if [ -e "$HOME/$item" ] && [ -e "$DOTFILES/${item_no_dot}" ]; then
		mv $V "$HOME/$item" "$HOME/old_${item_no_dot}"
	fi
done

for item in "bash_aliases" "bash_completion" "bash_functions" \
	"bashrc" "profile" "inputrc" "hushlogin" "gitignore_global"
do
	if [ -e "$DOTFILES/$item" ]; then
		ln -s $V "$DOTFILES/$item" "$HOME/.$item"
	fi
done
