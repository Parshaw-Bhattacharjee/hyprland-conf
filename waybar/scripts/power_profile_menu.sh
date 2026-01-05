#!/bin/bash
# Power Profile/CPU Governor Menu

SELECTION=$(printf "\
⚡ Performance\n\
⚙ Balanced\n\
🔋 Power Save\n\
🌙 Turbo Boost" | fuzzel --dmenu -p "Power Profile:" || rofi -dmenu -p "Power Profile:")

case "$SELECTION" in
  *"Performance"*)
    echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
    notify-send "Power Profile" "Set to Performance"
    ;;
  *"Balanced"*)
    echo schedutil | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
    notify-send "Power Profile" "Set to Balanced (Schedutil)"
    ;;
  *"Power Save"*)
    echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor > /dev/null
    notify-send "Power Profile" "Set to Power Save"
    ;;
  *"Turbo"*)
    # Enable turbo boost
    echo 0 | sudo tee /sys/devices/system/cpu/intel_pstate/no_turbo > /dev/null 2>&1 || \
    echo 1 | sudo tee /sys/devices/system/cpu/cpufreq/boost > /dev/null 2>&1
    notify-send "Turbo Boost" "Enabled"
    ;;
esac
