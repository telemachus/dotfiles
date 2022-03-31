# ksh-style "cd old new" for bash
# "ccd old new" replaces old with new throughout $PWD and then tries
# to cd to the new path
#
# This works very well for eg $HOME/mmt/2010/compsci2/grades ->
# $HOME/mmt/2010/compsci3/grades which I have to do constantly
#
# Shamelessly stolen from Learning the Bash Shell (3ed), Cameron Newham
# & Bill Rosenblatt

ccd()
{
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

colors256() {
        local c i j

        printf "Standard 16 colors\n"
        for ((c = 0; c < 17; c++)); do
                printf "|%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
        done
        printf "|\n\n"

        printf "Colors 16 to 231 for 256 colors\n"
        for ((c = 16, i = j = 0; c < 232; c++, i++)); do
                printf "|"
                ((i > 5 && (i = 0, ++j))) && printf " |"
                ((j > 5 && (j = 0, 1)))   && printf "\b \n|"
                printf "%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
        done
        printf "|\n\n"

        printf "Greyscale 232 to 255 for 256 colors\n"
        for ((; c < 256; c++)); do
                printf "|%s%3d%s" "$(tput setaf "$c")" "$c" "$(tput sgr0)"
        done
        printf "|\n"
}
# vim: set ts=8 sw=8 tw=0 noet ft=sh :

