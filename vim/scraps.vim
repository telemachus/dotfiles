" quargs.vim
command! -nargs=0 -bar Qargs execute 'args ' . QuickfixFilenames()
function! QuickfixFilenames()
    let buffer_numbers = {}
    for item in getqflist()
        let buffer_numbers[item['bufnr']] = bufname(item['bufnr'])
    endfor
    return join(values(buffer_numbers))
endfunction

" Found on StackOverflow: http://xrl.us/bk3bir
fun! <SID>StripTrailingWhiteSpace()
    let l = line(".")
    let c = col(".")
    let _s = @/
    %s/\s\+$//e
    call cursor(l, c)
    let @/ = _s
endfun

autocmd BufWritePre *.js :call <SID>StripTrailingWhiteSpace()

"function! ErlPretty()
"  silent !erl -noshell -eval 'erl_tidy:file("%",[verbose]).' -s erlang halt
"endfunction
"nmap ep :execute ErlPretty()
nmap <silent><F4> :w<CR>:make<CR>:cw<CR>

" Modeline experiment
" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
  let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d :",
        \ &tabstop, &shiftwidth, &textwidth)
  let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
  call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Some Perl voodoo: insert Perl base & set filetype
inoremap ,perl #!/usr/bin/env perl<CR>use warnings;
    \<CR>use 5.014;<CR>use autodie;<CR><esc>:set filetype=perl<ENTER>i

