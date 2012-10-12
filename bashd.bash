# Do absolutely nothing if stdin is not a terminal
test ! -t 0 && return 0

# Disable ^S/^Q for flow control
stty -ixon -ixoff
# Allow binding ^W on inputrc
stty werase undef

# Resolve bash.d base dir if unset
if test -z $BASHD_DIR; then
    export BASHD_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
fi

. ${BASHD_DIR}/core/init.bash
. ${BASHD_DIR}/core/color.bash
. ${BASHD_DIR}/core/theme.bash

bashd_source ${BASHD_DIR}/lib/*
bashd_source ${BASHD_DIR}/custom/*

pathprepend ~/bin
pathprepend ~/.bin
pathprepend ~/.local/bin

shopt -s checkjobs
shopt -s checkwinsize
shopt -s extglob
shopt -s no_empty_cmd_completion

# Save multiline commands as single-line
shopt -s cmdhist
# Append to history instead of overwriting
shopt -s histappend

export HISTSIZE=40000
export HISTFILESIZE=40000
export HISTCONTROL="erasedups:ignorespace"

# avoid carrying over test statuses
true
