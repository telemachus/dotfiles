#!/usr/bin/env bash
# TODO This is very broken. Do I mean to remove everything? Huh?

set -e

CLONE='git clone'
BUNDLE_DIR="$HOME/.vim/pack/bundle/start"

cd "$BUNDLE_DIR" || exit
$CLONE https://git.sr.ht/~telemachus/vim-bibcite
$CLONE https://git.sr.ht/~telemachus/vim-dotfiles/
$CLONE https://git.sr.ht/~telemachus/vim-textobj-curly
$CLONE https://github.com/PeterRincker/vim-argumentative.git
$CLONE https://github.com/SirVer/ultisnips.git
$CLONE https://github.com/benizi/vim-automkdir.git
$CLONE https://github.com/bps/vim-textobj-python.git
$CLONE https://github.com/cormacrelf/vim-colors-github.git
$CLONE https://github.com/dietsche/vim-lastplace.git
$CLONE https://github.com/inkarkat/SyntaxAttr.vim.git
$CLONE https://github.com/kana/vim-textobj-entire.git
$CLONE https://github.com/kana/vim-textobj-line.git
$CLONE https://github.com/kana/vim-textobj-user.git
$CLONE https://github.com/lambdalisue/suda.vim.git
$CLONE https://github.com/machakann/vim-sandwich.git
$CLONE https://github.com/tpope/vim-abolish.git
$CLONE https://github.com/tpope/vim-commentary.git
$CLONE https://github.com/tpope/vim-markdown.git
$CLONE https://github.com/tpope/vim-repeat.git
$CLONE https://github.com/vim-scripts/indentpython.vim.git
