#!/usr/bin/env dash

set -e

if [[ -d "$HOME/.config/nvim/pack" ]]; then
    printf "Backing up current .config/nvim/pack directory to $HOME/old-nvim...\n"
    mv $HOME/.config/nvim/pack $HOME/old-nvim
fi

mkdir -p "$HOME/.config/nvim/pack/bundle/{opt,start}"
mkdir -p "$HOME/.nvim_backups"
mkdir -p "$HOME/.nvim_undo"
if [[ ! -f "$HOME/.config/nvim/init.vim" ]]; then
	ln -s "$HOME/projects/dotfiles/vim/nvimrc" "$HOME/.config/init.vim"
fi

CLONE="git clone"

cd "$HOME/.config/nvim/bundle"
"$CLONE" https://bitbucket.org/telemachus/vim-macrons.git
"$CLONE" https://bitbucket.org/telemachus/vim-varia.git
"$CLONE" https://github.com/NLKNguyen/papercolor-theme.git
"$CLONE" https://github.com/Pychimp/vim-sol.git
"$CLONE" https://github.com/SirVer/ultisnips.git
"$CLONE" https://github.com/dietsche/vim-lastplace.git
"$CLONE" https://github.com/junegunn/goyo.vim.git
"$CLONE" https://github.com/junegunn/limelight.vim.git
"$CLONE" https://github.com/junegunn/seoul256.vim.git
"$CLONE" https://github.com/kana/vim-textobj-user.git
"$CLONE" https://github.com/lambdalisue/suda.vim.git
"$CLONE" https://github.com/machakann/vim-sandwich.git
"$CLONE" https://github.com/markcornick/vim-bats.git
"$CLONE" https://github.com/mattn/gist-vim.git
"$CLONE" https://github.com/mattn/webapi-vim.git
"$CLONE" https://github.com/neomake/neomake.git
"$CLONE" https://github.com/nice/sweater.git
"$CLONE" https://github.com/reedes/vim-textobj-quote.git
"$CLONE" https://github.com/telemachus/vim-bibcite.git
"$CLONE" https://github.com/telemachus/vim-textobj-entire.git
"$CLONE" https://github.com/tpope/vim-abolish.git
"$CLONE" https://github.com/tpope/vim-commentary.git
"$CLONE" https://github.com/tpope/vim-markdown.git
"$CLONE" https://github.com/tpope/vim-repeat.git
"$CLONE" https://github.com/tpope/vim-surround.git
"$CLONE" https://github.com/wlangstroth/vim-racket.git
