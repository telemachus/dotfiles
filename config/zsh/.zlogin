# Compile zshell files for faster autoloading, but do so in a way that won't
# slow the shell down while it does the compiling.
#
# I took plenty of inspiration from znap.
#
# https://github.com/marlonrichert/zsh-snap
#
# Key points:
#   1. _deferred_compile only happens after the shell is interactive because
#      the preexec hook guarantees that the shell is fully loaded first.
#   2. _deferred_compile removes the hook so the function only runs once.
#   3. The compilation runs in a detached and backgrounded subshell using
#      `( ... ) ... &!`.
#   4. All output is suppressed using `&> /dev/null`. This can be a problem if
#      there are important errors.
#
zcompile_if_new() {
    if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc ) ]]; then
        zcompile ${1}
    fi
}

_deferred_compile() {
    add-zsh-hook -d preexec _deferred_compile

    (
        zcompile_if_new "${ZDOTDIR}/.zshrc"
        for func in ~/.config/zsh/functions/^*.zwc(N); do
            zcompile_if_new "$func"
        done
        for comp in ${ZDOTDIR}/completions/^*.zwc(N); do
            zcompile_if_new "$comp"
        done
    ) &> /dev/null &!
}

add-zsh-hook preexec _deferred_compile

# vim: set ts=8 sw=4 ts=4 tw=0 et ft=zsh :
