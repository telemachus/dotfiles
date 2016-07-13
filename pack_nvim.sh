#!/usr/bin/env dash

BUNDLE_HOME="$HOME"/.config/nvim/bundle

info() { printf "$1\n"; }

get_remote_url() {
	git config --get remote.origin.url
}

git_dirty() {
	git diff-index --quiet --cached HEAD || info "Staged changes in $PWD"
	git diff-files --quiet || info "Untracked changes in $PWD"
}

git_untracked_files() {
	num=$(expr $(git status --porcelain 2>/dev/null | grep "^??" | wc -l))
	if [ $num -gt 0 ]; then
		printf "%s untracked files in $PWD\n" "$num"
	fi
}

git_unpushed_changes() {
	num=$(git rev-list origin..HEAD | wc -l)
	if [ $num -gt 0 ]; then
		info "Commits that need to be pushed in $PWD"
	fi
}

cd "$BUNDLE_HOME"
for item in *
do
	if [ -d "$BUNDLE_HOME/$item" -a -d "$BUNDLE_HOME/$item/.git" ]; then
		cd "$BUNDLE_HOME/$item"
		info "$(get_remote_url)"
	fi
done

cd "$BUNDLE_HOME"
for item in *
do
	if [ -d "$BUNDLE_HOME/$item" ]; then
		cd "$BUNDLE_HOME/$item"
		if [ -d "$PWD/.git" ]; then
			git_dirty
			git_untracked_files
			git_unpushed_changes
		else
			short=$(basename $PWD)
			info "$short is not a git repository"
		fi
	fi
done
