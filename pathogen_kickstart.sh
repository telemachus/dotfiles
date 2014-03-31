#!/usr/bin/env dash

set -e

if [ -e $HOME/.vim ]; then
    printf "Backing up current .vim directory to $HOME/old-vim...\n"
    mv $HOME/.vim $HOME/old-vim
fi

mkdir $HOME/.vim
mkdir $HOME/.vim/autoload
mkdir $HOME/.vim/bundle

cd $HOME/.vim/autoload
curl -so pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
cd $HOME/.vim/bundle
git clone https://github.com/mattn/gist-vim.git
git clone https://github.com/plasticboy/vim-markdown.git
git clone https://github.com/Pychimp/vim-sol.git
git clone https://github.com/telemachus/vim-varia.git
git clone https://github.com/mattn/webapi-vim.git
