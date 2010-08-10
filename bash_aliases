### Bash alias file
### Peter Aronoff
### 2010-08-10

# enable color support of ls and also add handy aliases
if [[ "$TERM" != "dumb" ]]; then
    alias ls='gls --color=auto'
    alias dir='ls --format=vertical'
    alias vdir='ls --format=long'
fi

# some more ls aliases
alias l='ls'
alias ll='ls -l'
alias la='ls -A'
alias lf='ls -CF'
alias l.='ls -d .[^.]*'
alias l.f='l. -F'
alias ll.='l. -l'

# aliases for safety
alias rmi='rm -i'
alias cpi='cp -i'
alias mvi='mv -i'

# aliases for clarity
alias cpv='gcp -v'
alias rmv='grm -v'
alias mvv='gmv -v'

# two cd aliases
alias ..='cd ..'
alias ...='cd ../../'

# alias to add or edit aliases
alias realias='vim ~/.bash_aliases;source ~/.bash_aliases'

# alias to add or edit functions
alias refunction='vim ~/.bash_functions;source ~/.bash_functions'

# a few git aliases
alias gs='git status'
alias gd='git diff'
alias gdh='git diff HEAD'
alias gl='git pull'
alias gp='git push'
alias sched='ruby $HOME/bin/schedule.rb'

# View current playlist with numbers
alias nlist='mpc playlist | cat -n -'
