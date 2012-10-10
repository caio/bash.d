__prompt_reset_color() {
    bashd_prompt_append "${RESET_COLORS} "
}

bashd_prompt_register __prompt_reset_color
