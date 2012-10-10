__prompt_pythonbrew() {
    local PYBREW="$(which python 2>/dev/null|sed -n 's/.*Python-\([0-9].[0-9]\).*/\1/p')"
    if [ ! -z "$PYBREW" ]; then
        bashd_prompt_append " ${FG_PURPLE}∝${PYBREW}"
    fi
}

bashd_prompt_register __prompt_pythonbrew
