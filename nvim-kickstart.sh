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
$CLONE $DEPTH https://github.com/mattn/gist-vim.git
$CLONE $DEPTH ttps://github.com/NLKNguyen/papercolor-theme.git
$CLONE $DEPTH ttps://github.com/nice/sweater.git
$CLONE $DEPTH ttps://github.com/SirVer/ultisnips.git
$CLONE $DEPTH ttps://github.com/tpope/vim-abolish.git
$CLONE $DEPTH ttps://github.com/markcornick/vim-bats.git
$CLONE $DEPTH ttps://github.com/telemachus/vim-bibcite.git
$CLONE $DEPTH ttps://github.com/tpope/vim-commentary.git
$CLONE $DEPTH ttps://github.com/dietsche/vim-lastplace.git
$CLONE $DEPTH ttps://bitbucket.org/telemachus/vim-macrons.git
$CLONE $DEPTH ttps://github.com/tpope/vim-markdown.git
$CLONE $DEPTH ttps://github.com/wlangstroth/vim-racket.git
$CLONE $DEPTH ttps://github.com/tpope/vim-repeat.git
$CLONE $DEPTH ttps://github.com/machakann/vim-sandwich.git
$CLONE $DEPTH ttps://github.com/Pychimp/vim-sol.git
$CLONE $DEPTH ttps://github.com/tpope/vim-surround.git
$CLONE $DEPTH ttps://github.com/reedes/vim-textobj-quote.git
$CLONE $DEPTH ttps://github.com/kana/vim-textobj-user.git
$CLONE $DEPTH ttps://bitbucket.org/telemachus/vim-varia.git
$CLONE $DEPTH ttps://github.com/mattn/webapi-vim.git
