#!/usr/bin/env dash

set -e

if [ -e $HOME/.vim ]; then
    printf "Backing up current .vim directory to $HOME/old-vim...\n"
    mv $HOME/.vim $HOME/old-vim
fi

if [ -e $HOME/.vimrc ]; then
    printf "Backing up current .vimrc to $HOME/old-vimrc...\n"
    mv $HOME/.vimrc $HOME/old-vimrc
fi

if [ -e $HOME/.gvimrc ]; then
    printf "Backing up current .gvimrc to $HOME/old-gvimrc...\n"
    mv $HOME/.gvimrc $HOME/old-gvimrc
fi

ln -s $HOME/code/dotfiles/vim/vimrc $HOME/.vimrc
ln -s $HOME/code/dotfiles/vim/gvimrc $HOME/.gvimrc

mkdir $HOME/.vim
mkdir $HOME/.vim/bundle
mkdir $HOME/.vim/ftbundle
mkdir $HOME/.vim/ftbundle/coffeescript
mkdir $HOME/.vim/ftbundle/haskell
mkdir $HOME/.vim/ftbundle/html
mkdir $HOME/.vim/ftbundle/javascript
mkdir $HOME/.vim/ftbundle/markdown
mkdir $HOME/.vim/ftbundle/perl
mkdir $HOME/.vim/ftbundle/ruby
mkdir $HOME/.vim/ftbundle/scss


cd $HOME/.vim/bundle
git clone https://github.com/mileszs/ack.vim.git
git clone https://github.com/Raimondi/delimitMate.git
git clone https://github.com/sjl/strftimedammit.vim.git
git clone https://github.com/tomtom/tcomment_vim.git
git clone https://github.com/tpope/vim-endwise.git
git clone https://github.com/tpope/vim-fugitive.git
git clone https://github.com/tpope/vim-git.git
git clone https://github.com/tpope/vim-repeat.git
git clone https://github.com/tpope/vim-surround.git
git clone https://github.com/kana/vim-textobj-lastpat.git
git clone https://github.com/kana/vim-textobj-user.git
git clone https://github.com/bronson/vim-trailing-whitespace.git
git clone https://github.com/sunaku/vim-unbundle.git
git clone https://github.com/telemachus/vim-varia.git
git clone https://github.com/wincent/Command-T.git
cd $HOME/.vim/bundle/Command-T/ruby/command-t
/usr/bin/ruby extconf.rb
make

cd $HOME/.vim/ftbundle/coffeescript
git clone https://github.com/kchmck/vim-coffee-script.git

cd $HOME/.vim/ftbundle/haskell
git clone https://github.com/lukerandall/haskellmode-vim.git

cd $HOME/.vim/ftbundle/html
git clone https://github.com/gregsexton/MatchTag.git

cd $HOME/.vim/ftbundle/javascript
git clone https://github.com/pangloss/vim-javascript.git

cd $HOME/.vim/ftbundle/markdown
git clone http://github.com/sukima/vim-markdown.git

cd $HOME/.vim/ftbundle/perl
git clone https://github.com/telemachus/vim-perlbrew.git

cd $HOME/.vim/ftbundle/ruby
git clone http://github.com/tpope/vim-rake.git
git clone https://github.com/telemachus/vim-rbenv.git
git clone https://github.com/vim-ruby/vim-ruby.git
git clone https://github.com/nelstrom/vim-textobj-rubyblock.git

cd $HOME/.vim/ftbundle/scss
git clone https://github.com/cakebaker/scss-syntax.vim.git
