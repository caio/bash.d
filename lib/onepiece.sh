#!/bin/bash

__wm_check() {
    if [ ! -d WATCHED ]; then
        echo "You must create a ./WATCHED dir to use this command" >&2
        return 2
    fi
    return 0
}

wm() {
    video="${@}"
    mplayer -ass -embeddedfonts "${video}"
    result=$?
    if test $result -eq 0; then
        mv "${video}" WATCHED/
        subfile="${video%.*}.srt"
        test -f "${subfile}" && mv "${subfile}" WATCHED
        return 0;
    fi
}

wnext() {
    __wm_check || return $?
    local target=""
    while read LINE; do
        test -d "${LINE}" && continue
        test ! -f "${LINE}" && continue
        target=${LINE}
        break
    done < <(/bin/ls -1 !(*.srt|WATCHED))
    test -z "${target}" && return 1
    wm "${target}"
}

wprev() {
    __wm_check || return $?
    local target=""
    while read LINE; do
        test -d "${LINE}" && continue
        test ! -f "${LINE}" && continue
        target=${LINE}
        break
    done < <(ls -1 WATCHED| egrep -v '.+\.srt'| tac| sed 's/^/WATCHED\//g')
    test -z "${target}" && return 1
    mplayer "${target}"
}
