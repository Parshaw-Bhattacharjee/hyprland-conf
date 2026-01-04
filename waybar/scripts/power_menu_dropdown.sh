#!/bin/bash
# Power Menu with Dropdown Options
# Uses fuzzel or rofi for selection

SELECTION=$(printf "\
󰒳 Lock\n\
󰤄 Sleep\n\
󰐦 Suspend\n\
󰑙 Reboot\n\
󰐥 Shutdown\n\
󰍃 Logout" | rofi -dmenu -i -a top-right -l 5 -p "Power:")

CONFIRM() {
  local ACTION="$1"
  ANSWER=$(printf "No\nYes" | fuzzel --dmenu -p "Confirm $ACTION?" || rofi -dmenu -p "Confirm $ACTION?")
  [[ "$ANSWER" == *"Yes"* ]]
}

case "$SELECTION" in
  *"Lock"*)
    hyprlock
    ;;
  *"Sleep"*)
    CONFIRM "Sleep" && systemctl sleep
    ;;
  *"Suspend"*)
    CONFIRM "Suspend" && systemctl suspend
    ;;
  *"Reboot"*)
    CONFIRM "Reboot" && systemctl reboot
    ;;
  *"Shutdown"*)
    CONFIRM "Shutdown" && systemctl poweroff
    ;;
  *"Logout"*)
    CONFIRM "Logout" && hyprctl dispatch exit
    ;;
esac
