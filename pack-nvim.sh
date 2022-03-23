#!/usr/bin/env bash
# TODO: rewrite this in python

set -e


START="$HOME/.config/nvim/pack/bundle/start"

info() { printf "%s\n" "$1"; }
warn() { info "$1" 1>&2; }

get_remote_url() {
	git config --get remote.origin.url
}

git_dirty() {
	if ! git diff-index --quiet HEAD; then
		warn "Uncommitted changes in $PWD."
	fi

	if [ -n "$(git ls-files --exclude-standard --others)" ]; then
		warn "Untracked files in $PWD."
	fi
}

git_untracked_files() {
	NUM="$(git status --porcelain 2>/dev/null | grep -c "^??")"
	if [[ $NUM -gt 0 ]]; then
		printf "%s untracked files in $PWD\n" "$NUM"
	fi
}

git_unpushed_changes() {
	NUM=$(git rev-list origin..HEAD | wc -l)
	if [[ $NUM -gt 0 ]]; then
		warn "Commits that need to be pushed in $PWD"
	fi
}

cd "$START"
for item in *
do
	if [[ -d "$START/$item" && -d "$START/$item/.git" ]]; then
		cd "$START/$item"
		info "$(get_remote_url)"
	fi
done | sort -t' ' -k 2

cd "$START"
for item in *
do
	if [[ -d "$START/$item" ]]; then
		cd "$START/$item"
		if [[ -d "$PWD/.git" ]]; then
			git_dirty
			git_untracked_files
			git_unpushed_changes
		else
			BRIEF="$(basename "$PWD")"
			info "$BRIEF is not a git repository"
		fi
	fi
done
