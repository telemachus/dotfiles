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

cd $HOME/.vim/autoload
curl -S -o pathogen.vim \
    https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

cd $HOME/.vim/bundle
$CLONE https://github.com/mattn/gist-vim.git
$CLONE https://github.com/NLKNguyen/papercolor-theme.git
$CLONE https://github.com/nice/sweater.git
$CLONE https://github.com/SirVer/ultisnips.git
$CLONE https://github.com/tpope/vim-abolish.git
$CLONE https://github.com/markcornick/vim-bats.git
$CLONE https://github.com/telemachus/vim-bibcite.git
$CLONE https://github.com/tpope/vim-commentary.git
$CLONE https://github.com/dietsche/vim-lastplace.git
$CLONE https://bitbucket.org/telemachus/vim-macrons.git
$CLONE https://github.com/tpope/vim-markdown.git
$CLONE https://github.com/wlangstroth/vim-racket.git
$CLONE https://github.com/tpope/vim-repeat.git
$CLONE https://github.com/machakann/vim-sandwich.git
$CLONE https://github.com/Pychimp/vim-sol.git
$CLONE https://github.com/tpope/vim-surround.git
$CLONE https://github.com/reedes/vim-textobj-quote.git
$CLONE https://github.com/kana/vim-textobj-user.git
$CLONE https://bitbucket.org/telemachus/vim-varia.git
$CLONE https://github.com/mattn/webapi-vim.git
