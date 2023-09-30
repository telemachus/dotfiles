" See :help ft-vim-indent; default is shiftwidth() * 3, which is far too much
let g:vim_indent_cont = shiftwidth()

" For https://github.com/tpope/vim-markdown
let g:markdown_fenced_languages =
    \ ['html', 'python', 'lua', 'bash=sh', 'tex', 'go', 'c']
let g:markdown_syntax_conceal = 0
