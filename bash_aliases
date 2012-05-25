# Enable color support of ls and also add handy aliases
alias ls='ls -G'
alias l='ls'
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
alias ..='cd ..'
alias ...='cd ../../'

# Alias to add or edit aliases
alias realias='vim ~/.bash_aliases && source ~/.bash_aliases'

# Alias to add or edit functions
alias refunction='vim ~/.bash_functions && source ~/.bash_functions'

# A few git aliases
alias gs='git status'
alias gd='git diff'
alias gdh='git diff HEAD'
alias gl='git pull'
alias gp='git push'
alias sched='ruby $HOME/bin/schedule.rb'

# View current playlist with numbers
alias nlist='mpc playlist | cat -n -'

# Some bundler aliases
alias b='bundle'
alias bi='b install --path vendor'
alias bil='bi --local'
alias be='b exec'
alias bu='b update'
alias binit='bi && b package && echo "vendor/ruby" >> .gitignore'

# Lock my screen quickly
alias lock='/System/Library/CoreServices/"Menu Extras"/User.menu/Contents/Resources/CGSession -suspend'
