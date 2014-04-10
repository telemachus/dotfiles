#!/usr/bin/env dash

set -e

if [ -e $HOME/.vim ]; then
    printf "Backing up current .vim directory to $HOME/old-vim...\n"
    mv $HOME/.vim $HOME/old-vim
fi

mkdir $HOME/.vim
mkdir $HOME/.vim/autoload
mkdir $HOME/.vim/bundle

CLONE='git clone --depth=1'

cd $HOME/.vim/autoload
curl -so pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
cd $HOME/.vim/bundle
$CLONE https://github.com/mattn/gist-vim.git
$CLONE https://github.com/plasticboy/vim-markdown.git
$CLONE https://github.com/Pychimp/vim-sol.git
$CLONE https://github.com/telemachus/vim-varia.git
$CLONE https://github.com/mattn/webapi-vim.git
$CLONE https://github.com/tpope/vim-surround.git
$CLONE https://github.com/tpope/vim-repeat.git
