#!/usr/bin/env dash
set -e

is_no() {
    [ "$1" = "n" ] || [ "$1" = "N" ] || [ "$1" = "NO" ] ||
        [ "$1" = "No" ] || [ "$1" = "no" ] || [ "$1" = "nO" ]
}

OLDB="$HOME/.bash_completion.d/git-completion.bash"
NEWB="/usr/local/etc/bash_completion.d/git-completion.bash"

OLDP="$HOME/.bash_completion.d/git-prompt.bash"
NEWP="/usr/local/etc/bash_completion.d/git-prompt.sh"

OLDHG="$HOME/.bash_completion.d/hg-completion.bash"
NEWHG="/usr/local/etc/bash_completion.d/hg-completion.bash"

for item in $OLDB $NEWB $OLDP $NEWP $OLDHG $NEWHG
do
    if [ ! -f "$item" ]; then
        printf "%s doesn't exist. It should. Aborting.\n" $item
        exit 1
    fi
done

if diff -q "$OLDB" "$NEWB" >/dev/null 2>&1; then
    printf "Identical:\n\t%s\n\t%s\n" $OLDB $NEWB
else
    printf "Updated:\n\t%s\n" "$NEWB"
    printf "Do you want to update it? (Y/n) "
    read answer
    if is_no "$answer"; then
        : # Do nothing
    else
        cp -v "$NEWB" "$OLDB"
    fi
fi

if diff -q "$OLDP" "$NEWP" >/dev/null 2>&1; then
    printf "Identical:\n\t%s\n\t%s\n" $OLDP $NEWP
else
    printf "Updated:\n\t%s\n" "$NEWP"
    printf "Do you want to update it? (Y/n) "
    read answer
    if is_no "$answer"; then
        : # Do nothing
    else
        cp -v "$NEWP" "$OLDP"
    fi
fi

if diff -q "$OLDHG" "$NEWHG" >/dev/null 2>&1; then
    printf "Identical:\n\t%s\n\t%s\n" $OLDHG $NEWHG
else
    printf "Updated:\n\t%s\n" "$NEWHG"
    printf "Do you want to update it? (Y/n) "
    read answer
    if is_no "$answer"; then
        : # Do nothing
    else
        cp -v "$NEWHG" "$OLDHG"
    fi
fi
