#!/usr/bin/env dash

set -e

if [ -d "$PWD/bin" ]; then
    if [ ! -d "$HOME/bin" ]; then
        mkdir "$HOME/bin"
    fi

    for item in "$PWD/bin"/*
    do
        if [ ! -f "$HOME/bin/${item##*/}" ]; then
            ln -s "$item" "$HOME/bin/${item##*/}"
        else
            printf "$item already exists.\n" >&2
        fi
    done
fi
