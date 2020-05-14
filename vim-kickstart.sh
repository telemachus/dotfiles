#!/usr/bin/env bash

set -e
DOTFILES="$HOME/projects/dotfiles"
BASE="$HOME/.vim"
PACK="$BASE/pack"
BUNDLE="$PACK/bundle"
OPT="$BUNDLE/opt"
START="$BUNDLE/start"

if [[ -d "$PACK" ]]; then
	printf "Backing up current $PACK directory to $HOME/old-vim…\n"
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

cd "$START"
$CLONE https://bitbucket.org/telemachus/vim-macrons.git
$CLONE https://bitbucket.org/telemachus/vim-varia.git
$CLONE https://github.com/NLKNguyen/papercolor-theme.git
$CLONE https://github.com/Pychimp/vim-sol.git
$CLONE https://github.com/SirVer/ultisnips.git
$CLONE https://github.com/cespare/vim-toml.git
$CLONE https://github.com/chrisbra/NrrwRgn.git
$CLONE https://github.com/dietsche/vim-lastplace.git
$CLONE https://github.com/inkarkat/SyntaxAttr.vim.git
$CLONE https://github.com/junegunn/goyo.vim.git
$CLONE https://github.com/junegunn/limelight.vim.git
$CLONE https://github.com/junegunn/seoul256.vim.git
$CLONE https://github.com/kana/vim-textobj-user.git
$CLONE https://github.com/lambdalisue/suda.vim.git
$CLONE https://github.com/machakann/vim-sandwich.git
$CLONE https://github.com/nvie/vim-flake8.git
$CLONE https://github.com/reedes/vim-textobj-quote.git
$CLONE https://github.com/sainnhe/edge.git
$CLONE https://github.com/telemachus/vim-bibcite.git
$CLONE https://github.com/telemachus/vim-dispatch.git
$CLONE https://github.com/telemachus/vim-textobj-entire.git
$CLONE https://github.com/tpope/vim-abolish.git
$CLONE https://github.com/tpope/vim-commentary.git
$CLONE https://github.com/tpope/vim-markdown.git
$CLONE https://github.com/tpope/vim-repeat.git
$CLONE https://github.com/vim-scripts/indentpython.vim.git
