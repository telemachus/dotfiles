if [[ -n $ZSH_DEBUGRC ]]; then
    zmodload zsh/zprof
fi

# https://zsh.sourceforge.io/Doc/Release/Expansion.html#Filename-Generation
setopt EXTENDED_GLOB

HISTFILE=${XDG_DATA_HOME:=~/.local/share}/zsh/history

[[ -d $HISTFILE:h ]] || mkdir -p $HISTFILE:h

SAVEHIST=$(( 10 * 1000 ))
HISTSIZE=$(( 1.2 * SAVEHIST ))

setopt HIST_FCNTL_LOCK
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_NO_STORE
setopt HIST_VERIFY

# Let's try both CDPATH and hash -d.
CDPATH=::$HOME:$HOME/Documents/git-repos/trinity:$HOME/Documents/git-repos:$HOME/Documents
hash -d \
    zsh=$HOME/Downloads/src/zsh-launchpad \
    dots=$HOME/Documents/git-repos/dotfiles \
    trinity=$HOME/Documents/git-repos/trinity

# -U ensures each entry in these is unique (that is, discards duplicates).
export -U PATH path FPATH fpath MANPATH manpath
export -UT INFOPATH infopath

path=(
    # (N): null if file doesn't exist
    $HOME/local/go/bin(N)
    $HOME/local/lua/bin(N)
    $HOME/local/lua-language-server/bin(N)
    $HOME/local/neovim/bin(N)
    $HOME/local/passage/bin(N)
    $HOME/local/vim/bin(N)
    $HOME/.local/bin(N)
    $HOME/.cargo/bin
    $HOME/go/bin
    $HOME/bin(N)
    $path
)

# In order to be able to `autoload` a function for use on the command line, it
# either needs to be in the $fpath or you need to autoload by absolute path.
# Note: Zsh's completions system will automatically autoload completion
# functions inside dirs that are in the $fpath. So, no need to explicitly
# autoload those.
fpath=(
    $ZDOTDIR/functions
    $ZDOTDIR/completions
    $fpath
    # Add MacPort's dir to the end of $fpath, so that we use its completions
    # for commands that zsh doesn't already know how to complete.
    /opt/local/share/zsh/site-functions
)

autoload -Uz die info mkcd warn zsh_directory_name

export MAILDIR=$HOME/.maildir
export NO_COLOR=1
export VISUAL=nvim
export EDITOR="$VISUAL"
export VIMCONFIG=$HOME/.vim
export VIMDATA=$HOME/.vim

# Configure less:
# -G: no search highlighting
# -R: handle ANSI escape codes
# -J: show search locations in side column
# -x4: 4-space tabs
# P...: prompt containing [filename/STDIN] and [N%] for percentage through file.
export LESS='-GRJx4P?f[%f]:[STDIN].?pB - [%pB\%]:\.\.\..'
export PAGER=less

# Configure par:
# r: repeat quote prefixes
# T: handle tabs
# b: handle backspaces
# g: guess paragraphs
# q: handle nested quotes
# R: repeat non-whitespace prefixes
# B=.,?_A_a: body chars (punctuation + letters)
# Q=_s>|: quote chars (underscore, space, >, |)
export PARINIT='rTbgqR B=.,?_A_a Q=_s>|'

# Speed up compinit.
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
mkdir -p $XDG_CACHE_HOME/zsh
typeset -gH _comp_dumpfile=$XDG_CACHE_HOME/zsh/compdump

# Delay and store compdef calls for _defer_compinit.
typeset -ga _deferred_compdefs=()
compdef() {
    _deferred_compdefs+=( "${(j: :)${(@q+)@}}" )
}

compinit() {:}
autoload -Uz add-zsh-hook _defer_compinit
add-zsh-hook precmd _defer_compinit

# Don't let > silently overwrite files. To overwrite, use >! instead.
setopt NO_CLOBBER

# Treat comments pasted into the command line as comments, not code.
setopt INTERACTIVE_COMMENTS

# Don't treat non-executable files in your $path as commands. This makes sure
# they don't show up as command completions.
setopt HASH_EXECUTABLES_ONLY

# Enable ** and *** as shortcuts for **/* and ***/*, respectively.
# https://zsh.sourceforge.io/Doc/Release/Expansion.html#Recursive-Globbing
setopt GLOB_STAR_SHORT

# Sort numbers numerically, not lexicographically.
setopt NUMERIC_GLOB_SORT

setopt AUTO_CD
setopt CD_SILENT
setopt AUTO_LIST
setopt NO_AUTO_MENU
setopt NO_MENU_COMPLETE
setopt CASE_GLOB
setopt CASE_MATCH

# Enable the use of Ctrl-Q and Ctrl-S for keyboard shortcuts.
unsetopt FLOW_CONTROL

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

ZSH_GIT_PROMPT_SHOW_STASH=1
# Upstream name in the prompt is too noisy. Reconsider this later?
# ZSH_GIT_PROMPT_SHOW_UPSTREAM_NAME=1

autoload -Uz add-zsh-hook
add-zsh-hook chpwd prompt_chpwd

# Call prompt_chpwd now to set psvar for the first prompt. I need this function
# because I want something similar to %~ and %d but not exactly like either.
#
# Like %~, I want $HOME to be replaced by ~ everywhere.
# Like %d, I want named dirs to appear literally in prompts not as ~name.
prompt_chpwd

PROMPT='%v $(gitprompt)%# '

. ~/Downloads/src/git-prompt.zsh/git-prompt.zsh

# Ctrl-u
# - On the main prompt: Push aside your current command line, so you can type a
#   new one. The old command line is re-inserted when you press Ctrl-p or
#   automatically on the next command line.
# - On the continuation prompt: Move all entered lines to the main prompt, so
#   you can edit the previous lines.
bindkey '^u' push-line-or-edit
bindkey '^p' get-line

# Ctrl-H: Get help on your current command.
HELPDIR="/usr/share/zsh/$(zsh --version | cut -d' ' -f2)/help"
(( ${+aliases[run-help]} )) && unalias run-help
autoload -RUz run-help
zmodload -F zsh/parameter p:functions_source
autoload -Uz $functions_source[run-help]-*~*.zwc
bindkey -M viins '^h' run-help

# Alt-V: Show the next key combo's terminal code and state what it does.
bindkey '^[v' describe-key-briefly

# Alt-W: Type a widget name and press Enter to see the keys bound to it.
# Type part of a widget name and press Enter for autocompletion.
bindkey '^[w' where-is

# Ctrl-s: Prefix the current or previous command line with `sudo`.
() {
  bindkey '^s' $1  # Bind Ctrl-s to the widget below.
  zle -N $1         # Create a widget that calls the function below.
  $1() {            # Create the function.
    # If the command line is empty or just whitespace, then first load the
    # previous line.
    [[ $BUFFER == [[:space:]]# ]] &&
        zle .up-history

    # $LBUFFER is the part of the command line that's left of the cursor. This
    # way, we preserve the cursor's position.
    LBUFFER="sudo $LBUFFER"
  }
} .sudo

zstyle ':completion:*:make:*:targets' call-command true
zstyle ':completion:*:*:make:*' tag-order 'targets'

zstyle ':completion:*:(ssh|scp|rsync):*' hosts $hosts
zstyle ':completion:*:(ssh|scp|rsync):*' users $users

zstyle ':completion:*:*:git-(push|fetch):*' file-patterns ''
zstyle ':completion:*:*:git-(push|fetch):*' tag-order \
    'remotes recent-branches branches'

# Always set aliases _last,_ so they don't get used in function definitions.

# Movement
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'

# These aliases enable you to paste example code into the terminal without the
# shell complaining about the pasted prompt symbol.
alias %= \$=

# zmv lets you batch rename (or copy or link) files by using pattern matching.
# https://zsh.sourceforge.io/Doc/Release/User-Contributions.html#index-zmv
autoload -Uz zmv
alias zmv='zmv -Mv'
alias zcp='zmv -Cv'
alias zln='zmv -Lv'

# Associate file name .extensions with programs to open them.
# This lets you open a file just by typing its name and pressing enter.
# Note that the dot is implicit; `gz` below stands for files ending in .gz
alias -s {css,diff,go,html,json,lua,md,patch,txt,xml,yml,zsh}=$EDITOR
alias -s gz='gzip -l'
alias -s {log,out}='tail -F'

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

# Make my life easier.
alias cpr='cp -r'

# Use git more easily.
alias gs='git status -sb'
alias g.='gs .'
alias gd='git diff'
alias gdh='git diff HEAD'
alias gl='git pull'
alias gp='git push'

# View current playlist with numbers.
alias nlist='mpc playlist | cat -n -'

if [[ $OSTYPE == darwin* ]]; then
    # Lock my screen quickly.
    alias lock="osascript -e 'tell application \"System Events\" to keystroke \"q\" using {command down,control down}'"

    # Reindex spotlight.
    alias respotlight='sudo mdutil -E /'
fi

# Call head -n1 and tail -n1 quickly (f = first; l = last).
alias onef='head -n1'
alias onel='tail -n1'

# Count words mnemonically.
alias words='wc -w'

# neomutt > mutt
alias mutt=neomutt

# Find executables: see this comment on Stack Overflow.
# https://bit.ly/3BRvXjT
# For an alternative, see this answer on Stack Overflow.
# https://stackoverflow.com/a/4458361/26702
alias findexecs='find . -type f -perm -a=x'

# Run daily updates.
alias morning='sudo portup ; neoup'


# Profile zsh startup.
alias zprofile='time ZSH_DEBUGRC=1 zsh -i -c exit'

# Manually reload zcompdump.
 alias rebuildcomp='autoload -Uz _rebuild_compdump && _rebuild_compdump &|'

# Use `< file` to quickly view the contents of any text file.
READNULLCMD=$PAGER  # Set the program to use for this.


if [[ -n $ZSH_DEBUGRC ]]; then
    zprof
fi

# vim: set ts=8 sw=4 ts=4 tw=0 et ft=zsh :
