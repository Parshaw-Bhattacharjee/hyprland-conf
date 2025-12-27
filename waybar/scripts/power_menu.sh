#!/bin/bash
SELECTION="$(printf "󰌾 Lock\n󰤄 Suspend\n󰍃 Log out\n Reboot\n󰐥 Shutdown" | fuzzel --dmenu -a top-right -l 5 -p "Power:")"

confirm_action() {
    local action="$1"
    CONFIRMATION="$(printf "No\nYes" | fuzzel --dmenu -a top-right -l 2 -p "$action?")"
    [[ "$CONFIRMATION" == *"Yes"* ]]
}

case $SELECTION in
    *"Lock"*) your-locker-command ;;  # e.g., hyprlock
    *"Suspend"*) confirm_action "Suspend" && systemctl suspend ;;
    *"Log out"*) confirm_action "Logout" && hyprctl dispatch exit ;;
    *"Reboot"*) confirm_action "Reboot" && systemctl reboot ;;
    *"Shutdown"*) confirm_action "Shutdown" && systemctl poweroff ;;
esac
