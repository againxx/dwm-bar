#!/bin/sh

# A dwm_bar function to show the master volume of PulseAudio
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: pamixer

dwm_pulse () {
    VOL=$(pamixer --get-volume)
    MUTE=$(pamixer --get-mute)
    
    printf "%s" "$SEP1"
    if [ "$MUTE" = "true" ] || [ "$VOL" -eq 0 ]; then
        printf "婢 %s%%" "$VOL"
    elif [ "$VOL" -gt 0 ] && [ "$VOL" -le 33 ]; then
        printf " %s%%" "$VOL"
    elif [ "$VOL" -gt 33 ] && [ "$VOL" -le 66 ]; then
        printf "墳 %s%%" "$VOL"
    else
        printf " %s%%" "$VOL"
    fi
    printf "%s\n" "$SEP2"
}

dwm_pulse
