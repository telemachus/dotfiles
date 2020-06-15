#!/usr/bin/env bash

set -e
DOTFILES="$HOME/projects/dotfiles"
BASE="$HOME/.vim"
PACK="$BASE/pack"
BUNDLE="$PACK/bundle"
OPT="$BUNDLE/opt"
START="$BUNDLE/start"

if [[ -d "$PACK" ]]; then
	printf "Backing up current %s directory to %s/old-vim…\n" \
		"$PACK" "$HOME"
	mv -v "$PACK" "$HOME/old-vim"
fi

mkdir -p "$OPT"
mkdir -p "$START"
mkdir -p "$HOME/.vim_backups"
mkdir -p "$HOME/.vim_undo"
if [[ ! -f "$HOME/.vimrc" ]]; then
    if [[ -f "$DOTFILES/vim/vimrc" ]]; then
        ln -s "$DOTFILES/vim/vimrc" "$HOME/.vimrc"
    fi
fi

CLONE="git clone"

cd "$START" || exit

$CLONE https://git.telemachus.me/vim-bibcite
$CLONE https://git.telemachus.me/vim-macrons
$CLONE https://git.telemachus.me/vim-textobj-curly
$CLONE https://git.telemachus.me/vim-varia
$CLONE https://github.com/NLKNguyen/papercolor-theme.git
$CLONE https://github.com/SirVer/ultisnips.git
$CLONE https://github.com/bps/vim-textobj-python.git
$CLONE https://github.com/cespare/vim-toml.git
$CLONE https://github.com/dietsche/vim-lastplace.git
$CLONE https://github.com/inkarkat/SyntaxAttr.vim.git
$CLONE https://github.com/junegunn/seoul256.vim.git
$CLONE https://github.com/junegunn/vader.vim
$CLONE https://github.com/kana/vim-textobj-entire.git
$CLONE https://github.com/kana/vim-textobj-line.git
$CLONE https://github.com/kana/vim-textobj-user.git
$CLONE https://github.com/lambdalisue/suda.vim.git
$CLONE https://github.com/machakann/vim-sandwich.git
$CLONE https://github.com/nice/sweater.git
$CLONE https://github.com/notpratheek/vim-sol.git
$CLONE https://github.com/nvie/vim-flake8.git
$CLONE https://github.com/sainnhe/edge.git
$CLONE https://github.com/tpope/vim-abolish.git
$CLONE https://github.com/tpope/vim-commentary.git
$CLONE https://github.com/tpope/vim-dispatch.git
$CLONE https://github.com/tpope/vim-markdown.git
$CLONE https://github.com/tpope/vim-repeat.git
$CLONE https://github.com/vim-scripts/indentpython.vim.git
