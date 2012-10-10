#!/bin/bash

__load_rvm() {
    local rvm_load_path="${HOME}/.rvm"
    test ! -d ${rvm_load_path} && return 0
    . ${rvm_load_path}/scripts/rvm
    . ${rvm_load_path}/scripts/completion
}

__load_rvm
