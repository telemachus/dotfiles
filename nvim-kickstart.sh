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
DEPTH='--depth 1'

cd $HOME/.config/nvim/autoload
curl -S -o pathogen.vim \
    https://raw.githubusercontent.com/tpope/vim-pathogen/master/autoload/pathogen.vim

cd $HOME/.config/nvim/bundle
$CLONE $DEPTH https://bitbucket.org/telemachus/vim-varia.git
$CLONE $DEPTH https://github.com/Pychimp/vim-sol.git
$CLONE $DEPTH https://github.com/SirVer/ultisnips.git
$CLONE $DEPTH https://github.com/dietsche/vim-lastplace.git
$CLONE $DEPTH https://github.com/markcornick/vim-bats.git
$CLONE $DEPTH https://github.com/mattn/gist-vim.git
$CLONE $DEPTH https://github.com/mattn/webapi-vim.git
$CLONE $DEPTH https://github.com/nice/sweater.git
$CLONE $DEPTH https://github.com/tpope/vim-markdown.git
$CLONE $DEPTH https://github.com/tpope/vim-repeat.git
$CLONE $DEPTH https://github.com/tpope/vim-surround.git
$CLONE $DEPTH https://github.com/NLKNguyen/papercolor-theme.git
