#!/bin/bash

while true; do
	cmd="󰜟 $(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')"
	if [ "$(pactl get-sink-mute @DEFAULT_SINK@)" = "Mute: yes" ]; then
		cmd="󰓄 muted"
	fi
	cmd2=" $(acpi -b | awk '{print $4}')"

	if test "$(acpi -b | awk '{print $4}' | sed 's/%//g')" -le 75; then
		cmd2=" $(acpi -b | awk '{print $4}')"		
	fi

	if test "$(acpi -b | awk '{print $4}' | sed 's/%//g')" -le 50; then
		cmd2=" $(acpi -b | awk '{print $4}')"		
	fi

	if test "$(acpi -b | awk '{print $4}' | sed 's/%//g')" -le 25; then
		cmd2=" $(acpi -b | awk '{print $4}')"		
	fi

	if test "$(acpi -b | awk '{print $4}' | sed 's/%//g')" -le 10; then
		cmd2=" $(acpi -b | awk '{print $4}')"		
	fi
	
	echo "$cmd   $(date +'%a %b %d %H:%M')  $cmd2  "
	sleep 0.1
done
