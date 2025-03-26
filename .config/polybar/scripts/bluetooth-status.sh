#!/bin/bash

# Get Bluetooth status
powered=$(bluetoothctl show | grep -c "Powered: yes")
connected=$(bluetoothctl devices | grep -c "Connected: yes")

# Use colors from your colors.ini
COLOR_ACTIVE="#fafafa"    # fg (white)
COLOR_CONNECTED="#2979ff" # blue (active connection)
COLOR_OFF="#bdbdbd"       # fg-alt (grey)

if [ $powered -eq 1 ]; then
    if [ $connected -gt 0 ]; then
        # Connected and active (blue)
        echo "%{F$COLOR_CONNECTED}%{T7}on%{T-}%{F-}"
    else
        # Powered on but not connected (white)
        echo "%{F$COLOR_ACTIVE}%{T7}on%{T-}%{F-}"
    fi
else
    # Powered off (grey)
    echo "%{F$COLOR_OFF}%{T7}off%{T-}%{F-}"
fi
