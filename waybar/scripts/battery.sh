#!/bin/bash
if ls /sys/class/power_supply/BAT* &>/dev/null; then
  ln -sf ~/.config/waybar/style-laptop.css ~/.config/waybar/style.css
else
  ln -sf ~/.config/waybar/style-desktop.css ~/.config/waybar/style.css
fi
pkill -SIGUSR2 waybar
