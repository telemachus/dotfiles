# Base $HOME/.bashrc file
# Peter Aronoff
# 2010-08-10

## A few global settings
# + check the window size after each command and, if necessary,
#   update the values of LINES and COLUMNS.
# + learn the damn Emacs bindings at least a little
# + don't offer command completion on empty lines
# + set term type and CLICOLOR
shopt -s checkwinsize
set -o emacs
shopt -s no_empty_cmd_completion
export TERM=xterm-color
export CLICOLOR=1

## Includes
if [ -f $HOME/.bash_aliases ]; then
  source $HOME/.bash_aliases
fi

if [ -f $HOME/.bash_functions ]; then
  source $HOME/.bash_functions
fi

if [ -f $HOME/.bash_path ]; then
  source $HOME/.bash_path
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
fi

if [ -f /usr/local/Library/Contributions/brew_bash_completion.sh ]; then
    source /usr/local/Library/Contributions/brew_bash_completion.sh
fi

if [ -f $HOME/.amazon_keys ]; then
    source $HOME/.amazon_keys
fi

if [ -f $HOME/.bash_perlbrew ]; then
    source $HOME/.bash_perlbrew
fi

# Fuck steve jobs; just fuck him
chmod -fN $HOME/Movies $HOME/Public $HOME/Music
rm -rf $HOME/Movies $HOME/Public $HOME/Music

## History settings
# + bigger is better
# + no dups; no lines starting with a space
# + handle multiple sessions sanely
# + save multi-line commands as a single line
# + :...; turns the timestamp into a "do-nothing" command
export HISTSIZE=1000
export HISTCONTROL=ignoreboth
shopt -s histappend cmdhist
export HISTTIMEFORMAT=': %Y-%m-%d %I:%M:%S; '

## Editor settings
export SVN_EDITOR=vim
export GIT_EDITOR='mvim -f -c"au VimLeave * !open -a Terminal"'
export EDITOR=vim

# Use CDPATH to make life better
export CDPATH=.:$HOME:$HOME/code:$HOME/mmt/2010-2011

## Ruby varia
# source rvm
# use rvm defaults by directory
# enable rvm completion
# jeweler defaults
# layout defaults
if [ -s $HOME/.rvm/scripts/rvm ]; then
    source $HOME/.rvm/scripts/rvm
fi
if [[ -r $rvm_path/scripts/completion ]]; then
    source $rvm_path/scripts/completion
fi
export rvm_project_rvmrc_default=1
export LAYOUT_OPTS="--author:Peter Aronoff:--type:ruby"

## Perl varia
# put perlbrew where I want it and source it
# defaults for cpanminus
# a gross and utter hack to get my vim status line correct
export PERLBREW_ROOT=$HOME/.perl5/perlbrew
if [ -f $HOME/.perl5/perlbrew/etc/bashrc ]; then
    source $HOME/.perl5/perlbrew/etc/bashrc
fi
export PERL_CPANM_OPT="--mirror file:///Users/telemachus/.minicpan\
    --mirror http://cpan.cpantesters.org"

## The prompt below gets ideas from the following:
# http://briancarper.net/blog/570/git-info-in-your-zsh-prompt
# http://github.com/adamv/dotfiles/blob/master/bashrc
# http://wiki.archlinux.org/index.php/Color_Bash_Prompt
txtred='\[\e[0;31m\]' # Red
txtwht='\[\e[0;37m\]' # White
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldwht='\[\e[1;37m\]' # White
end='\[\e[0m\]'    # Text Reset

function parse_git {
    branch=$(__git_ps1 "%s")
    if [[ -z $branch ]]; then
        return
    fi

    local forward="⟰"
    local behind="⟱"
    local dot="•"

    remote_pattern_ahead="# Your branch is ahead of"
    remote_pattern_behind="# Your branch is behind"
    remote_pattern_diverge="# Your branch and (.*) have diverged"

    status="$(git status 2>/dev/null)"

    state=""
    if [[ $status =~ "working directory clean" ]]; then
        state=${bldgrn}${dot}${end}
    else
        if [[ $status =~ "Untracked files" ]]; then
            state=${bldred}${dot}${end}
        fi
        if [[ $status =~ "Changed but not updated" ]]; then
            state=${state}${bldylw}${dot}${end}
        fi
        if [[ $status =~ "Changes to be committed" ]]; then
            state=${state}${bldylw}${dot}${end}
        fi
    fi

    direction=""
    if [[ $status =~ $remote_pattern_ahead ]]; then
        direction=${bldgrn}${forward}${end}
    elif [[ $status =~ $remote_pattern_behind ]]; then
        direction=${bldred}${behind}${end}
    elif [[ $status =~ $remote_pattern_diverge ]]; then
        direction=${bldred}${forward}${end}${bldgrn}${behind}${end}
    fi

    branch=${txtwht}${branch}${end}
    git_bit="${bldred}[${end}${branch}${state}\
${git_bit}${direction}${bldred}]${end}"

    printf "%s" "$git_bit"
}

function set_titlebar {
    case $TERM in
        *xterm*|ansi|rxvt)
            printf "\033]0;%s\007" "$*"
            ;;
    esac
}

function set_prompt {
    local snowman=""
    git="$(parse_git)"

    PS1="${txtred}\u${end} ${txtred}\W${end}"
    if [[ -n "$git" ]]; then
        PS1="$PS1 $git ${bldcyn}❯❯${end} "
    else
        PS1="$PS1 ${bldcyn}❯❯${end} "
    fi
    export PS1

    set_titlebar "$USER@${HOSTNAME%%.*} $PWD"
}

export PROMPT_COMMAND=set_prompt

## Pager stuff
#MANPAGER=less
#export MANPAGER
LESS='-GRJx4P?f[%f]:[STDIN].?pB - [%pB\%]:\.\.\..'
export LESS
LESSOPEN="|/usr/local/bin/lesspipe.sh %s"
export LESSOPEN
