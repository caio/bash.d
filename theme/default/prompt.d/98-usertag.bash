__prompt_usertag() {
    if [ "$UID" -eq "0" ]; then
        bashd_prompt_append " ${FG_RED}#"
    else
        bashd_prompt_append " ${FG_WHITE}$"
    fi
}

bashd_prompt_register __prompt_usertag
