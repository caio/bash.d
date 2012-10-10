__prompt_rvm() {
    if [ ! -z $RUBY_VERSION ]; then
        bashd_prompt_append " ${FG_GREEN}∼$(echo $RUBY_VERSION |sed 's/.*-\(.\+\)-.*/\1/g')"
    fi
}

bashd_prompt_register __prompt_rvm
