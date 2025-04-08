" Run as follows: vim -es -u "${HOME}/.vim/headless-plug.vim" -U NONE

let data_dir = '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
endif

call plug#begin('~/.vim/pack/bundle/start')

Plug 'dietsche/vim-lastplace'
Plug 'hrsh7th/vim-vsnip'
Plug 'inkarkat/SyntaxAttr.vim'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-function'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-user'
Plug 'machakann/vim-sandwich'
Plug 'telemachus/vim-dotfiles'
Plug 'telemachus/vim-textobj-curly'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'
Plug 'LunarWatcher/auto-pairs'

call plug#end()

:PlugInstall
:PlugUpdate
:PlugClean!

:helptags ALL

:quitall
