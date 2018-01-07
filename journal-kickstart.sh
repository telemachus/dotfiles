#!/usr/bin/env dash

set -e

repo="https://telemachus@bitbucket.org/telemachus/journal.git"
copy="$HOME/.journal"

if [ ! -d "$HOME/.journal" ]; then
	cd "$HOME"
	git clone "$repo" "$copy"
else
	printf "$HOME/.journal already exists.\n"
fi
