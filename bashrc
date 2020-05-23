# For testing
# set -x
# set -u

## A few global settings
# + check the window size after each command and, if necessary,
#   update the values of LINES and COLUMNS.
# + learn the damn Emacs bindings at least a little
# + don't offer command completion on empty lines
# + set MAILDIR for mu
shopt -s checkwinsize
set -o emacs
#shopt -s no_empty_cmd_completion
export MAILDIR=$HOME/.maildir

## Includes
[[ -f $HOME/.bash_aliases ]] && source $HOME/.bash_aliases

[[ -f $HOME/.bash_functions ]] && source $HOME/.bash_functions

export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
bcc="/usr/local/etc/profile.d/bash_completion.sh"
[[ $PS1 && -r $bcc ]] && source $bcc

bc="$HOME/local/bc/share/bash-completion/bash_completion"
[[ $PS1 && -r $bc ]] && source $bc

[[ $PS1 && -f $HOME/.bash_completion ]] && source $HOME/.bash_completion

## History settings
# + keep a very large history
# + no dups; no lines starting with a space
# + :...; turns the timestamp into a "do-nothing" command
# + handle multiple sessions sanely
# + save multi-line commands as a single line
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTCONTROL=ignoreboth
export HISTTIMEFORMAT=': %Y-%m-%d %I:%M:%S; '
shopt -s histappend
shopt -s cmdhist

## Editor settings
export SVN_EDITOR=nvim
export GIT_EDITOR=nvim
export EDITOR=nvim

export VIMCONFIG="$HOME/.vim"
export VIMDATA="$HOME/.vim"

export NVIMCONFIG="$HOME/.config/nvim"
export NVIMDATA="$HOME/.local/share/nvim"
export VISUAL=nvim

# Use CDPATH to make life better
CDPATH=::$HOME:$HOME/Documents/git-repos/trinity:$HOME/Documents/git-repos:$HOME/Documents
INFOPATH=/usr/local/share/info:$INFOPATH
INFODIR=/usr/local/share/info:$INFODIR

## FIGNORE
# FIGNORE=bst:aux:bbl:blg:pdf:fls:fdb_latexmk
#FIGNORE=.SO:.so:.o:.O

## The prompt below gets ideas from the following:
# http://briancarper.net/blog/570/git-info-in-your-zsh-prompt
# http://github.com/adamv/dotfiles/blob/master/bashrc
# http://wiki.archlinux.org/index.php/Color_Bash_Prompt

set_titlebar() {
    case $TERM in
        *xterm*|ansi|rxvt)
            printf "\033]0;%s\007" "$*"
            ;;
    esac
}

get_dir() {
    printf "%s" $(pwd | sed "s:$HOME:~:")
}

get_sha() {
    git rev-parse --short HEAD 2>/dev/null
}

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="auto git"

#export PS1='$(__git_ps1 "{%s $(get_sha)}")\$ '
export PROMPT_COMMAND='__git_ps1 "\u \W" "\\\$ " "{%s $(get_sha)}"; set_titlebar "$USER@${HOSTNAME%%.*} $(get_dir)"'

#export PROMPT_COMMAND='
#    set_titlebar "$USER@${HOSTNAME%%.*} $(get_dir)"
#    FIGNORE=bst:aux:bbl:blg:fls:fdb_latexmk
#'

# if [ "$VIM" ]; then
#     PS1='\$ '
# fi

## Pager stuff
# MANPAGER=less
# export MANPAGER
export PAGER=less
LESS='-GRJx4P?f[%f]:[STDIN].?pB - [%pB\%]:\.\.\..'
export LESS
[[ -e /usr/local/bin/lesspipe ]] \
    && LESSOPEN="|/usr/local/bin/lesspipe.sh %s"
export LESSOPEN

export HOMEBREW_NO_ANALYTICS=1
if [ -r "$HOME/.HOMEBREW_GITHUB_API_TOKEN"  ]; then
	source "$HOME/.HOMEBREW_GITHUB_API_TOKEN"
else
	export HOMEBREW_NO_GITHUB_API
fi
# export HOMEBREW_VERBOSE=1
# export HOMEBREW_USE_GCC=1
# export CC=gcc-4.2
# export CXX=g++-4.2
export RLWRAP_HOME="$HOME/.rlwrap"

# Initialization variables for levee
# autoindent: supply indentation while in insert mode
# autowrite: automatically write out changes before :next, :prev
# magic: use regular expressions in searches
# wrapscan: searches wrap around end of buffer
# ignorecase: searches ignore alphabetic case 
export \
    LVRC='autoindent autowrite magic wrapscan ignorecase nooverwrite nobell'
export PARINIT='rTbgqR B=.,?_A_a Q=_s>|'
#export neatvi='set noshape | set ai | set aw | set ic | set nohl' 

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
