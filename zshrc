fpath=($HOME/.zfunctions $HOME/.zcompletions $fpath)

autoload -Uz compinit && compinit
autoload -Uz add-zsh-hook

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

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

setopt AUTO_CD
setopt CD_SILENT
setopt AUTO_LIST
setopt NO_AUTO_MENU
setopt NO_MENU_COMPLETE
setopt CASE_GLOB
setopt CASE_MATCH

CDPATH=::$HOME:$HOME/Documents/git-repos/trinity:$HOME/Documents/git-repos:$HOME/Documents

zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:*:make:*' tag-order 'targets'

zstyle ':completion:*:(ssh|scp|rsync):*' hosts $hosts
zstyle ':completion:*:(ssh|scp|rsync):*' users $users

# if [[ -d $HOME/.fzf/shell ]]; then
#     source "$HOME/.fzf/shell/completion.zsh"
#     source "$HOME/.fzf/shell/key-bindings.zsh"
# fi
#
# if type rg &> /dev/null; then
#     export FZF_DEFAULT_COMMAND='rg --files --hidden'
#     export FZF_DEFAULT_OPTS="
#     --height 40%
#     --layout=reverse
#     --border
#     --bind '?:toggle-preview'
#     --preview-window=:hidden
#     --preview='less {}'
#     --no-color "
# fi
#
# zle -N fzf-cd-widget
# bindkey '\C-j' fzf-cd-widget

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

ZSH_GIT_PROMPT_SHOW_STASH=1
# ZSH_GIT_PROMPT_SHOW_UPSTREAM_NAME=1

PROMPT='%3~ $(gitprompt)%# '
source ~/Downloads/src/git-prompt.zsh/git-prompt.zsh

(( $+aliases[run-help] )) && unalias run-help
autoload -Uz run-help
autoload -Uz run-help-git
autoload -Uz run-help-sudo
alias help=run-help
HELPDIR="/usr/share/zsh/$(zsh --version | cut -d' ' -f2)/help"
bindkey -M viins '^h' run-help

autoload -Uz mkcd
