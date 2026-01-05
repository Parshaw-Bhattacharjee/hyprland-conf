#!/bin/bash
# Battery Information Script

INFO=$(cat <<EOF
$(cat /sys/class/power_supply/BAT*/uevent | grep -E "CHARGE|HEALTH|STATUS|POWER" | sed 's/POWER_SUPPLY_//' | sed 's/_/ /g')
EOF
)

notify-send "Battery Information" "$INFO"
