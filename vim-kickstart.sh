#!/usr/bin/env bash

set -e
DOTFILES="$HOME/Documents/git-repos/dotfiles"
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

git clone https://git.sr.ht/~telemachus/vim-dotfiles
git clone https://git.sr.ht/~telemachus/vim-go-mini
git clone https://git.sr.ht/~telemachus/vim-textobj-curly
git clone https://github.com/EgZvor/vim-black.git
git clone https://github.com/SirVer/ultisnips.git
git clone https://github.com/bps/vim-textobj-python.git
git clone https://github.com/cespare/vim-toml.git
git clone https://github.com/cormacrelf/vim-colors-github.git
git clone https://github.com/dietsche/vim-lastplace.git
git clone https://github.com/inkarkat/SyntaxAttr.vim.git
git clone https://github.com/junegunn/vader.vim.git
git clone https://github.com/kana/vim-textobj-entire.git
git clone https://github.com/kana/vim-textobj-function.git
git clone https://github.com/kana/vim-textobj-line.git
git clone https://github.com/kana/vim-textobj-user.git
git clone https://github.com/lambdalisue/suda.vim.git
git clone https://github.com/machakann/vim-sandwich.git
git clone https://github.com/pbrisbin/vim-colors-off.git
git clone https://github.com/tpope/vim-commentary.git
git clone https://github.com/tpope/vim-markdown.git
git clone https://github.com/tpope/vim-repeat.git
git clone https://github.com/ds26gte/neoscmindent.git
