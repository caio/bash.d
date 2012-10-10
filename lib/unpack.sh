#!/bin/bash

unpack() {
    # Usage: unpack [-r] <package> [extra_options]
    # extra_options are filetype/extration-command -dependant
    local remove_archive=0

    if [ "$1" = "-r" ]; then
        remove_archive=1
        shift
    fi

    filename="$1"
    shift

    if [ ! -f "$filename" ]; then
        echo "File not found: $filename" 1>&2
        return 1
    fi

    options=${@}

    case "$filename" in
        *.tar.bz2)
            tar xvjf "$filename" $options;;
        *.tar.gz)
            tar xvzf "$filename" $options;;
        *.tar.xz)
            tar xvJf "$filename" $options;;
        *.tar.lzma)
            tar --lzma -xvf "$filename" $options;;
        *.bz2)
            bunzip $options "$filename";;
        *.rar)
            unrar x $options "$filename";;
        *.gz)
            gunzip $options "$filename";;
        *.tar)
            tar xvf "$filename" $options;;
        *.tbz2)
            tar xvjf "$filename" $options;;
        *.tgz)
            tar xvzf "$filename" $options;;
        *.zip)
            unzip "$filename" $options;;
        *.Z)
            uncompress $options "$filename";;
        *.7z)
            7z x $options "$filename";;
        *.rpm)
            rpm2cpio "$filename" | cpio -ivd $options;;
        *.deb)
            ar vx "$filename";;
        *)
            echo "Unknown filetype: $filename" 1>&2
            return 1;;
    esac

    local retcode=$?

    if [ $retcode -ne 0 ]; then
        echo "Error extracting: $filename" 1>&2
        return $retcode
    fi

    if [ $remove_archive -eq 1 ]; then
        echo "Removing: $filename"
        rm "$filename"
    fi
}
