__prompt_current_directory() {
    transform_pwd() {
        curdir="$@"
        curdir=${curdir/#~\/src\//:}
        curdir=${curdir/#:personal\//${FG_CYAN}➤${FG_BLUE}}
        curdir=${curdir/#:work\//${FG_RED}⚒${FG_BLUE}}
        curdir=${curdir/#:booking.com\//${FG_BOLD_WHITE}${BG_BLUE}B${FG_BOLD_CYAN}${BG_BLUE}.${FG_BLUE}}

        curdir=${curdir/#~\/etc\//${FG_PURPLE}ж${FG_BLUE}}
        echo $curdir
    }

    local CUR_DIR=${PWD/$HOME/\~}
    bashd_prompt_append "${FG_BLUE}$(transform_pwd ${CUR_DIR})"
}

bashd_prompt_register __prompt_current_directory
