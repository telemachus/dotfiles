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
    let l = line('.')
    let c = col('.')
    let _s = @/
    %s/\s\+$//e
    call cursor(l, c)
    let @/ = _s
endfun
