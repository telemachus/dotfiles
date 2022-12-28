#!/usr/bin/env bash

set -e

DOTFILES="$PWD"
GO_BASE="${HOME}/go"
GO_EXTRAS="${GO_BASE}/extras"

mkdir -p "${GO_BASE}/"{extras,notes,src} || exit 1

for extra in "${DOTFILES}/go-extras/"*
do
	ln -s -i "$extra" "${GO_EXTRAS}/${extra##*/}"
done
