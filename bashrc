# shellcheck shell=bash
if [[ $PS1 && -n $GHOSTTY_RESOURCES_DIR ]]; then
    builtin source \
        "${GHOSTTY_RESOURCES_DIR}/shell-integration/bash/ghostty.bash"
fi

## A few global settings
# + check the window size after each command and, if necessary,
#   update the values of LINES and COLUMNS.
# + learn the damn Emacs bindings at least a little
# + don't offer command completion on empty lines
# + tips for cd: https://bit.ly/3n8uWyn and https://bit.ly/3ek6LJm
# + set MAILDIR for mu
# + set NO_COLOR
shopt -s checkwinsize
set -o emacs
shopt -s no_empty_cmd_completion
complete -d cd
shopt -s autocd
shopt -s cdspell
export MAILDIR=$HOME/.maildir
export NO_COLOR=1

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
export VISUAL=nvim
export EDITOR="$VISUAL"

export VIMCONFIG="$HOME/.vim"
export VIMDATA="$HOME/.vim"

# Use CDPATH to make life better
CDPATH=::$HOME:$HOME/Documents/git-repos/trinity:$HOME/Documents/git-repos:$HOME/Documents

## Pager stuff
# MANPAGER=less
# export MANPAGER
export PAGER=less
export LESS='-GRJx4P?f[%f]:[STDIN].?pB - [%pB\%]:\.\.\..'

# Set PARINIT for par. How did I pick these values?
export PARINIT='rTbgqR B=.,?_A_a Q=_s>|'

get_sha() {
    git rev-parse --short HEAD 2>/dev/null
}

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_SHOWCOLORHINTS=
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="auto git"

export PS1='$(__git_ps1 "{%s $(get_sha)}")\u \W \$ '

if [[ $VIM ]]; then
    PS1='\$ '
fi

# Only add the following for login shells.
if [[ $PS1 ]]; then
    # Includes
    [[ -f $HOME/.bash_aliases ]] && source "$HOME/.bash_aliases"
    [[ -f $HOME/.bash_functions ]] && source "$HOME/.bash_functions"

    # Local bash completion
    [[ -f $HOME/.bash_completion ]] && source "$HOME/.bash_completion"

    # MacPorts bash completion
    if [[ -r /opt/local/etc/profile.d/bash_completion.sh ]]; then
        source /opt/local/etc/profile.d/bash_completion.sh
    fi

    if [[ -r /opt/local/share/git/contrib/completion/git-prompt.sh ]]; then
        source /opt/local/share/git/contrib/completion/git-prompt.sh
    fi

    # vim may live in $HOME/local/vim
    [[ -d "${HOME}/local/vim" ]] && PATH="${HOME}/local/vim/bin:${PATH}"

    # passage may lives in $HOME/local/passage
    if [[ -d ${HOME}/local/passage ]]; then
        PATH="${PATH}:${HOME}/local/passage/bin"
        pc="${HOME}/local/passage/share/completions/passage.bash"
        [[ $PS1 && -r $pc ]] && source "$pc"
    fi

    # neovim probably lives in $HOME/local/neovim
    [[ -d ${HOME}/local/neovim ]] && PATH="${PATH}:${HOME}/local/neovim/bin"

    # go probably lives in $HOME/local/go
    if [[ -d $HOME/local/go/bin ]]; then
        PATH="${HOME}/local/go/bin:${PATH}"
    fi

    # go environment probably lives in $HOME/go
    if [[ -d ${HOME}/go ]]; then
        export GOPATH="${HOME}/go"
        export GOBIN="${HOME}/go/bin"
        PATH="${PATH}:${GOBIN}"
    fi

    # postgres
    if [[ -d /Applications/Postgres.app ]]; then
        PATH="${PATH}:/Applications/Postgres.app/Contents/Versions/latest/bin"
    fi

    # pipx
    if [[ -d ${HOME}/.local/bin ]]; then
        PATH="${PATH}:${HOME}/.local/bin"
    fi

    # rust
    [[ -r $HOME/.cargo/env ]] && source "$HOME/.cargo/env"

    # zig may live in $HOME/local/zig
    if [[ -r $HOME/local/zig/zig ]]; then
        PATH="${HOME}/local/zig:${PATH}"
    fi

    # lua probably lives in $HOME/local/lua
    if [[ -d $HOME/local/lua ]]; then
        LUA_PATH='/Users/telemachus/local/lua/share/lua/5.1/?.lua;./?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/Users/telemachus/.luarocks/share/lua/5.1/?.lua;/Users/telemachus/.luarocks/share/lua/5.1/?/init.lua;/Users/telemachus/local/lua/share/lua/5.1/?/init.lua'
        LUA_CPATH='./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/Users/telemachus/.luarocks/lib/lua/5.1/?.so;/Users/telemachus/local/lua/lib/lua/5.1/?.so'
        PATH="${HOME}/local/lua/bin:${PATH}"
    fi
fi

# MacPorts path help
CPATH="/opt/local/include:${CPATH}"
LD_LIBRARY_PATH="/opt/local/lib:${LD_LIBRARY_PATH}"
PKG_CONFIG_PATH="/opt/lib/pkgconfig:${PKG_CONFIG_PATH}"
C_INCLUDE_PATH="/opt/local/include:${C_INCLUDE_PATH}"
CPLUS_INCLUDE_PATH="/opt/local/include:${CPLUS_INCLUDE_PATH}"
LIBRARY_PATH="/opt/local/lib:${LIBRARY_PATH}"

export PATH

#export neatvi='set noshape | set ai | set aw | set ic | set nohl'

# I only need this if I'm using alacritty
# :-$LANG prevents the export setting from breaking iTerm2.
# export LANG="${LC_ALL:-$LANG}"
# unset LC_ALL
