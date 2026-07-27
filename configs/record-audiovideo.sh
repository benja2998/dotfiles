#!/bin/bash

tmux new-window
tmux send-keys 'cd ~/Videos/recording/; ffmpeg -f fbdev -framerate 30 -i /dev/fb0 $(date "+%Y-%m-%d-%H-%M").mp4' Enter
tmux split-window -h
tmux send-keys 'cd ~/Videos/recording/; pw-record $(date "+%Y-%m-%d-%H-%M").wav' Enter
