#!/bin/bash
pkill -u "${USER}" -x pipewire\|wireplumber 1>/dev/null 2>&1
/usr/bin/pipewire &
pkill -u "$(USER)" -x pipewire-media-session 1>/dev/null 2>&1
/usr/bin/pipewire -c pipewire-pulse.conf &
exec /usr/bin/wireplumber &
