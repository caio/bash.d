__prompt_return_code() {
    if [ $LAST_STATUS -gt 0 ]; then
        bashd_prompt_append " ${FG_BOLD_RED}${LAST_STATUS}!"
    fi
}

bashd_prompt_register __prompt_return_code
