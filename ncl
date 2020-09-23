#!/usr/bin/env bash
#read -r lower_port upper_port < /proc/sys/net/ipv4/ip_local_port_range
#while :; do
#    for (( port = lower_port ; port <= upper_port ; port++ )); do
#        nc -l "$port" 2>/dev/null && break 2
#    done
#done

function __available_port(){
    LOWER_PORT=32768
    UPPER_PORT=60999

    while true; do
        PORT="$((LOWER_PORT + (RANDOM % UPPER_PORT)))"

        nc -z localhost "${PORT}"
        if [[ $? != 0 ]]; then
            echo ${PORT}
            return 0
        fi
    done
}

__available_port
