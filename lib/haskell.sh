__load_cabal() {
    local cabal_dir="${HOME}/.cabal"
    test ! -d ${cabal_dir} && return 0
    pathprepend ${cabal_dir}/bin/
    export MANPATH=${cabal_dir}/share/man/:$(manpath -g)
}

__load_cabal
