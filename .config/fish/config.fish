set -l lines (dbus-launch | string split \n)

for line in $lines
    if string match -qr '^[A-Z_]+=.*' -- $line
        set -l key (string split '=' $line)[1]
        set -l val (string split -m 1 '=' $line)[2]
        set -gx $key $val
    end
end

if test -s ~/.alias
    source ~/.alias
end
