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

cd "$START" || exit
git clone https://git.sr.ht/~telemachus/vim-dotfiles
git clone https://git.sr.ht/~telemachus/vim-go-mini
git clone https://git.sr.ht/~telemachus/vim-textobj-curly
git clone https://github.com/SirVer/ultisnips.git
git clone https://github.com/bps/vim-textobj-python.git
git clone https://github.com/cespare/vim-toml.git
git clone https://github.com/chrisduerr/vim-undead.git
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
git clone https://github.com/owickstrom/vim-colors-paramount.git
git clone https://github.com/pappasam/vim-filetype-formatter.git
git clone https://github.com/telemachus/vim-colors-off.git
git clone https://github.com/tpope/vim-commentary.git
git clone https://github.com/tpope/vim-markdown.git
git clone https://github.com/tpope/vim-repeat.git
