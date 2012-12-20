# For testing
 # set -x
 # set -u

## A few global settings
# + check the window size after each command and, if necessary,
#   update the values of LINES and COLUMNS.
# + learn the damn Emacs bindings at least a little
# + don't offer command completion on empty lines
# + set term type and CLICOLOR
# + set MAILDIR for mu
shopt -s checkwinsize
set -o emacs
shopt -s no_empty_cmd_completion
export CLICOLOR=1
export MAILDIR=$HOME/.maildir

## Includes
[[ -f $HOME/.bash_aliases ]] && source $HOME/.bash_aliases

[[ -f $HOME/.bash_functions ]] && source $HOME/.bash_functions

bc="$HOME/local/bash-completion-2.0/share/bash-completion/bash_completion"
[[ $PS1 && -f $bc ]] && source $bc

[[ -f $HOME/.bash_completion ]] && source $HOME/.bash_completion

[[ -f /usr/local/Library/Contributions/brew_bash_completion.sh ]] \
    && source /usr/local/Library/Contributions/brew_bash_completion.sh

[[ -f $HOME/.amazon_keys ]] && source $HOME/.amazon_keys

## History settings
# + bigger is better
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
export SVN_EDITOR=vim
export GIT_EDITOR='mvim -f -c"au VimLeave * !open -a Terminal"'
export EDITOR=vim

# Use CDPATH to make life better
CDPATH=::$HOME:$HOME/code
INFOPATH=/usr/local/share/info:$INFOPATH
INFODIR=/usr/local/share/info:$INFODIR

## Perl varia
# put perlbrew where I want it and source it
# defaults for cpanminus
export PERLBREW_ROOT=$HOME/.perl5/perlbrew
if [[ -f $HOME/.perl5/perlbrew/etc/bashrc ]]; then
    source $HOME/.perl5/perlbrew/etc/bashrc
fi
export PERL_CPANM_OPT="--mirror file:///$HOME/.minicpan\
    --mirror http://cpan.cpantesters.org"

## The prompt below gets ideas from the following:
# http://briancarper.net/blog/570/git-info-in-your-zsh-prompt
# http://github.com/adamv/dotfiles/blob/master/bashrc
# http://wiki.archlinux.org/index.php/Color_Bash_Prompt
# txtred='\[\e[0;31m\]' # Red
# txtwht='\[\e[0;37m\]' # White
# bldred='\[\e[1;31m\]' # Red
# bldgrn='\[\e[1;32m\]' # Green
# bldylw='\[\e[1;33m\]' # Yellow
# bldwht='\[\e[1;37m\]' # White
# bldcyn='\[\e[1;36m\]' # Cyan
# end='\[\e[0m\]'       # Text Reset

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
GIT_PS1_SHOWUPSTREAM="auto git"

# if [ $VIM ]; then export PS1=...

export PS1='\u \W$(__git_ps1 " [%s $(get_sha)]")\$ '
export PROMPT_COMMAND='set_titlebar "$USER@${HOSTNAME%%.*} $(get_dir)"'

## Pager stuff
# MANPAGER=less
# export MANPAGER
export PAGER=less
LESS='-GRJx4P?f[%f]:[STDIN].?pB - [%pB\%]:\.\.\..'
export LESS
[[ -e /usr/local/bin/lesspipe ]] \
    && LESSOPEN="|/usr/local/bin/lesspipe.sh %s"
export LESSOPEN

[[ -d $HOME/bin ]] && export PATH=$PATH:$HOME/bin

[[ -d "/Applications/Postgres.app" ]] &&
    PATH="/Applications/Postgres.app/Contents/MacOS/bin:$PATH"

# Set up JS-Test-Driver
# export JSTESTDRIVER_HOME=$HOME/bin
# export HOMEBREW_VERBOSE=1
# export HOMEBREW_USE_GCC=1
# export CC=gcc-4.2
# export CXX=g++-4.2
[[ -f $HOME/.lua_config.lua ]] && export LUA_INIT="@$HOME/.lua_config.lua"
command -v luarocks >/dev/null && eval "$(luarocks path)"
# [ -n "$TMUX"  ] && export TERM=screen-256color

# Let's try chruby for a while
source /usr/local/opt/chruby/share/chruby/chruby.sh
RUBIES=( $HOME/.rubies/* )
# chruby 1.9.3

# From http://mah.everybody.org/docs/ssh
SSH_ENV="$HOME/.ssh/environment"

start_agent() {
    printf "Initializing new SSH agent...\n"
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    printf "Successful start of SSH agent.\n"
    chmod 600 "${SSH_ENV}"
    source "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
}

# # Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    source "${SSH_ENV}" > /dev/null
    ps -ef | grep "${SSH_AGENT_PID}" | grep ssh-agent$ > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi

chruby 1.9.3
