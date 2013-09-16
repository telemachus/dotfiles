#!/usr/bin/env dash
set -e

if [ "$1" = "-v" ]; then
    verbose=true
fi

for item in birthdays medical personal school; do
    if [ -f "${HOME}/.${item}.rem" ]; then
        if [ "$verbose" = "true" ]; then
            printf "First we'll remove the existing "
            rm -v "${HOME}/.${item}.rem"
        else
            rm "${HOME}/.${item}.rem"
        fi
    fi
done

if [ "$verbose" = "true" ]; then
    printf "Create %s/.reminders\n" "$HOME"
fi

for item in school medical personal birthdays; do
    printf "include %s/.%s.rem\n" "$HOME" "$item"
done > "$HOME/.reminders"

for item in "$(pwd)/reminders/"*; do
    if [ "$verbose" = "true" ]; then
        printf "Link ${item##*/} into \$HOME\n"
        ln -s "$item" "$HOME/.${item##*/}"
    else
        ln -s "$item" "$HOME/.${item##*/}"
    fi
done
