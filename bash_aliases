# Disable color support of ls and also add handy aliases
alias l='ls --color=none'
alias ll='ls -l'
alias la='ls -A'
alias lf='ls -CF'
alias l.='ls -d .[^.]* 2>/dev/null'
alias l.f='l. -F'
alias l.l='ls -ld .[^.]* 2>/dev/null'

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

# Two cd aliases
# There's also `shopt -s autocd`, but I like these, and I'm used to them.
alias ..='cd ..'
alias ...='cd ../../'

# Alias to add or edit aliases
alias realias='$EDITOR ~/.bash_aliases && source ~/.bash_aliases'

# Alias to add or edit functions
alias refunction='$EDITOR ~/.bash_functions && source ~/.bash_functions'

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

# Everything old is new again
# alias vi='nvim'

# ctrl-l not working
alias ""=clear

# neomutt > mutt
alias mutt=neomutt

# simple python webserver
alias webserver='python3 -m http.server'

# simple python jsonlint
alias jsonlint='python3 -m json.tool'

# find executables: see this comment on Stack Overflow.
# https://bit.ly/3BRvXjT
# For an alternative, see this answer on Stack Overflow.
# https://stackoverflow.com/a/4458361/26702
alias findexecs='find . -type f -perm -a=x'

# vim: set ts=8 sw=8 tw=0 noet ft=sh :
