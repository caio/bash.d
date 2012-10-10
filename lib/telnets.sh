telnets() {
    local host=$1
    local port=${2-443}
    openssl s_client -quiet -connect $host:$port
}
