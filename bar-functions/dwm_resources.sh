#!/bin/sh

# A dwm_bar function to display information regarding system memory, CPU temperature, and storage
# Joe Standring <git@joestandring.com>
# GNU GPLv3

df_check_location='/'

dwm_resources () {
	# get all the infos first to avoid high resources usage
	free_output=$(free --giga -h | grep Mem)
	df_output=$(df -h $df_check_location | tail -n 1)
	# Used and total memory
	MEMUSED=$(echo $free_output | awk '{print $3}')
	MEMTOT=$(echo $free_output | awk '{print $2}')
	# CPU temperature
	CPU=$(top -bn1 | grep Cpu | awk '{print $2}')%
	#CPU=$(sysctl -n hw.sensors.cpu0.temp0 | cut -d. -f1)

	printf "%s" "$SEP1"
    printf " %s/%s ﬙ %s" "$MEMUSED" "$MEMTOT" "$CPU"
    if [ "$1" = "--disk" ]; then
        # Used and total storage in / (rounded to 1024B)
        STOUSED=$(echo $df_output | awk '{print $3}')
        STOTOT=$(echo $df_output | awk '{print $2}')
        STOPER=$(echo $df_output | awk '{print $5}')
        printf "  %s/%s: %s" "$STOUSED" "$STOTOT" "$STOPER"
    fi
	printf "%s\n" "$SEP2"
}

dwm_resources --disk
