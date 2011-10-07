#!/usr/bin/env dash

if [ $# = 0 ]; then
    mvim
else
    here=$(pwd)
    mvim --servername ${here##*/} \
         --remote-tab-silent "$@" 1>/dev/null 2>&1
fi
