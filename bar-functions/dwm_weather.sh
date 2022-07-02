#!/bin/bash

# A dwm_bar function to print the weather from wttr.in
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: curl

dwm_update_weather() {
    local cache=/dev/shm/weather_log
    LOCATION=Hefei
    declare -A weather_symbol
    weather_symbol[sunny]=" "
    weather_symbol[clear]="望"
    weather_symbol[partly cloudy]=" "
    weather_symbol[cloudy]=" "
    weather_symbol[mist]=" "
    weather_symbol[rain shower]=" "
    weather_symbol[light rain]=" "
    weather_symbol[overcast]=" "
    weather_symbol[thunderstorm]=" "
    weather_symbol[haze]=" "

    local weather weather_data
    weather_data=$(curl -s "wttr.in/$LOCATION?format=%C,+%t&nonce=$RANDOM")
    shopt -s nocasematch
    for weather in "${!weather_symbol[@]}"; do
        weather_data="${weather_data/*${weather},/${weather_symbol[$weather]}}"
    done
    shopt -u nocasematch
    echo "${weather_data}" > $cache
}

# Change the value of LOCATION to match your city
dwm_weather() {
    cache=/dev/shm/weather_log
    [ -f $cache ] && read -r weather_data < $cache || weather_data=''
    if [ -z "$weather_data" ]; then
        dwm_update_weather
        read -r weather_data < $cache
    fi
    printf "%s%s%s" "${SEP1}" "${weather_data}" "${SEP2}"
}

dwm_update_weather
