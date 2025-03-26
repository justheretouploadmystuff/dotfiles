#!/bin/bash

# Log file for debugging
LOG_FILE="/tmp/screen-lock.log"
echo "$(date): Screen lock script started" > "$LOG_FILE"

# Ensure critical environment variables are set
export DISPLAY=${DISPLAY:-:0}
export XAUTHORITY=${XAUTHORITY:-$HOME/.Xauthority}
export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"

# Log environment for debugging
echo "$(date): DISPLAY=$DISPLAY, XAUTHORITY=$XAUTHORITY" >> "$LOG_FILE"
echo "$(date): USER=$USER, HOME=$HOME" >> "$LOG_FILE"

# Take screenshot with explicit display parameter
if ! scrot -D $DISPLAY /tmp/screenshot.png; then
    echo "$(date): Failed to take screenshot" >> "$LOG_FILE"
    # Create a fallback black image
    convert -size 1920x1080 xc:black /tmp/screenshot.png
fi

# Blur the screenshot with error handling
if ! convert /tmp/screenshot.png -blur 0x8 /tmp/screenshotblur.png; then
    echo "$(date): Failed to blur screenshot" >> "$LOG_FILE"
    # Use original screenshot as fallback
    cp /tmp/screenshot.png /tmp/screenshotblur.png
fi

# Create lock screen with time overlay
if ! convert /tmp/screenshotblur.png \
        -gravity center \
        -pointsize 80 \
        -fill white \
        -annotate +0+0 "$(date +%H:%M)" \
        /tmp/lockscreen.png; then
    echo "$(date): Failed to add time overlay" >> "$LOG_FILE"
    # Use blurred screenshot as fallback
    cp /tmp/screenshotblur.png /tmp/lockscreen.png
fi

# Check if picom is running and store its state
if pgrep -x "picom" > /dev/null; then
    echo 1 > /tmp/picom_was_running
    echo "$(date): Stopping picom temporarily" >> "$LOG_FILE"
    killall -q picom
    sleep 0.5
else
    echo 0 > /tmp/picom_was_running
fi

# Lock screen with i3lock
echo "$(date): Launching i3lock" >> "$LOG_FILE"
i3lock -n -i /tmp/lockscreen.png

# After unlocking, restart services if needed
if [ "$(cat /tmp/picom_was_running)" -eq 1 ]; then
    echo "$(date): Restarting picom" >> "$LOG_FILE"
    picom --config ~/.config/picom/picom.conf -b
    sleep 1
fi

# Restart polybar to ensure proper transparency
echo "$(date): Restarting polybar" >> "$LOG_FILE"
killall -q polybar
sleep 0.5
polybar main --config=$HOME/.config/polybar/config.ini &

# Clean up
rm -f /tmp/screenshot.png /tmp/screenshotblur.png /tmp/lockscreen.png /tmp/picom_was_running
echo "$(date): Script completed successfully" >> "$LOG_FILE"
