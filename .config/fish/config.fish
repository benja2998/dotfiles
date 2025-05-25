# Fish config for SUSE Linux

# Set environment variables
set -l lines (dbus-launch | string split \n)

for line in $lines
    if string match -qr '^[A-Z_]+=.*' -- $line
        set -l key (string split '=' $line)[1]
        set -l val (string split -m 1 '=' $line)[2]
        set -gx $key $val
    end
end

# Update XDG_DATA_DIRS
set -gx XDG_DATA_DIRS $XDG_DATA_DIRS /var/lib/flatpak/exports/share /home/opensuse_wsl/.local/share/flatpak/exports/share

# WSLg X11 socket setup
if not test -e /tmp/.X11-unix/X0
    sudo ln -sf /mnt/wslg/.X11-unix/X0 /tmp/.X11-unix/X0
end

# Load aliases if exists
if test -s ~/.alias
    source ~/.alias
end
