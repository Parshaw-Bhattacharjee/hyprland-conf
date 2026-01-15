#!/bin/bash

# Debug logging
echo "battery-alert started at $(date)" >> /tmp/battery-alert.log
echo "DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS" >> /tmp/battery-alert.log
echo "DISPLAY=$DISPLAY" >> /tmp/battery-alert.log
echo "USER=$USER UID=$(id -u)" >> /tmp/battery-alert.log

# Get the actual user running this (in case it's run with sudo)
ACTUAL_USER=$(logname 2>/dev/null || echo $SUDO_USER || whoami)
ACTUAL_UID=$(id -u $ACTUAL_USER)

# Set environment variables with correct user ID
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$ACTUAL_UID/bus"
export XDG_RUNTIME_DIR="/run/user/$ACTUAL_UID"
export DISPLAY=:1

# Check battery status and capacity
STATUS=$(acpi -b | awk -F'[,:%]' '{print $2}')
CAPACITY=$(acpi -b | awk -F'[,:%]' '{print $3}')

echo "DEBUG: STATUS='$STATUS' CAPACITY='$CAPACITY'" >> /tmp/battery-alert.log
    
# Alert if battery is charging or discharging below thresold values
if [ "$STATUS" = "Charging" ] && [ "$CAPACITY" -ge 70 ]; then
    notify-send -u normal "Battery Charged\!" "Remove Charger\!"
fi

if [ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -le 15 ]; then
    notify-send -u critical "Battery Discharged\!" "Battery at $CAPACITY%! Suspending Soon...\!"

elif [ "$STATUS" = "Discharging" ] && [ "$CAPACITY" -le 30 ]; then
    notify-send -u low "Battery Low\!" "Battery at $CAPACITY%! Connect Charger\!"
fi

echo "battery-alert finished at $(date)" >> /tmp/battery-alert.log
