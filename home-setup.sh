#!/usr/bin/env bash

# As of 2022-03-23, this is out of date. I need to rethink this whole thing.
set -x

START_DIR="$(pwd)"

# First, I need to install MacPorts.

if [ ! -d "$HOME/Documents/git-repos" ]; then
    mkdir -p "$HOME/Documents/git-repos"
fi

# TODO: I need to make sure that ssh keys are set before I can do these clones.
cd "$HOME/Documents/git-repos" || exit
if [ ! -d "$HOME/Documents/git-repos" ]; then
    git clone git@telemachus:dotfiles
else
    cd "$HOME/projects/dotfiles" || exit
    git pull origin master
fi
cd "$HOME" || exit

COMMAND='ln -s'
$COMMAND "$HOME/Documents/git-repos/dotfiles/bash_aliases" "$HOME/.bash_aliases"
$COMMAND "$HOME/Documents/git-repos/dotfiles/bash_completion" "$HOME/.bash_completion"
$COMMAND "$HOME/Documents/git-repos/dotfiles/bash_functions" "$HOME/.bash_functions"
$COMMAND "$HOME/Documents/git-repos/dotfiles/bashrc" "$HOME/.bashrc"
$COMMAND "$HOME/Documents/git-repos/dotfiles/gitignore_global" "$HOME/.gitignore_global"
$COMMAND "$HOME/Documents/git-repos/dotfiles/vim/gvimrc" "$HOME/.gvimrc"
$COMMAND "$HOME/Documents/git-repos/dotfiles/inputrc" "$HOME/.inputrc"
$COMMAND "$HOME/Documents/git-repos/dotfiles/irbrc" "$HOME/.irbrc"
$COMMAND "$HOME/Documents/git-repos/dotfiles/procmailrc" "$HOME/.procmailrc"
$COMMAND "$HOME/Documents/git-repos/dotfiles/profile" "$HOME/.profile"
$COMMAND "$HOME/Documents/git-repos/dotfiles/vim/vimrc" "$HOME/.vimrc"

cd "$START_DIR" || exit
