" Custom fold expression

" Code from https://superuser.com/a/990547/907
" See also the following
"   * https://bitbucket.org/atimholt/spiffy_foldtext/src/default/
"   * https://gist.github.com/sjl/3360978
"   * http://vimcasts.org/episodes/writing-a-custom-fold-expression/
"   * https://vimrcfu.com/snippet/20
function! NeatFoldText()
  let line = ' ' . substitute(getline(v:foldstart),
        \ '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
  let lines_count = v:foldend - v:foldstart + 1
  let lines_count_text = '| ' . printf('%10s', lines_count . ' lines') . ' |'
  let foldchar = matchstr(&fillchars, 'fold:\zs.')
  let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) .
        \ line, 0, (winwidth(0)*2)/3)
  let foldtextend = lines_count_text . repeat(foldchar, 8)
  let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.',
        \ 'x', 'g')) + &foldcolumn
  return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) .
        \ foldtextend
endfunction

set foldtext=NeatFoldText()
