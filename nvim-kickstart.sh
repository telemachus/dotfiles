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
git clone https://git.sr.ht/~telemachus/nvim-dotfiles
git clone https://git.sr.ht/~telemachus/vim-textobj-curly
git clone https://github.com/RRethy/nvim-treesitter-textsubjects.git
git clone https://github.com/bps/vim-textobj-python.git
git clone https://github.com/cespare/vim-toml.git
git clone https://github.com/cormacrelf/vim-colors-github.git
git clone https://github.com/crispgm/nvim-go.git
git clone https://github.com/dcampos/nvim-snippy.git
git clone https://github.com/dietsche/vim-lastplace.git
git clone https://github.com/inkarkat/SyntaxAttr.vim.git
git clone https://github.com/junegunn/vader.vim.git
git clone https://github.com/kana/vim-textobj-entire.git
git clone https://github.com/kana/vim-textobj-function.git
git clone https://github.com/kana/vim-textobj-line.git
git clone https://github.com/kana/vim-textobj-user.git
git clone https://github.com/lambdalisue/suda.vim.git
git clone https://github.com/lukas-reineke/indent-blankline.nvim.git
git clone https://github.com/machakann/vim-sandwich.git
git clone https://github.com/neovim/nvim-lspconfig.git
git clone https://github.com/nvim-lua/plenary.nvim.git
git clone https://github.com/nvim-lua/popup.nvim.git
git clone https://github.com/nvim-treesitter/nvim-treesitter-textobjects.git
git clone https://github.com/nvim-treesitter/nvim-treesitter.git
git clone https://github.com/nvim-treesitter/playground
git clone https://github.com/owickstrom/vim-colors-paramount.git
git clone https://github.com/projekt0n/github-nvim-theme.git
git clone https://github.com/telemachus/vim-colors-off.git
git clone https://github.com/tpope/vim-commentary.git
git clone https://github.com/tpope/vim-markdown.git
git clone https://github.com/tpope/vim-repeat.git
git clone https://github.com/tree-sitter/tree-sitter-go
