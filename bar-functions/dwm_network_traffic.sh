#!/bin/sh

# Network speed stuff stolen from http://linuxclues.blogspot.sg/2009/11/shell-script-show-network-speed.html

dwm_update_network_traffic() {
    sum=0
    for arg; do
        read -r i < "$arg"
        sum=$(( sum + i ))
    done
    cache=/dev/shm/netlog_${1##*/}
    [ -f "$cache" ] && read -r old < "$cache" || old=0
    printf "%d\n" "$sum" > "$cache"
    printf "%d\n" $(( sum - old ))
}

dwm_network_traffic() {
    if [ "$1" = "--nodisk" ]; then
        rx=$(dwm_update_network_traffic /sys/class/net/[ew]*/statistics/rx_bytes)
        tx=$(dwm_update_network_traffic /sys/class/net/[ew]*/statistics/tx_bytes)

        printf " %4sB 祝 %4sB" "$(numfmt --to=iec $rx)" "$(numfmt --to=iec $tx)"
        printf "%s\n" "$SEP2"
    fi
}
