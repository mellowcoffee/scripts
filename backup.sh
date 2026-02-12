#!/usr/bin/env bash
# backup.sh

red='\033[0;31m'
green='\033[0;32m'
yellow='\033[0;33m'
blue='\033[0;34m'
nc='\033[0m'

log_info() {
    printf "${blue}[INFO]${nc}  %s\n" "$1"
}

log_warn() {
    printf "${yellow}[WARN]${nc}  %s\n" "$1"
}

log_error() {
    printf "${red}[ERROR]${nc} %s\n" "$1"
}

log_success() {
    printf "${green}[OK]${nc}    %s\n" "$1"
}

command=$(basename "$0")
backup_suffix="_$(date +%Y%m%d_%H%M%S)"

backup_node() {
    local target=$1
    if [[ ! -e "$target" ]] ; then
        log_warn "${target} does not exist."
        return 0
    fi
    log_info "Backing up ${target}..."
    local dest="${target%/}${backup_suffix}"
    if cp -a "$target" "$dest" ; then
        log_success "$target has been backed up to $dest."
        return 0
    else
        log_error "Failed to back up $target."
        return 1
    fi
}

main() {
    if [[ $# -eq 0 ]] ; then
        >&2 echo "usage: $command [NODE(S)]"
        exit 1
    fi
    local exit_code=0
    for arg in "$@" ; do
        backup_node "$arg" || exit_code=1
    done
    exit "$exit_code"
}

main "$@"
