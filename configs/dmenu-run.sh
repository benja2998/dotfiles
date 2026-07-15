#!/bin/bash

if [ "${XDG_SESSION_TYPE}" = "wayland" ] || [ -n "${WAYLAND_DISPLAY}" ]; then
    wmenu-run -i -l 10 -f "Terminess Nerd Font 16" -N "#141618" -n "#fcfcfc" -S "#ff0000" -s "#141618"
else
    dmenu_run -i -l 10 -fn "Terminess Nerd Font 16" -nb "#141618" -nf "#fcfcfc" -sb "#ff0000" -sf "#141618"
fi
