# Clean up brew formulas
brew-purge()
{
	brew rm "$@" && brew cleanup -s
}

# For use when removing brew packages
depsclean()
{
	echo -n "$(pbpaste)" | tr -d ',' | sed 's/ and / /' | pbcopy
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
	# FIXME TODO
	# If the user enters two wrong variables, they trigger the first
	# branch of this case statement. They should trigger a different
	# error message.
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
realdir()
{
	( cd -P -- "${1:-.}" && pwd )
}

# Create a directory and cd into it
mkcd()
{
	mkdir -p "$1" && cd "$1"
}

colors()
{
	printf "red orange yellow green blue indigo violet\n"
}

# relat() {
# 	osascript -e 'quit app "Preview"' && make "$1" && \
# 		open "${1}.pdf"
# }

# rede() {
# 	osascript -e 'quit app "Preview"' && make descartes && \
# 		open "descartes.pdf"
# }

# mytop()
# {
#         re='^[0-9]+$'
#         if ! [[ $1 =~ $re ]] ; then
#            echo "error: $1 not a number" >&2
#            return 1
#         else
# 	    sed 's/^.*;//' "$HOME/.bash_history" | sed '/^#/d' | \
# 		awk '{a[$1]++} END {for (i in a) print a[i], i}' | \
# 		sort -rn | head -n $1
#         fi
# }

# Use ack to search my history file; pipe to less if necessary
# hack()
# {
#     var=$(history | ack $1 | grep -v 'bin/ack' | wc -l)
#     if (( $var > 22 ))
#     then
#         history | ack $1 | grep -v '; hack' | less
#     else
#         history | ack $1 | grep -v '; hack'
#     fi
# }

# Use ack to search output of ps ax; pipe to less if necessary
# pack()
# {
#     var=$(ps ax | ack $1 | grep -v 'bin/ack' | wc -l)
#     if (( $var > 22 ))
#     then
#         ps ax | ack $1 | grep -v 'bin/ack' | less
#     else
#         ps ax | ack $1 | grep -v 'bin/ack'
#     fi
# }

# start mpd if it's not already running
# mp_start()
# {
#     count=$(ps -c | grep mpd | wc -l)
#     if (( $count > 0 ))
#     then
#         mpd --no-daemon &
#         # mpdscribble --no-daemon &
#         mpc clear
#     fi
# }

# mycc()
# {
#   output=${2:-"${1%.c}"}
#   clang -Wall -W -pedantic -std=c99 -o "$output" "$1"
# }

# Preview a markdown document in bcat
# preview()
# {
#     markdown "$1" | bcat
# }
depsclean() {
	echo -n "$(pbpaste)" | tr -d ',' | sed 's/ and / /' | pbcopy
}

## Functions for fzf
#
# fe [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fe() {
  IFS=$'\n' files=($(fzf --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# Modified version where you can press
#   - CTRL-O to open with `open` command,
#   - CTRL-E or Enter key to open with the $EDITOR
fo() {
  IFS=$'\n' out=("$(fzf --query="$1" --exit-0 --expect=ctrl-o,ctrl-e)")
  key=$(head -1 <<< "$out")
  file=$(head -2 <<< "$out" | tail -1)
  if [ -n "$file" ]; then
    [ "$key" = ctrl-o ] && open "$file" || ${EDITOR:-vim} "$file"
  fi
}
