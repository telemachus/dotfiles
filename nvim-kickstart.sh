#!/usr/bin/env dash

set -e

if [ -e $HOME/.config/nvim ]; then
    printf "Backing up current .config/nvim directory to $HOME/old-nvim...\n"
    mv $HOME/.config/nvim $HOME/old-nvim
fi

mkdir $HOME/.config
mkdir $HOME/.config/nvim
mkdir $HOME/.config/nvim/autoload
mkdir $HOME/.config/nvim/bundle
mkdir $HOME/.nvim_backups
mkdir $HOME/.nvim_undo
cp -v ./vim/nvimrc $HOME/.config/init.vim

CLONE='git clone'

cd $HOME/.config/nvim/autoload
curl -S -o pathogen.vim \
    https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

cd $HOME/.config/nvim/bundle
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
