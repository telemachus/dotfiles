#!/usr/bin/env dash

set -e

if [ -e $HOME/.vim ]; then
    printf "Backing up current .vim directory to $HOME/old-vim...\n"
    mv $HOME/.vim $HOME/old-vim
fi

mkdir $HOME/.vim
mkdir $HOME/.vim/autoload
mkdir $HOME/.vim/bundle
mkdir $HOME/.vim_backups
mkdir $HOME/.vim_undo

CLONE='git clone'
DEPTH='--depth 1'

cd $HOME/.vim/autoload
curl -S -o pathogen.vim \
    https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

cd $HOME/.vim/bundle
$CLONE $DEPTH https://bitbucket.org/telemachus/vim-varia.git
$CLONE $DEPTH https://github.com/Pychimp/vim-sol.git
$CLONE $DEPTH https://github.com/SirVer/ultisnips.git
$CLONE $DEPTH https://github.com/dietsche/vim-lastplace.git
$CLONE $DEPTH https://github.com/mattn/gist-vim.git
$CLONE $DEPTH https://github.com/mattn/webapi-vim.git
$CLONE $DEPTH https://github.com/nice/sweater.git
$CLONE $DEPTH https://github.com/tpope/vim-markdown.git
$CLONE $DEPTH https://github.com/tpope/vim-repeat.git
$CLONE $DEPTH https://github.com/tpope/vim-surround.git
$CLONE $DEPTH https://github.com/telemachus/vim-bibcite.git
