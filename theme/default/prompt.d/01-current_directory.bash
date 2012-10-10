__prompt_current_directory() {
    transform_pwd() {
        curdir="$@"
        curdir=${curdir/#~\/src\//:}
        curdir=${curdir/#:personal\//${col_txtcyn}➤${col_txtblu}}
        curdir=${curdir/#:work\//${col_txtred}⚒${col_txtblu}}

        curdir=${curdir/#~\/etc\//${col_txtpur}ж${col_txtblu}}
        echo $curdir
    }

    local CUR_DIR=${PWD/$HOME/\~}
    bashd_prompt_append "${FG_BLUE}$(transform_pwd ${CUR_DIR})"
}

bashd_prompt_register __prompt_current_directory
