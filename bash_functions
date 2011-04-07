# Use ack to search my history file; pipe to less if necessary
hack()
{
    var=$(history | ack $1 | wc -l)
    if (( $var > 22 ))
    then
        history | ack $1 | less
    else
        history | ack $1
    fi
}

# Use ack to search output of ps ax; pipe to less if necessary
pack()
{
    var=$(ps ax | ack $1 | wc -l)
    if (( $var > 22 ))
    then
        ps ax | ack $1 | less
    else
        ps ax | ack $1
    fi
}

# start mpd if it's not already running
mp_start() {
    count=$(ps -c | grep mpd | wc -l)
    if (( $count > 0 ))
    then
        mpd --no-daemon &
        mpdscribble --no-daemon &
        mpc clear
    fi
}

mycc() {
  output=${2:-"${1%.c}"}
  clang -Wall -W -pedantic -std=c99 -o "$output" "$1"
}

# ksh-style "cd old new" for bash
# "my_cd old new" replaces old with new throughout $PWD and then tries
# to cd to the new path
#
# This works very well for eg $HOME/mmt/2010/compsci2/grades ->
# $HOME/mmt/2010/compsci3/grades which I have to do constantly
#
# Shamelessly stolen from Learning the Bash Shell (3ed), Cameron Newham
# & Bill Rosenblatt
my_cd() {
    case "$#" in
        0|1)
            builtincd $1
            ;;
        2)
            newdir=${PWD//$1/$2}
    case "$newdir" in
        $PWD)
            echo "bash: my_cd: bad substitution" >&2
            return 1
            ;;
        *)
            builtin cd "$newdir"
            ;;
        esac
            ;;
        *)
            echo "bash: my_cd: wrong arg count" 1>&2
            return 1
            ;;
        esac
}

pw ()
{
    if grep -q $1 $HOME/.passes_list; then
        pass=$(pwsafe -qp $1)
        printf "%s" ${pass##"\n"} | pbcopy
    else
        printf "No such item found in your passwords.\n"
    fi
}
