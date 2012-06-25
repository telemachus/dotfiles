#!/usr/bin/env dash

if [ ! -d "$HOME/code" ]; then
    mkdir "$HOME/code"
fi

cd "$HOME/code"
git clone https://github.com/sstephenson/ruby-build.git
curl -so "$HOME/code/ruby-build/share/ruby-build/1.9.3-p194-falcon" \
    https://raw.github.com/gist/2985597/1648ee35307a6bac608712a7c2d269fe505fdf94/1.9.3-p194-falcon
git clone https://github.com/jayferd/ry.git
mkdir -p "$HOME/.rbfu/rubies"

rb="$HOME/code/ruby-build"
cd "$rb"
"$rb/bin/ruby-build" "$rb/share/ruby-build/1.9.3-p194-falcon" \
    "$HOME/.rbfu/rubies/1.9.3-p194-falcon"
"$rb/bin/ruby-build" "$rb/share/ruby-build/1.8.7-p358" \
    "$HOME/.rbfu/rubies/1.8.7-p358"
