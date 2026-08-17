#!/bin/bash

daily="$HOME/Documents/Notes/$(date +%Y)/$(date '+%d-%m-%Y').txt"
if ! [[ -f "$daily" ]]; then
	cat << EOF > "$daily"
* $(date '+%d-%m-%Y')
EOF
fi
ed "$daily"
