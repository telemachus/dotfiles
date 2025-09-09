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
    if [[ -z "${1}" || -z "${2}" ]]; then
        return
    fi

    if [[ -s "${2}" && ( ! -s "${2}.zwc" || "${2}" -nt "${2}.zwc" ) ]]; then
        zcompile "${1}" "${2}"
    fi
}

_deferred_compile() {
    add-zsh-hook -d preexec _deferred_compile

    # For these files, zcompile will use its -R flag, which causes the contents
    # of the files to be copied into the shell's memory rather than mapped.
    #
    # Add files here such as startup items that are read once and then done.
    local -a r_files=(
        "${HOME}/.zshenv"
        "${ZDOTDIR}/.zlogin"
        "${ZDOTDIR}/.zshrc"
    )

    # For these files, zcompile will use its -M flag, which causes the contents
    # of the files to be mapped into the shell's memory rather than copied.
    #
    # Add files here such as functions and completions that are used repeatedly.
    local -a m_files=(
        "${HOME}"/.config/zsh/functions/^*.zwc(N)
        "${ZDOTDIR}"/completions/^*.zwc(N)
    )

    (
        for r_file in "${r_files[@]}"; do
            zcompile_if_new "-R" "$r_file"
        done

        for m_file in "${m_files[@]}"; do
            zcompile_if_new "-M" "$m_file"
        done
    ) &> /dev/null &!
}

(( ${+functions[add-zsh-hook]} )) || autoload -Uz add-zsh-hook
add-zsh-hook preexec _deferred_compile

# vim: set ts=8 sw=4 ts=4 tw=0 et ft=zsh :
