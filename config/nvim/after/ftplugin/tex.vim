scriptencoding utf-8
" Basic settings {{{
setlocal tabstop=8 softtabstop=4 shiftwidth=4 expandtab

" Set make to build and open the pdf
setlocal makeprg=latexmk\ -xelatex\ -bibtex\ %\ &&\ open\ build/%:r.pdf

" Soft wrap, please
setlocal textwidth=0
setlocal wrapmargin=0
setlocal wrap
setlocal linebreak
setlocal list
setlocal showbreak=↪
" }}}

" Automatically swap `` or '' for " and ` for ' {{{
"
" The TexQuotes and TexQuote methods are adapted from auctex.vim.
" http://www.vim.org/scripts/script.php?script_id=162
function! s:TexQuotes()
    let insert = '"'
    let left = getline('.')[col('.')-2]
    if left =~# '^\(\|\s\)$'
        let insert = '``'
    elseif left ==# '('
        let insert = '``'
    elseif left ==# '\'
        let insert = '"'
    else 
	let insert = "''"
    endif
    return insert
endfunction

function! s:TexQuote()
    let insert = "'"
    let left = getline('.')[col('.')-2]
    if left =~# '^\(\|\s\)$'
        let insert = '`'
    elseif left ==# '('
        let insert = '`'
    elseif left ==# '\'
        let insert = "'"
    endif
    return insert
endfunction

inoremap <silent> <buffer> " <C-R>=<SID>TexQuotes()<CR>
inoremap <silent> <buffer> ' <C-R>=<SID>TexQuote()<CR>
" }}}

" Specialized fold-marker [[-,-]] {{{
setlocal foldmarker=[[-,-]]
" }}}

" Surround addition {{{
if exists('g:loaded_surround')
	" vim-surround: l for `foo' and L for ``foo''
	let b:surround_{char2nr('l')} = "`\r'"
	let b:surround_{char2nr('L')} = "``\r''"
endif
" }}}
