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

export EDITOR=vim
export BROWSER=chromium
export PYTHONSTARTUP="${HOME}/.pythonrc.py"

pathprepend ~/bin
pathprepend ~/.bin
pathprepend ~/.local/bin

shopt -s checkjobs
shopt -s checkwinsize
shopt -s extglob
shopt -s no_empty_cmd_completion

alias mv='mv -i'
alias cp='cp -i'
alias rm='rm -I'
alias j='jobs'
alias grep='egrep'
alias ls='ls --color -h --group-directories-first'
alias l='ls -lh'
alias la='ls -lhA'
alias a='ls -d .*'
alias -- -='cd -'
alias beep="echo -ne '\a'"
alias p='ps -eo pid,ruser,cmd| grep -i'

# Save multiline commands as single-line
shopt -s cmdhist
# Append to history instead of overwriting
shopt -s histappend

export HISTSIZE=40000
export HISTFILESIZE=40000
export HISTIGNORE="ls:l:clear:d:cd:bg:fg:history"
export HISTCONTROL="erasedups:ignorespace"
export HISTTIMEFORMAT='[%Y-%m-%d %H:%M]  '
# }}}

# avoid carrying over test statuses
true
