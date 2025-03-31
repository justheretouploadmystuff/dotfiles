#!/usr/bin/env bash

# Colors from your theme
COLOR_ACTIVE="#fafafa"    # fg (white)
COLOR_CONNECTED="#2979ff" # blue (active connection)
COLOR_OFF="#bdbdbd"       # fg-alt (grey)

# Check if bluetooth is powered on
powered=$(bluetoothctl show | grep -c "Powered: yes")

if [[ $powered -eq 0 ]]; then
    bluetooth_power="󰂯  Enable Bluetooth"
    chosen_option=$(echo -e "$bluetooth_power" | rofi -dmenu -i -p "Bluetooth: ")
    
    if [ "$chosen_option" = "󰂯  Enable Bluetooth" ]; then
        bluetoothctl power on
        notify-send "Bluetooth" "Bluetooth has been powered on"
    fi
    exit
fi

# Get a list of paired devices
paired_devices=$(bluetoothctl paired-devices | grep Device | cut -d ' ' -f 2- | sed 's/Device //g')

# Get a list of available devices
available_devices=$(bluetoothctl devices | grep Device | cut -d ' ' -f 2- | sed 's/Device //g')

# Combine paired and available devices and remove duplicates
all_devices=$(echo -e "$paired_devices\n$available_devices" | sort | uniq)

# Create a formatted list for rofi
formatted_list=""
while read -r device; do
    if [ -n "$device" ]; then
        mac=$(echo "$device" | cut -d ' ' -f 1)
        name=$(echo "$device" | cut -d ' ' -f 2-)
        
        # Check if device is connected
        if bluetoothctl info "$mac" | grep -q "Connected: yes"; then
            formatted_list="$formatted_list\n󰂱  $name [Connected]"
        # Check if device is paired
        elif echo "$paired_devices" | grep -q "$mac"; then
            formatted_list="$formatted_list\n󰂯  $name [Paired]"
        # Otherwise it's just available
        else
            formatted_list="$formatted_list\n󰂞  $name"
        fi
    fi
done <<< "$all_devices"

# Add scan and power options to the menu
bluetooth_scan="  Scan for devices"
bluetooth_power_off="󰂲  Disable Bluetooth"

# Display menu with rofi
chosen_option=$(echo -e "$bluetooth_power_off\n$bluetooth_scan$formatted_list" | rofi -dmenu -i -p "Bluetooth: ")

# Handle the selected option
if [ "$chosen_option" = "  Scan for devices" ]; then
    notify-send "Bluetooth" "Scanning for devices..."
    bluetoothctl scan on &
    sleep 5
    pkill -f "bluetoothctl scan on"
    # Re-run the script to show updated device list
    exec "$0"

elif [ "$chosen_option" = "󰂲  Disable Bluetooth" ]; then
    bluetoothctl power off
    notify-send "Bluetooth" "Bluetooth has been powered off"

elif [ -n "$chosen_option" ]; then
    # Extract the device name from the selected option (remove the icon and status)
    device_name=$(echo "$chosen_option" | sed 's/^󰂱  //;s/^󰂯  //;s/^󰂞  //' | sed 's/ \[Connected\]//;s/ \[Paired\]//')
    
    # Get the MAC address for the selected device
    mac_address=""
    while read -r device; do
        if [ -n "$device" ]; then
            mac=$(echo "$device" | cut -d ' ' -f 1)
            name=$(echo "$device" | cut -d ' ' -f 2-)
            
            if [ "$name" = "$device_name" ]; then
                mac_address=$mac
                break
            fi
        fi
    done <<< "$all_devices"
    
    if [ -n "$mac_address" ]; then
        # Check if the device is already connected
        if bluetoothctl info "$mac_address" | grep -q "Connected: yes"; then
            # Disconnect the device
            bluetoothctl disconnect "$mac_address"
            notify-send "Bluetooth" "Disconnected from $device_name"
        else
            # Connect to the device
            notify-send "Bluetooth" "Attempting to connect to $device_name..."
            bluetoothctl connect "$mac_address"
            
            # Check if connection was successful
            sleep 2
            if bluetoothctl info "$mac_address" | grep -q "Connected: yes"; then
                notify-send "Bluetooth" "Successfully connected to $device_name"
            else
                notify-send "Bluetooth" "Failed to connect to $device_name"
            fi
        fi
    fi
fi
