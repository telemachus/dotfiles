#!/usr/bin/env bash

set -e
DOTFILES="$HOME/Documents/git-repos/dotfiles"
BASE="$HOME/.config/nvim"
PACK="$BASE/pack"
BUNDLE="$PACK/bundle"
OPT="$BUNDLE/opt"
START="$BUNDLE/start"


if [[ -d "$PACK" ]]; then
	printf "Backing up %s directory to %s/old-nvim…\n" "$PACK" "$HOME"
	mv -v "$PACK" "$HOME/old-nvim"
fi

mkdir -p "$BUNDLE"
mkdir -p "$OPT"
mkdir -p "$START"
mkdir -p "$HOME/.nvim_backups"
mkdir -p "$HOME/.nvim_undo"
if [[ ! -f "$BASE/init.vim" ]]; then
	ln -s "$DOTFILES/vim/vimrc" "$BASE/init.vim"
fi

CLONE="git clone"

cd "$START" || exit

$CLONE https://git.sr.ht/~telemachus/vim-dotfiles
# $CLONE https://git.sr.ht/~telemachus/vim-textobj-curly
$CLONE https://github.com/SirVer/ultisnips.git
# $CLONE https://github.com/bps/vim-textobj-python.git
$CLONE https://github.com/cormacrelf/vim-colors-github.git
$CLONE https://github.com/dietsche/vim-lastplace.git
# $CLONE https://github.com/inkarkat/SyntaxAttr.vim.git
# $CLONE https://github.com/junegunn/vader.vim
$CLONE https://github.com/kana/vim-textobj-entire.git
$CLONE https://github.com/kana/vim-textobj-line.git
$CLONE https://github.com/kana/vim-textobj-user.git
$CLONE https://github.com/lambdalisue/suda.vim.git
$CLONE https://github.com/machakann/vim-sandwich.git
$CLONE https://github.com/sainnhe/edge.git
$CLONE https://github.com/tpope/vim-abolish.git
$CLONE https://github.com/tpope/vim-commentary.git
$CLONE https://github.com/tpope/vim-dispatch.git
$CLONE https://github.com/tpope/vim-markdown.git
$CLONE https://github.com/tpope/vim-repeat.git
$CLONE https://github.com/vim-scripts/indentpython.vim.git
