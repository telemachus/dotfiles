#!/usr/bin/env bash
set -x

# Save this off for later.
START_DIR=$(pwd)

# First, let's install Homebrew.
/usr/bin/ruby -e "$(/usr/bin/curl -fsSL https://raw.github.com/mxcl/homebrew/master/Library/Contributions/install_homebrew.rb)"
/usr/local/bin/brew install git
/usr/local/bin/brew install dash

# Now we need vanilla gcc-4.2 for older rubies
cd /tmp
curl -O http://opensource.apple.com/tarballs/gcc/gcc-5666.3.tar.gz
tar zxf gcc-5666.3.tar.gz
cd gcc-5666.3
mkdir -p build/{obj,dst,sym}
gnumake install RC_OS=macos RC_ARCHS='i386 x86_64' TARGETS='i386 x86_64' \
SRCROOT=`pwd` OBJROOT=`pwd`/build/obj DSTROOT=`pwd`/build/dst SYMROOT=`pwd`/build/sym
sudo ditto build/dst /
cd "$OLDPWD"

if [ ! -d "$HOME/code" ]; then
    mkdir "$HOME/code"
fi

cd "$HOME/code"
if [ ! -d "$HOME/code/dotfiles" ]; then
    git clone https://github.com/telemachus/dotfiles.git
else
    cd "$HOME/code/dotfiles"
    git pull origin master
fi
cd $HOME

COMMAND='ln -s'
$COMMAND "$HOME/code/dotfiles/bash_aliases" "$HOME/.bash_aliases"
$COMMAND "$HOME/code/dotfiles/bash_completion" "$HOME/.bash_completion"
$COMMAND "$HOME/code/dotfiles/bash_functions" "$HOME/.bash_functions"
$COMMAND "$HOME/code/dotfiles/bashrc" "$HOME/.bashrc"
$COMMAND "$HOME/code/dotfiles/gitignore_global" "$HOME/.gitignore_global"
$COMMAND "$HOME/code/dotfiles/vim/gvimrc" "$HOME/.gvimrc"
$COMMAND "$HOME/code/dotfiles/inputrc" "$HOME/.inputrc"
$COMMAND "$HOME/code/dotfiles/irbrc" "$HOME/.irbrc"
$COMMAND "$HOME/code/dotfiles/minicpanrc" "$HOME/.minicpanrc"
$COMMAND "$HOME/code/dotfiles/procmailrc" "$HOME/.procmailrc"
$COMMAND "$HOME/code/dotfiles/profile" "$HOME/.profile"
$COMMAND "$HOME/code/dotfiles/vim/vimrc" "$HOME/.vimrc"

cd "$START_DIR"
