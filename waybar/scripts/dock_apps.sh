#!/bin/bash

# App list (order matters)
APPS=(
  "firefox::firefox"
  "thunar::thunar"
  "kitty::kitty"
  "code:󰨞:code"
  "spotify:󰝚:spotify"
)

clients=$(hyprctl clients -j)

output=""

for app in "${APPS[@]}"; do
    IFS=":" read -r class icon cmd <<< "$app"

    active=$(hyprctl activewindow -j | jq -r '.class')

    if [ "$class" == "$active" ]; then
    output+="<span class='dock-icon running active'>$icon</span>"
    else
    output+="<span class='dock-icon running'>$icon</span>"
    fi

done

echo "{\"text\":\"$output\"}"
