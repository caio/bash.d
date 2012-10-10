test -z $BASHD_THEME && BASHD_THEME=default
BASHD_THEME_DIR=${BASHD_DIR}/theme/${BASHD_THEME}

declare -a BASHD_PROMPT_FUNCTIONS=();

bashd_prompt_register() {
    BASHD_PROMPT_FUNCTIONS=( "${BASHD_PROMPT_FUNCTIONS[@]}" "$1" )
}

bashd_prompt_append() {
    PS1="${PS1}${1}"
}

bashd_prompt_prepend() {
    PS1="${1}${PS1}"
}

bashd_prompt_set_ps1() {
    PS1=""
    for prompt_function in "${BASHD_PROMPT_FUNCTIONS[@]}"; do
        $prompt_function
    done
}

bash_prompt_cmd() {
    LAST_STATUS=$?
    bashd_prompt_set_ps1
    export PS1
}
export PROMPT_COMMAND=bash_prompt_cmd

bashd_source ${BASHD_THEME_DIR}/prompt.d/*
test -f ${BASHD_THEME_DIR}/dircolors && eval $(dircolors ${BASHD_THEME_DIR}/dircolors)
