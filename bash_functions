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

# Get a password and copy it to the clipboard with pbcopy and pwsafe
# FIXME
pw() {
    pwsafe -p $1 | ruby -e 'print gets.chomp' | pbcopy
}

# start mpd if it's not already running
mp_start() {
    count=$(ps -c | grep mpd | wc -l)
    if (( $count > 0 ))
    then
        mpd --no-daemon &
    fi
}
