export MAILDIR=$HOME/.maildir
export NO_COLOR=1

export VISUAL=nvim
export EDITOR="$VISUAL"
export VIMCONFIG="$HOME/.vim"
export VIMDATA="$HOME/.vim"
# -R = READONLY mode; -i NONE = no SHADA
export PAGER=less
export LESS='-GRJx4P?f[%f]:[STDIN].?pB - [%pB\%]:\.\.\..'
export MANPAGER='nvim +Man! -i NONE'

# Set PARINIT for par. How did I pick these values?
export PARINIT='rTbgqR B=.,?_A_a Q=_s>|'
# vim may live in $HOME/local/vim
if [[ -d "${HOME}/local/vim" ]]; then
	PATH="${HOME}/local/vim/bin:${PATH}"
fi

# passage lives in $HOME/local/passage
if [[ -d ${HOME}/local/passage ]]; then
    PATH="${PATH}:${HOME}/local/passage/bin"
fi

# neovim probably lives in $HOME/local/neovim
if [[ -d ${HOME}/local/neovim ]]; then
	PATH="${PATH}:${HOME}/local/neovim/bin"
fi

# go probably lives in $HOME/local/go
if [[ -d $HOME/local/go/bin ]]; then
    PATH="${HOME}/local/go/bin:${PATH}"
fi
# go environment probably lives in $HOME/go
if [[ -d ${HOME}/go ]]; then
    export GOPATH="${HOME}/go"
    export GOBIN="${HOME}/go/bin"
    PATH="${PATH}:${GOBIN}"
fi

# postgres
if [[ -d /Applications/Postgres.app ]]; then
    PATH="${PATH}:/Applications/Postgres.app/Contents/Versions/latest/bin"
fi

# lua-language-server
if [[ -d $HOME/local/lua-language-server/bin ]]; then
    PATH="${HOME}/local/lua-language-server/bin:${PATH}"
fi

# rust
if [[ -r $HOME/.cargo/env ]]; then
	source "$HOME/.cargo/env"
fi

# zig may live in $HOME/local/zig
if [[ -r $HOME/local/zig/zig ]]; then
    PATH="${HOME}/local/zig:${PATH}"
fi

# lua probably lives in $HOME/local/lua
if [[ -d $HOME/local/lua ]]; then
    PATH="${HOME}/local/lua/bin:${PATH}"
fi

# pipx, rust-analyzer and (possibly) others live in ~/.local/bin
# I need this to end up *before* the cargo/rustup PATH.
# See the following discussion on GitHub for why:  https://bit.ly/3MESyZ3.
# TODO: investigate what ~/.cargo/env does to PATH.
if [[ -d ${HOME}/.local/bin ]]; then
    PATH="${HOME}/.local/bin:${PATH}"
fi

export PATH
