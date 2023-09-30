CompilerSet makeprg=golangci-lint\ run
CompilerSet errorformat=%A%f:%l:%c:\ %m,%-G%.%#

" Explanation of the error format:
"
" %A  = start of a multi-line message of unspecified type
" %f  = file name
" %l  = line number
" %c  = column number
" %m  = error message
" ,   = next format pattern
" %-G = ignore this message
" %.  = equivalent to . in a regex, meaning any one character
" %#  = equivalent to * in a regex, meaning any number of times
" Thus %.%# is errorformat for .* in a regex.
"
" In a nutshell, this errorformat says “Grab the first line of output from
" golangci-lint, and ignore everything else.”
