#!/usr/bin/env bash

set -u

for dir in drafts inbox junk recent search sent spam
do
	mkdir -v -p "$HOME"/.maildir/"${dir}"/{cur,new,tmp}
done

YEAR="$(date +%Y)"
for YYYY in $(seq 2009 "$YEAR")
do
	mkdir -v -p "$HOME"/.maildir/archive/"${YYYY}"/{cur,new,tmp}
done
