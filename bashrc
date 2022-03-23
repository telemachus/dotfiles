## A few global settings
# + check the window size after each command and, if necessary,
#   update the values of LINES and COLUMNS.
# + learn the damn Emacs bindings at least a little
# + don't offer command completion on empty lines
# + tips for cd: https://bit.ly/3n8uWyn and https://bit.ly/3ek6LJm
# + set MAILDIR for mu
shopt -s checkwinsize
set -o emacs
shopt -s no_empty_cmd_completion
complete -d cd
# shopt -s autocd
shopt -s cdspell
export MAILDIR=$HOME/.maildir

## Includes
[[ -f $HOME/.bash_aliases ]] && source $HOME/.bash_aliases

[[ -f $HOME/.bash_functions ]] && source $HOME/.bash_functions

# Local bash completion
[[ $PS1 && -f $HOME/.bash_completion ]] && source $HOME/.bash_completion

# MacPorts bash completion
if [[ $PS1 && -r /opt/local/etc/profile.d/bash_completion.sh ]]; then
	source /opt/local/etc/profile.d/bash_completion.sh
fi

if [[ $PS1 && -r /opt/local/share/git/contrib/completion/git-prompt.sh ]]; then
	source /opt/local/share/git/contrib/completion/git-prompt.sh
fi

if [[ $PS1 && -r $HOME/local/exercism/share/exercism_completion.bash ]]; then
	source $HOME/local/exercism/share/exercism_completion.bash
fi

if [[ $- == *i* && -r /opt/local/share/fzf/shell/completion.bash ]]; then
	source /opt/local/share/fzf/shell/completion.bash
fi

if [[ $PS1 && -r /opt/local/share/fzf/shell/key-bindings.bash ]]; then
	source /opt/local/share/fzf/shell/key-bindings.bash
fi

## History settings
# + keep a very large history
# + no dups; no lines starting with a space
# + :...; turns the timestamp into a "do-nothing" command
# + do not append all sessions to ~/.bash_history; last shell closed wins
# + save multi-line commands as a single line
export HISTSIZE=1000000
export HISTFILESIZE=1000000
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT=': %Y-%m-%d %I:%M:%S %p; '
shopt -u histappend
shopt -s cmdhist

## Editor settings
export SVN_EDITOR=vim
export GIT_EDITOR=vim
export EDITOR=vim
export VISUAL=vim

export VIMCONFIG="$HOME/.vim"
export VIMDATA="$HOME/.vim"

export NVIMCONFIG="$HOME/.config/nvim"
export NVIMDATA="$HOME/.local/share/nvim"

# Use CDPATH to make life better
CDPATH=::$HOME:$HOME/Documents/git-repos/trinity:$HOME/Documents/git-repos:$HOME/Documents
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

# export PS1='$(__git_ps1 "{%s $(get_sha)}")\u \W \$ '
export PROMPT_COMMAND='__git_ps1 "${VIRTUAL_ENV:+[`basename $VIRTUAL_ENV`] }\u \W" "\\\$ " "{%s $(get_sha)}"; set_titlebar "$USER@${HOSTNAME%%.*} $(get_dir)"'

#export PROMPT_COMMAND='
#    set_titlebar "$USER@${HOSTNAME%%.*} $(get_dir)"
#    FIGNORE=bst:aux:bbl:blg:fls:fdb_latexmk
#'

if [ "$VIM" ]; then
    PS1='\$ '
fi

## Pager stuff
# MANPAGER=less
# export MANPAGER
export PAGER=less
LESS='-GRJx4P?f[%f]:[STDIN].?pB - [%pB\%]:\.\.\..'
export LESS

# export RLWRAP_HOME="$HOME/.rlwrap"

# Initialization variables for levee
# autoindent: supply indentation while in insert mode
# autowrite: automatically write out changes before :next, :prev
# magic: use regular expressions in searches
# wrapscan: searches wrap around end of buffer
# ignorecase: searches ignore alphabetic case 
export \
    LVRC='autoindent autowrite magic wrapscan ignorecase nooverwrite nobell'

# Set PARINIT for par. How did I pick these values?
export PARINIT='rTbgqR B=.,?_A_a Q=_s>|'

#export neatvi='set noshape | set ai | set aw | set ic | set nohl' 

# MacPorts path help
CPATH=/opt/local/include:${CPATH}
LD_LIBRARY_PATH=/opt/local/lib:${LD_LIBRARY_PATH}
PKG_CONFIG_PATH=/opt/lib/pkgconfig:${PKG_CONFIG_PATH}
C_INCLUDE_PATH=/opt/local/include:${C_INCLUDE_PATH}
CPLUS_INCLUDE_PATH=/opt/local/include:${CPLUS_INCLUDE_PATH}
LIBRARY_PATH=/opt/local/lib:${LIBRARY_PATH}

# vim lives in $HOME/local/vim
PATH="${HOME}/local/vim/bin:${PATH}"
# MANPATH="${HOME}/local/vim/share/man:${MANPATH}"

# passage lives in $HOME/local/passage
PATH="${PATH}:${HOME}/local/passage/bin"
pc="${HOME}/local/passage/share/bash-completion/completions/passage"
[[ $PS1 && -r $pc ]] && source $pc

# neovim lives in $HOME/local/neovim
PATH="${PATH}:${HOME}/local/neovim/bin"
# MANPATH="${HOME}/local/neovim/share/man:${MANPATH}"

# pyenv
export PYENV_ROOT="${HOME}/.pyenv"
PATH="${PYENV_ROOT}/bin:${PATH}"
if command -v pyenv 1>/dev/null 2>&1; then
	eval "$(pyenv init --path)"
	eval "$(pyenv virtualenv-init -)"
fi

# go
export GOPATH="/Users/telemachus/go"
export GOBIN="/Users/telemachus/go/bin"
PATH="${PATH}:${GOBIN}"

# postgres
PATH="${PATH}:/Applications/Postgres.app/Contents/Versions/latest/bin"
PATH="${PATH}:${HOME}/.local/bin"
export PATH
