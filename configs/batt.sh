if [ "$(acpi -b | awk '{print $4}')" = "10%" ]; then
	notify-send -u critical "CRITICAL battery low"
fi
