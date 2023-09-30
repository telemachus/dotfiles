autocmd FileType go compiler golangci
command -nargs=0 -bar Lint :silent lmake
