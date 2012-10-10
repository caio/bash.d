#!/bin/bash

__load_perlbrew() {
    local perlbrew_root="${HOME}/.perl5/perlbrew"
    test ! -d ${perlbrew_root} && return 0
    export PERLBREW_ROOT=${perlbrew_root}
    . ${PERLBREW_ROOT}/etc/bashrc
    . ${PERLBREW_ROOT}/etc/perlbrew-completion.bash
}

__load_perlbrew
