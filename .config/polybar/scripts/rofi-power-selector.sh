#!/bin/bash

# Debug logging
exec > >(tee -a /tmp/power-profile-debug.log) 2>&1
set -x

# Rofi Power Profile Selector
PROFILES=(
    "Performance:performance"
    "Balanced:balanced"
    "Power Saving:power-saver"
)

# Use rofi to display profiles
CHOICE=$(printf '%s\n' "Performance" "Balanced" "Power Saving" | rofi -dmenu -p "Select Power Profile")

echo "Raw choice: $CHOICE"

if [ -n "$CHOICE" ]; then
    case "$CHOICE" in
        "Performance")
            echo "Setting to performance mode"
            powerprofilesctl set performance
            notify-send "Power Profile" "Switched to Performance mode" -u normal
            ;;
        "Balanced")
            echo "Setting to balanced mode"
            powerprofilesctl set balanced
            notify-send "Power Profile" "Switched to Balanced mode" -u normal
            ;;
        "Power Saving")
            echo "Setting to power-saver mode"
            powerprofilesctl set power-saver
            notify-send "Power Profile" "Switched to Power Saving mode" -u normal
            ;;
        *)
            echo "Unknown choice: $CHOICE"
            ;;
    esac
fi
