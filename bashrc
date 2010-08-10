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

if [ -f $HOME/.git-completion.sh ]; then
    source $HOME/.git-completion.sh
fi

if [ -f $HOME/.amazon_keys ]; then
    source $HOME/.amazon_keys
fi

if [ -f $HOME/.bash_perlbrew ]; then
    source $HOME/.bash_perlbrew
fi

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
export CDPATH=.:$HOME:$HOME/projects

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
rvm_project_rvmrc_default=1
export JEWELER_OPTS="--minitest --gemcutter --yard"
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

## TODO: FIXME
# color prompt
#PS1='\[\e[01;31m\]\u \W\[\e[00m\]\[\e[0;33m\]$(__git_ps1 " (%s)")\[\e[00m\] \[\e[01;31m\]\$ \[\e[00m\]'
red='\[\e[00;31m\]'
yellow='\[\e[00;33m\]'
end='\[\e[m\]'
gps='$(__git_ps1 " (%s)")'
PS1="${red}\u \W${end}${yellow}${gps}${end} ${red}\$${end} "  


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;[ ${USER} ${PWD} ]\007"'
    ;;
*)
    ;;
esac

## Pager stuff
#MANPAGER=less
#export MANPAGER
LESS='-GRJx4P?f[%f]:[STDIN].?pB - [%pB\%]:\.\.\..'
export LESS
LESSOPEN="|/usr/local/bin/lesspipe.sh %s"
export LESSOPEN
