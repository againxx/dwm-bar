#!/bin/sh

# A modular status bar for dwm
# Joe Standring <git@joestandring.com>
# GNU GPLv3

# Dependencies: xorg-xsetroot

# Import functions with "$include /route/to/module"
# It is recommended that you place functions in the subdirectory ./bar-functions and use: . "$DIR/bar-functions/dwm_example.sh"

# Store the directory the script is running from
LOC=$(readlink -f "$0")
DIR=$(dirname "$LOC")

# Change the charachter(s) used to seperate modules. If two are used, they will be placed at the start and end.
export SEP1=""
export SEP2=" │ "

# Import the modules
# . "$DIR/bar-functions/dwm_countdown.sh"
# . "$DIR/bar-functions/dwm_alarm.sh"
# . "$DIR/bar-functions/dwm_transmission.sh"
# . "$DIR/bar-functions/dwm_cmus.sh"
# . "$DIR/bar-functions/dwm_mpc.sh"
# . "$DIR/bar-functions/dwm_spotify.sh"
. "$DIR/bar-functions/dwm_resources.sh"
# . "$DIR/bar-functions/dwm_battery.sh"
# . "$DIR/bar-functions/dwm_mail.sh"
# . "$DIR/bar-functions/dwm_backlight.sh"
# . "$DIR/bar-functions/dwm_alsa.sh"
. "$DIR/bar-functions/dwm_pulse.sh"
. "$DIR/bar-functions/dwm_weather.sh"
# . "$DIR/bar-functions/dwm_vpn.sh"
# . "$DIR/bar-functions/dwm_networkmanager.sh"
. "$DIR/bar-functions/dwm_network_traffic.sh"
# . "$DIR/bar-functions/dwm_keyboard.sh"
# . "$DIR/bar-functions/dwm_ccurse.sh"
. "$DIR/bar-functions/dwm_date.sh"
# . "$DIR/bar-functions/dwm_connman.sh"
. "$DIR/bar-functions/dwm_loadavg.sh"
# . "$DIR/bar-functions/dwm_currency.sh"

parallelize() {
    while true; do
        printf "Running parallel processes\n"
        dwm_update_weather
        sleep 5m
    done
}
parallelize &

# Update dwm status bar every second
while true; do
    # Append results of each func one by one to the result_bar string
    result_bar=""
    result_bar=$result_bar$(dwm_resources "$1")
    result_bar=$result_bar$(dwm_network_traffic "$1")
    result_bar="$result_bar$(dwm_pulse)"
    result_bar="$result_bar$(dwm_weather)"
    result_bar="$result_bar$(dwm_loadavg)"
    result_bar="$result_bar$(dwm_date)"
    xsetroot -name "$result_bar"
    sleep 1
done
