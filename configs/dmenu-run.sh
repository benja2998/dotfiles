#!/bin/bash

if [ "${XDG_SESSION_TYPE}" = "wayland" ] || [ -n "${WAYLAND_DISPLAY}" ]; then
    wmenu-run -i -l 10 -f "Terminess Nerd Font 16" -N "#1e1e2e" -n "#cdd6f4" -S "#89b4fa" -s "#1e1e2e"
else
    dmenu_run -i -l 10 -fn "Terminess Nerd Font 16" -nb "#1e1e2e" -nf "#cdd6f4" -sb "#89b4fa" -sf "#1e1e2e"
fi
