#!/usr/bin/env bash
# TODO: rewrite this in python

set -e


START="$HOME/.config/nvim/pack/bundle/start"

info() { printf "$1\n"; }

get_remote_url() {
	git config --get remote.origin.url
}

git_dirty() {
	git diff-index --quiet --cached HEAD || info "Staged changes in $PWD"
	git diff-files --quiet || info "Untracked changes in $PWD"
}

git_untracked_files() {
	num="$(expr $(git status --porcelain 2>/dev/null | grep "^??" | wc -l))"
	if [[ $num -gt 0 ]]; then
		printf "%s untracked files in $PWD\n" "$num"
	fi
}

git_unpushed_changes() {
	num=$(git rev-list origin..HEAD | wc -l)
	if [[ $num -gt 0 ]]; then
		info "Commits that need to be pushed in $PWD"
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
			BRIEF="$(basename $PWD)"
			info "$BRIEF is not a git repository"
		fi
	fi
done
