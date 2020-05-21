#!/usr/bin/env bash
set -x

START_DIR="$(pwd)"
BREW_INSTALL="/usr/local/bin/brew install"

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$BREW_INSTALL --with-curl --with-openssl git
$BREW_INSTALL abook aspell bash bash-completion@2 bats cmake csvprintf \
	ctags discount ed elinks git gnupg isync less lua luarocks mawk \
	mercurial moreutils mpack mpc mpd mpack msmtp mu neatvi neomutt par \
	pass pkg-config python@3.8 rename shellcheck tarsnap urlview vim w3m wget
$BREW_INSTALL --HEAD neovim

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
