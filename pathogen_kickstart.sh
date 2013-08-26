#!/usr/bin/env dash

set -e

if [ -e $HOME/.vim ]; then
    printf "Backing up current .vim directory to $HOME/old-vim...\n"
    mv $HOME/.vim $HOME/old-vim
fi

mkdir $HOME/.vim
mkdir $HOME/.vim/autoload
mkdir $HOME/.vim/bundle

cd $HOME/.vim/autoload
curl -so pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim
cd $HOME/.vim/bundle
git clone https://github.com/gregsexton/MatchTag.git
git clone https://github.com/mileszs/ack.vim.git
git clone https://github.com/jiangmiao/auto-pairs.git
git clone https://github.com/vim-scripts/bufexplorer.zip.git
git clone https://github.com/mattn/gist-vim.git
git clone https://github.com/telemachus/snipmate-snippets-bib.git
git clone https://github.com/sjl/strftimedammit.vim.git
git clone https://github.com/tomtom/tlib_vim.git
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git
git clone https://github.com/bling/vim-airline.git
git clone https://github.com/tpope/vim-commentary
git clone https://github.com/tpope/vim-endwise.git
git clone https://github.com/tpope/vim-eunuch
git clone https://github.com/terryma/vim-expand-region
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/tpope/vim-git.git
git clone http://github.com/sukima/vim-markdown.git
git clone http://github.com/tpope/vim-rake.git
git clone https://github.com/tpope/vim-repeat.git
git clone https://github.com/vim-ruby/vim-ruby.git
git clone https://github.com/sunaku/vim-ruby-minitest
git clone https://github.com/tpope/vim-scriptease.git
git clone https://github.com/garbas/vim-snipmate.git
git clone https://github.com/telemachus/vim-snippets.git
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/kana/vim-textobj-entire.git
git clone https://github.com/kana/vim-textobj-function.git
git clone https://github.com/kana/vim-textobj-indent
git clone https://github.com/kana/vim-textobj-lastpat.git
git clone https://github.com/nelstrom/vim-textobj-rubyblock.git
git clone https://github.com/kana/vim-textobj-underscore.git
git clone https://github.com/kana/vim-textobj-user.git
git clone https://github.com/kana/vim-textobj-line.git
git clone https://github.com/chriskempson/vim-tomorrow-theme.git
git clone https://github.com/bronson/vim-trailing-whitespace.git
git clone https://github.com/tpope/vim-unimpaired
git clone https://github.com/telemachus/vim-varia.git
git clone https://github.com/mattn/webapi-vim.git
git clone https://github.com/wincent/Command-T.git &&
    cd $HOME/.vim/bundle/Command-T/ruby/command-t &&
    $(which ruby) extconf.rb &&
    make
