#!/bin/bash
# Intelligent Power Management Script with Power-Profile-Daemon

# Logging function
log_message() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $*" >> /tmp/battery_management.log
}

# Function to set power profile
set_power_profile() {
    local profile="$1"
    
    # Use power-profile-daemon to set profile
    if command -v powerprofilesctl &> /dev/null; then
        powerprofilesctl set "$profile"
        log_message "Power profile set to $profile"
    else
        echo "Power-profile-daemon is not installed"
        exit 1
    fi
}

# Main script logic
case "$1" in
    powersave)
        set_power_profile power-saver
        ;;
    performance)
        set_power_profile performance
        ;;
    balanced)
        set_power_profile balanced
        ;;
    *)
        # Automatic profile selection based on battery status
        BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
        BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

        if [[ -z "$BATTERY_LEVEL" || -z "$BATTERY_STATUS" ]]; then
            echo "Unable to read battery status"
            exit 1
        fi

        if [[ "$BATTERY_STATUS" == "Discharging" ]]; then
            if [[ $BATTERY_LEVEL -le 20 ]]; then
                set_power_profile power-saver
            elif [[ $BATTERY_LEVEL -le 40 ]]; then
                set_power_profile balanced
            else
                set_power_profile balanced
            fi
        else
            # When charging, use balanced profile
            set_power_profile balanced
        fi
        ;;
esac

