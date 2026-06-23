#!/bin/bash

while true; do
	cmd="󰜟 $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')"
	if [ "$(pactl get-sink-mute @DEFAULT_SINK@)" = "Mute: yes" ]; then
		cmd="󰓄 muted"
	fi
	echo "$cmd | $(date +'%a %b %d %H:%M') | BAT: $(acpi -b | awk '{print $4}')"
	sleep 0.1
done
