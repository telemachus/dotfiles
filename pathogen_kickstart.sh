#!/usr/bin/env dash

set -e

if [ -e $HOME/.vim ]; then
    printf "Backing up current .vim directory to $HOME/old-vim...\n"
    mv $HOME/.vim $HOME/old-vim
fi

mkdir -p $HOME/.vim/{autoload,bundle}

CLONE='git clone --depth=1'

cd $HOME/.vim/autoload
curl -so pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
cd $HOME/.vim/bundle
"$CLONE" https://github.com/mattn/gist-vim.git
"$CLONE" https://github.com/SirVer/ultisnips.git
"$CLONE" https://github.com/plasticboy/vim-markdown.git
"$CLONE" https://github.com/tpope/vim-repeat.git
"$CLONE" https://github.com/tpope/vim-surround.git
"$CLONE" https://bitbucket.org/telemachus/vim-varia.git
"$CLONE" https://github.com/mattn/webapi-vim.git
