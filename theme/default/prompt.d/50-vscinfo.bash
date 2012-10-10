__prompt_vcsinfo() {
    __vcs_dir
    if [ ! -z "$__vcs_prefix" ]; then
        bashd_prompt_append " ${FG_BOLD_WHITE}${__vcs_prefix}${__vcs_ref}"
    fi
}

bashd_prompt_register __prompt_vcsinfo
