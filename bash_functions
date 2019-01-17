# Clean up git formulas
brew-purge()
{
    brew rm "$@" && brew cleanup -s
}

# Use ack to search my history file; pipe to less if necessary
hack()
{
    var=$(history | ack $1 | grep -v 'bin/ack' | wc -l)
    if (( $var > 22 ))
    then
        history | ack $1 | grep -v '; hack' | less
    else
        history | ack $1 | grep -v '; hack'
    fi
}

# Use ack to search output of ps ax; pipe to less if necessary
pack()
{
    var=$(ps ax | ack $1 | grep -v 'bin/ack' | wc -l)
    if (( $var > 22 ))
    then
        ps ax | ack $1 | grep -v 'bin/ack' | less
    else
        ps ax | ack $1 | grep -v 'bin/ack'
    fi
}

# start mpd if it's not already running
mp_start() {
    count=$(ps -c | grep mpd | wc -l)
    if (( $count > 0 ))
    then
        mpd --no-daemon &
        # mpdscribble --no-daemon &
        mpc clear
    fi
}

mycc() {
  output=${2:-"${1%.c}"}
  clang -Wall -W -pedantic -std=c99 -o "$output" "$1"
}

# ksh-style "cd old new" for bash
# "ccd old new" replaces old with new throughout $PWD and then tries
# to cd to the new path
#
# This works very well for eg $HOME/mmt/2010/compsci2/grades ->
# $HOME/mmt/2010/compsci3/grades which I have to do constantly
#
# Shamelessly stolen from Learning the Bash Shell (3ed), Cameron Newham
# & Bill Rosenblatt
ccd() {
    case "$#" in
        0|1)
            builtin cd $1
            ;;
        2)
            newdir=${PWD//$1/$2}
            case "$newdir" in
                $PWD)
                    printf "ccd: \$PWD is already $PWD\n" >&2
                    return 1
                    ;;
                *)
                    builtin cd "$newdir"
                    pwd
                    ;;
            esac
            ;;
        *)
            printf "ccd: wrong arg count\n" 1>&2
            return 1
            ;;
    esac
}

## See https://twitter.com/#!/mlafeldt/status/192195940164173824
# Get the absolute directory, symlinks resolved
realdir() {
    ( cd -P -- "${1:-.}" && pwd )
}

# Preview a markdown document in bcat
preview() {
    markdown "$1" | bcat
}

# Create a directory and cd into it
mkcd() {
    mkdir "$1" && cd "$1"
}

colors() {
    printf "red orange yellow green blue indigo violet\n"
}

bumpvim() {
    brew up
    brew uninstall vim
    brew install vim
}

shorten() {
    curl -s --data-urlencode "long_url=${1:-$(pbpaste)}" \
        http://metamark.net/api/rest/simple | pbcopy
}

csview () {
 <$1 sed -e 's/,,/, ,/g' | column -s, -t | less -#5 -N -S
}

renvim() {
	brew-purge neovim && brew install --HEAD neovim && \
		nbundleup && pup
}

relat() {
	osascript -e 'quit app "Preview"' && make "$1" && \
		open "${1}.pdf"
}

rede() {
	osascript -e 'quit app "Preview"' && make descartes && \
		open "descartes.pdf"
}

mytop() {
        re='^[0-9]+$'
        if ! [[ $1 =~ $re ]] ; then
           echo "error: $1 not a number" >&2
        else
	    sed 's/^.*;//' "$HOME/.bash_history" | sed '/^#/d' | \
		awk '{a[$1]++} END {for (i in a) print a[i], i}' | \
		sort -rn | head -n $1
        fi
}

pup() {
	pip2 install --upgrade setuptools pip wheel pynvim
	pip3 install --upgrade setuptools pip wheel cltk pynvim
	chruby-exec ruby-2.5.3 -- gem install neovim
}
