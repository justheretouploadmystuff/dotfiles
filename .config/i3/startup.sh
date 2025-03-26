#!/bin/bash

# Kill existing instances with proper signal handling
killall -q picom
killall -q polybar

# Wait for processes to terminate completely
while pgrep -u $UID -x picom >/dev/null || pgrep -u $UID -x polybar >/dev/null; do
    sleep 0.1
done

# Start picom with proper configuration and wait for initialization
picom --config ~/.config/picom/picom.conf -b &

# Ensure picom is fully initialized before starting polybar
sleep 1.5

# Start polybar with transparency support
polybar main --config=$HOME/.config/polybar/config.ini &

# Set process niceness for better system responsiveness
renice -n 10 $(pgrep picom) >/dev/null 2>&1
