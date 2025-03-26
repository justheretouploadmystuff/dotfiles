#!/bin/bash

# Power menu using rofi
chosen=$(echo -e "Sleep\nRestart\nPower Off\nLogout\nCancel" | rofi -dmenu -i -p "Power Menu" \
    -theme-str 'window {width: 250px;}' \
    -theme-str 'textbox-prompt-colon {str: "⏼";}' \
    -theme-str 'element {background-color: #232323; text-color: #fafafa;}' \
    -theme-str 'element selected {background-color: #ff1744; text-color: #fafafa;}')

case "$chosen" in
    "Sleep")
        systemctl suspend
        ;;
    "Restart")
        systemctl reboot
        ;;
    "Power Off")
        systemctl poweroff
        ;;
    "Logout")
        # Determine the desktop environment and use appropriate logout command
        if [ "$XDG_CURRENT_DESKTOP" = "X-Cinnamon" ]; then
            # For Linux Mint's Cinnamon
            cinnamon-session-quit --logout
        elif [ -n "$DESKTOP_SESSION" ]; then
            # Fallback for other desktop environments
            loginctl terminate-session $XDG_SESSION_ID
        else
            # Generic X11 logout
            pkill -KILL -u $USER
        fi
        ;;
    "Cancel")
        exit 0
        ;;
esac
