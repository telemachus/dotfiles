fpath=($HOME/.zfunctions $HOME/.zcompletions $fpath)
autoload -Uz compinit && compinit
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

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

# setopt PROMPT_SUBST
# add-zsh-hook precmd vcs_info
#
# # Style the vcs_info message
# zstyle ':vcs_info:*' enable git
# # check-for-changes can be slow on large repos.
# zstyle ':vcs_info:git*' check-for-changes true
# zstyle ':vcs_info:git*' get-revision true
# zstyle ':vcs_info:git*' formats ' {%b %7.7i%u%c}'
# # Format when the repo is in an action (merge, rebase, etc)
# zstyle ':vcs_info:git*' actionformats '{%*}'
# zstyle ':vcs_info:git*' unstagedstr ' *'
# zstyle ':vcs_info:git*' stagedstr ' +'

# PROMPT='%3~ ${vcs_info_msg_0_}%# '
source /opt/local/share/git/contrib/completion/git-prompt.sh
get_sha() {
    git rev-parse --short HEAD 2>/dev/null
}

GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWSTASHSTATE=1
GIT_PS1_SHOWUNTRACKEDFILES=1
GIT_PS1_DESCRIBE_STYLE="branch"
GIT_PS1_SHOWUPSTREAM="auto git"

precmd() {
    __git_ps1 '%3~ ' '%# ' "{%s $(get_sha)}"
}
# PROMPT='%3~ $(__git_ps1 "{%s $(get_sha)}")%# '

zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:*:make:*' tag-order 'targets'

if [[ -d $HOME/.fzf/shell ]]; then
    source "$HOME/.fzf/shell/completion.zsh"
    source "$HOME/.fzf/shell/key-bindings.zsh"
fi

if type rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden'
    export FZF_DEFAULT_OPTS="
    --height 40%
    --layout=reverse
    --border
    --bind '?:toggle-preview'
    --preview-window=:hidden
    --preview='less {}'
    --no-color "
fi

zle -N fzf-cd-widget
bindkey '\C-j' fzf-cd-widget

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
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'

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

# vim: set ts=8 sw=4 et tw=80 ft=zsh :
