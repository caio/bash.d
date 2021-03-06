__prompt_ssh_hostname() {
    if [ -n "$SSH_CLIENT" ]; then
        bashd_prompt_append "${FG_BOLD_GREEN}$(hostname -s) "
    fi
    if [[ $SSH_AUTH_SOCK =~ dropbear ]]; then
        bashd_prompt_append "${FG_BOLD_RED}$(hostname -s) "
    fi
}

bashd_prompt_register __prompt_ssh_hostname
