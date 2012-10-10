#!/bin/bash

__load_venvwrapper() {
    local venvbase="${BASHD_DIR}/lib/virtualenvwrapper"
    test ! -d ${venvbase} && return 0
    export WORKON_HOME=${HOME}/.virtualenvs
    export PIP_VIRTUALENV_BASE=$WORKON_HOME
    mkdir -p $WORKON_HOME
    pathappend ${venvbase} PYTHONPATH
    . ${venvbase}/virtualenvwrapper.sh
}

__load_venvwrapper
