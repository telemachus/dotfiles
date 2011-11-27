### Bash alias file
### Peter Aronoff
### 2010-08-10

# enable color support of ls and also add handy aliases
if [[ "$TERM" != "dumb" ]]; then
    alias ls='ls -G'
    alias dir='ls --format=vertical'
    alias vdir='ls --format=long'
fi

# some more ls aliases
alias l='ls'
alias ll='ls -l'
alias la='ls -A'
alias lf='ls -CF'
alias l.='ls -d .[^.]* 2>/dev/null'
alias l.f='l. -F'
alias ll.='l. -l'

# aliases for safety
alias rmi='rm -i'
alias rmp='rm -P'
alias cpi='cp -i'
alias mvi='mv -i'

# aliases for clarity
alias cpv='cp -v'
alias rmv='rm -v'
alias mvv='mv -v'

# make my life easier
alias cpr='cp -r'

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
alias nanoc='nanoc3'

# bugger
alias b='bundle'
alias bi='b install --path vendor'
alias bil='bi --local'
alias be='b exec'
alias bu='b update'
alias binit='bi && b package && echo "vendor/ruby" >> .gitignore'
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'
