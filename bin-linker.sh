#!/usr/bin/env bash

set -e

if [[ -d "$PWD/bin" ]]; then
    if [[ ! -d "$HOME/bin" ]]; then
        mkdir "$HOME/bin"
    fi

    for item in "$PWD/bin"/*
    do
        if [[ ! -f "$HOME/bin/${item##*/}" ]]; then
            ln -s "$item" "$HOME/bin/${item##*/}"
        else
            printf "%s already exists.\n" "$item" >&2
        fi
    done
fi
