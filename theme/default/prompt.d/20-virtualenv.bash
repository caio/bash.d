__prompt_virtualenv() {
    local envname=$(basename $VIRTUAL_ENV 2>/dev/null)
    if [ -n "$envname" ]; then
        bashd_prompt_append " ${FG_YELLOW}·${envname}·"
    fi
}

bashd_prompt_register __prompt_virtualenv
