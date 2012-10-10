#!/bin/bash

_dbus_send() {
    local cmd=${1}
    local tmp=${1%.*}
    local dest=${tmp/.Manager/}
    local mgr="/${tmp//.//}"
    dbus-send --system --print-reply --dest=${dest} ${mgr} ${cmd}
}

power() {
    case "$1" in
        shutdown)
            _dbus_send org.freedesktop.ConsoleKit.Manager.Stop
            ;;
        restart)
            _dbus_send org.freedesktop.ConsoleKit.Manager.Restart
            ;;
        sleep)
            _dbus_send org.freedesktop.UPower.Suspend
            ;;
        hibernate)
            _dbus_send org.freedesktop.UPower.Hibernate
            ;;
        *)
            return 1
    esac
}

complete -W "shutdown${IFS}restart${IFS}sleep${IFS}hibernate" power
