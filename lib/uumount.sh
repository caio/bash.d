#!/bin/bash

__umountables() {
    local cur
    local IFS=$'\n'
    wrkdir='/media/'
    cur=${COMP_WORDS[COMP_CWORD]};
    len=$((${#wrkdir} + 1));

    if [ $COMP_CWORD -eq 1 ]; then
        COMPREPLY=( $(compgen -d /media/${cur}| cut -b $len-) )
    else
        COMPREPLY=()
    fi
}

uumount() {
    [ ${#} -ne 1 ] && return 1;
    udiskie-umount /media/${1}
}

complete -F __umountables uumount

