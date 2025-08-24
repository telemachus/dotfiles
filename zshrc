if [[ -n $ZSH_DEBUGRC ]]; then
    zmodload zsh/zprof
fi

if [[ ! ~/.zshrc.zwc || ~/.zshrc -nt ~/.zshrc.zwc ]]; then
    zcompile ~/.zshrc
fi

fpath=($HOME/.zfunctions $HOME/.zcompletions $fpath)

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY
setopt APPEND_HISTORY
setopt HIST_NO_STORE

# Use vim bindings, but keep C-a and C-e from emacs.
bindkey -v
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

autoload -Uz up-line-or-beginning-search
autoload -Uz down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Fix backspace key after using ZLE
bindkey "^?" backward-delete-char

setopt AUTO_CD
setopt CD_SILENT
unsetopt AUTO_NAME_DIRS
setopt AUTO_LIST
setopt NO_AUTO_MENU
setopt NO_MENU_COMPLETE
setopt CASE_GLOB
setopt CASE_MATCH

CDPATH=::$HOME:$HOME/Documents/git-repos/trinity:$HOME/Documents/git-repos:$HOME/Documents

hash -d dots=$HOME/Documents/git-repos/dotfiles \
    trinity=$HOME/Documents/git-repos/trinity

zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:*:make:*' tag-order 'targets'

zstyle ':completion:*:(ssh|scp|rsync):*' hosts $hosts
zstyle ':completion:*:(ssh|scp|rsync):*' users $users

if [[ -d $HOME/local/lua ]]; then
    LUA_PATH='/Users/telemachus/local/lua/share/lua/5.1/?.lua;./?.lua;/usr/local/share/lua/5.1/?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/lib/lua/5.1/?/init.lua;/Users/telemachus/.luarocks/share/lua/5.1/?.lua;/Users/telemachus/.luarocks/share/lua/5.1/?/init.lua;/Users/telemachus/local/lua/share/lua/5.1/?/init.lua'
    LUA_CPATH='./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so;/Users/telemachus/.luarocks/lib/lua/5.1/?.so;/Users/telemachus/local/lua/lib/lua/5.1/?.so'
fi

# Disable color on ls and also add handy aliases
alias l='ls --color=none'
alias ll='l -l'
alias la='l -A'
alias lf='l -CF'
alias l.='l -d .[^.]* 2>/dev/null'
alias l.f='l -F -d .[^.]* 2>/dev/null'
alias l.l='l -ld .[^.]* 2>/dev/null'

# Aliases for safety
alias rmi='rm -i'
alias rmp='rm -P'
alias cpi='cp -i'
alias mvi='mv -i'

# Aliases for clarity
alias cpv='cp -v'
alias rmv='rm -v'
alias mvv='mv -v'

# Make my life easier
alias cpr='cp -r'

# A few git aliases
alias gs='git status -sb'
alias g.='gs .'
alias gd='git diff'
alias gdh='git diff HEAD'
alias gl='git pull'
alias gp='git push'

# View current playlist with numbers
alias nlist='mpc playlist | cat -n -'

# Lock my screen quickly
alias lock="osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down,control down}'"

# reindex spotlight
alias respotlight='sudo mdutil -E /'

# convenience invocation of head
alias one='head -n1'

# Make life simpler
alias words='wc -w'

# neomutt > mutt
alias mutt=neomutt

# find executables: see this comment on Stack Overflow.
# https://bit.ly/3BRvXjT
# For an alternative, see this answer on Stack Overflow.
# https://stackoverflow.com/a/4458361/26702
alias findexecs='find . -type f -perm -a=x'

# daily updates
alias morning='sudo portup ; neoup'

# aliases for movement
alias ..='cd ..'
alias ...='cd ../..'

# alias for profiling zsh startup
alias zprofile='time ZSH_DEBUGRC=1 zsh -i -c exit'

# alias to manually reload zcompdump
alias rebuildcomp='rm -f ~/.zcompdump* && autoload -Uz compinit && compinit'

ZSH_GIT_PROMPT_SHOW_STASH=1
# ZSH_GIT_PROMPT_SHOW_UPSTREAM_NAME=1

PROMPT='%3~ $(gitprompt)%# '
source ~/Downloads/src/git-prompt.zsh/git-prompt.zsh

HELPDIR="/usr/share/zsh/$(zsh --version | cut -d' ' -f2)/help"
(( ${+aliases[run-help]} )) && unalias run-help
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-sudo
alias help=run-help
bindkey -M viins '^h' run-help

zsh_directory_name() {
    emulate -L zsh

    if [[ $1 = n && $2 = git ]]; then
        local git_root=$(git rev-parse --show-toplevel 2>/dev/null)
        if [[ -n $git_root ]]; then
            typeset -ga reply=("$git_root")
            return 0
        fi
    fi

    return 1
}

# My personal functions
autoload -Uz info warn mkcd

_expand_abbrev() {
    # Get the current word
    local current_word="${LBUFFER##* }"

    if [[ "$current_word" == "G" ]]; then
        # Replace G with ~[git]/
        LBUFFER="${LBUFFER%G}~[git]/"
    else
        # Insert normal space
        LBUFFER="$LBUFFER "
    fi
}

zle -N _expand_abbrev
bindkey ' ' _expand_abbrev

if [[ -n $ZSH_DEBUGRC ]]; then
    zprof
fi

# vim: set ts=8 sw=4 ts=4 tw=0 et ft=zsh :
