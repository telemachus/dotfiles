zcompare() {
    if [[ -s ${1} && ( ! -s ${1}.zwc || ${1} -nt ${1}.zwc ) ]]; then
        zcompile ${1}
    fi
}

{
    zcompare "${ZDOTDIR}/.zshrc"

    for func in ~/.config/zsh/functions/^*.zwc(N); do
        zcompare "$func"
    done

    for comp in ${ZDOTDIR}/completions/^*.zwc(N); do
        zcompare "$comp"
    done
} &!

# vim: set ts=8 sw=4 ts=4 tw=0 et ft=zsh :
