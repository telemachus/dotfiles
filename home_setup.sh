#!/usr/bin/env bash
set -x

START_DIR="$(pwd)"
BREW_INSTALL="/usr/local/bin/brew install"

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
$BREW_INSTALL --with-curl --with-openssl git
$BREW_INSTALL abook aspell bash bats chgems chruby csvprintf ctags \
	dash discount ed elinks getmail gist gnupg lua luajit luarocks \
	mawk mercurial mpack mpc mpd mpack mu ncmpc par pcre2 procmail \
	pwsafe python remind rename ruby-install urlview wget yank
$BREW_INSTALL --with-s-lang mutt
$BREW_INSTALL --HEAD neovim
$BREW_INSTALL --with-bundle mpv

if [ ! -d "$HOME/projects" ]; then
    mkdir "$HOME/projects"
fi

cd "$HOME/projects"
if [ ! -d "$HOME/projects/dotfiles" ]; then
    git clone https://bitbucket.org/telemachus/dotfiles.git
else
    cd "$HOME/projects/dotfiles"
    git pull origin master
fi
cd $HOME

COMMAND='ln -s'
$COMMAND "$HOME/projects/dotfiles/bash_aliases" "$HOME/.bash_aliases"
$COMMAND "$HOME/projects/dotfiles/bash_completion" "$HOME/.bash_completion"
$COMMAND "$HOME/projects/dotfiles/bash_functions" "$HOME/.bash_functions"
$COMMAND "$HOME/projects/dotfiles/bashrc" "$HOME/.bashrc"
$COMMAND "$HOME/projects/dotfiles/gitignore_global" "$HOME/.gitignore_global"
$COMMAND "$HOME/projects/dotfiles/vim/gvimrc" "$HOME/.gvimrc"
$COMMAND "$HOME/projects/dotfiles/inputrc" "$HOME/.inputrc"
$COMMAND "$HOME/projects/dotfiles/irbrc" "$HOME/.irbrc"
$COMMAND "$HOME/projects/dotfiles/procmailrc" "$HOME/.procmailrc"
$COMMAND "$HOME/projects/dotfiles/profile" "$HOME/.profile"
$COMMAND "$HOME/projects/dotfiles/vim/vimrc" "$HOME/.vimrc"

# We need this to make procmail work correctly
sudo install -o "$USER" -g mail -m 0600 /dev/null "/var/mail/$USER"

cd "$START_DIR"
