#!/usr/local/bin/bash

set -e
BASE="$HOME/.vim"

if [[ -d "$BASE/pack" ]]; then
    printf "Backing up current .vim/pack directory to $HOME/old-vim…\n"
    mv -v "$BASE/pack" "$HOME/old-vim"
fi

mkdir -p "$BASE/pack/bundle/"{opt,start}
mkdir -p "$HOME/.vim_backups"
mkdir -p "$HOME/.vim_undo"
if [[ ! -f "$HOME/.vimrc" ]]; then
	ln -s "$HOME/projects/dotfiles/vim/vimrc" "$HOME/.vimrc"
fi

CLONE="git clone"

cd "$BASE/pack/bundle/start"
$CLONE https://bitbucket.org/telemachus/vim-macrons.git
$CLONE https://bitbucket.org/telemachus/vim-varia.git
$CLONE https://github.com/NLKNguyen/papercolor-theme.git
$CLONE https://github.com/Pychimp/vim-sol.git
$CLONE https://github.com/SirVer/ultisnips.git
$CLONE https://github.com/dietsche/vim-lastplace.git
$CLONE https://github.com/junegunn/goyo.vim.git
$CLONE https://github.com/junegunn/limelight.vim.git
$CLONE https://github.com/junegunn/seoul256.vim.git
$CLONE https://github.com/kana/vim-textobj-line.git
$CLONE https://github.com/kana/vim-textobj-user.git
$CLONE https://github.com/lambdalisue/suda.vim.git
$CLONE https://github.com/machakann/vim-sandwich.git
$CLONE https://github.com/markcornick/vim-bats.git
$CLONE https://github.com/mattn/gist-vim.git
$CLONE https://github.com/mattn/webapi-vim.git
$CLONE https://github.com/nice/sweater.git
$CLONE https://github.com/reedes/vim-textobj-quote.git
$CLONE https://github.com/telemachus/vim-bibcite.git
$CLONE https://github.com/telemachus/vim-textobj-entire.git
$CLONE https://github.com/tpope/vim-abolish.git
$CLONE https://github.com/tpope/vim-commentary.git
$CLONE https://github.com/tpope/vim-markdown.git
$CLONE https://github.com/tpope/vim-repeat.git
$CLONE https://github.com/tpope/vim-surround.git
$CLONE https://github.com/wlangstroth/vim-racket.git
