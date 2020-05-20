#!/usr/bin/env dash

set -e

[ "$1" = "-v" ] && V="-v"
: ${DOTFILES:=/Users/telemachus/Documents/git-clones/dotfiles}

for item in ".bash_aliases" ".bash_completion" ".bash_functions" \
	".bashrc" ".profile" ".inputrc" ".hushlogin" ".gitignore_global" \
	".procmailrc"
do
	# This completely wets the bed if there are dead symlinks?!?!
	# TODO: fixme
	# Adapted from https://wiki.ubuntu.com/DashAsBinSh
	item_no_dot=$(printf $item | awk '{ print substr($1, 2); }')
	if [ -e "$HOME/$item" -a -e "$DOTFILES/${item_no_dot}" ]; then
		mv $V "$HOME/$item" "$HOME/old_${item_no_dot}"
	fi
done

for item in "bash_aliases" "bash_completion" "bash_functions" \
	"bashrc" "profile" "inputrc" "hushlogin" "gitignore_global" \
	"procmailrc"
do
	if [ -e "$DOTFILES/$item" ]; then
		ln -s $V "$DOTFILES/$item" "$HOME/.$item"
	fi
done
