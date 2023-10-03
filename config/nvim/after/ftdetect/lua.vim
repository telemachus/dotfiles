autocmd FileType lua compiler luacheck
command! -nargs=+ -complete=file -bar Lint silent lmake <args>

