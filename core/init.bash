# Basic functions and settings

_bashd_error() {
    echo "[ERROR] $*" >&2
}

pathremove() {
    local IFS=':'
    local NEWPATH
    local DIR
    local PATHVARIABLE=${2:-PATH}
    for DIR in ${!PATHVARIABLE} ; do
        if [ "$DIR" != "$1" ] ; then
            NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
        fi
    done
    export $PATHVARIABLE="$NEWPATH"
}

_unckecked_pathappend() {
    pathremove "$1" "$2"
    local PATHVARIABLE=${2:-PATH}
    export $PATHVARIABLE="${!PATHVARIABLE:+${!PATHVARIABLE}:}$1"
}

pathprepend() {
    test ! -d "${1}" && return 0
    pathremove "$1" "$2"
    local PATHVARIABLE=${2:-PATH}
    export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
}

pathappend() {
    test ! -d "${1}" && return 0
    _unckecked_pathappend "$1" "$2"
}

pwdappend() {
    pathappend "$(pwd)"
}

bashd_source() {
    local must_be_executable=1

    if [ "$1" = "-f" ]; then
        must_be_executable=0
        shift
    fi

    for file in ${@}; do
        test ! -f ${file} -o \( $must_be_executable = 1 -a ! -x ${file} \) && continue
        . ${file} || _bashd_error "Unable to load ${file}"
    done
}
