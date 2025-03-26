#!/bin/bash
# Intelligent Power Management Script

# Logging function
log_message() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" >> /tmp/battery_management.log
}

# Safe brightness setting function
set_brightness() {
    # Try multiple methods
    brightnessctl set "$1" 2>/dev/null || \
    xbacklight -set "$(echo "$1" | sed 's/%//')" 2>/dev/null || \
    echo "Could not set brightness to $1"
}

# Function to set CPU governor safely
set_cpu_governor() {
    local governor="$1"
    for CPU in /sys/devices/system/cpu/cpu[0-9]*; do
        sudo bash -c "echo $governor > $CPU/cpufreq/scaling_governor" 2>/dev/null
    done
}

# Function to enable conservative power-saving mode
power_save() {
    # TLP power-saving
    sudo tlp bat
    
    # Set CPU governor to powersave
    set_cpu_governor powersave
    
    # Reduce screen brightness
    set_brightness 30%
    
    # Notify user
    notify-send "Power Saving Mode" "Conservative power optimization enabled" -u normal
    
    log_message "Power saving mode activated"
}

# Function to enable balanced performance mode
balanced_mode() {
    # Balanced TLP profile
    sudo tlp auto
    
    # Set CPU governor to ondemand
    set_cpu_governor ondemand
    
    # Restore moderate screen brightness
    set_brightness 50%
    
    # Notify user
    notify-send "Balanced Mode" "Moderate performance settings applied" -u normal
    
    log_message "Balanced mode activated"
}

# Main script logic
case "$1" in
    powersave)
        power_save
        ;;
    balanced)
        balanced_mode
        ;;
    *)
        # Default: Check battery status
        BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
        BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)

        if [[ "$BATTERY_STATUS" == "Discharging" ]]; then
            if [[ $BATTERY_LEVEL -le 20 ]]; then
                power_save
            elif [[ $BATTERY_LEVEL -le 40 ]]; then
                balanced_mode
            else
                # Normal performance when battery is good
                balanced_mode
            fi
        else
            # When charging, use balanced mode
            balanced_mode
        fi
        ;;
esac
