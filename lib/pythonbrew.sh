#!/bin/bash

__load_pybrew() {
    local pybrewinit="${HOME}/.pythonbrew/etc/bashrc"
    test ! -r ${pybrewinit} && return 0
    . ${pybrewinit}
}

__load_pybrew
