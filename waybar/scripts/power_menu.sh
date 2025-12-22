#!/bin/bash

choice=$(printf " Lock\n Logout\n⏾ Suspend\n Reboot\n⏻ Shutdown" | rofi -dmenu -i -markup-rows -p "Power" -theme ~/.config/rofi/power.rasi)

choice=$(echo "$choice" | awk '{print $NF}')

case "$choice" in
  Lock) hyprlock ;;
  Logout) hyprctl dispatch exit ;;
  Suspend) systemctl suspend ;;
  Reboot) systemctl reboot ;;
  Shutdown) systemctl poweroff ;;
esac
