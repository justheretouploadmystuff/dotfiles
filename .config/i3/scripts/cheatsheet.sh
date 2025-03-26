#!/bin/bash

# Cheatsheet script for i3 key bindings
CHEATSHEET_FILE="/tmp/i3_cheatsheet.txt"

# Create the cheatsheet content
cat > "$CHEATSHEET_FILE" << EOL
===== i3 KEY BINDINGS CHEATSHEET =====

TERMINAL & WINDOW MANAGEMENT:
Mod+Return   - Open Kitty terminal
Mod+k        - Close window
Mod+space    - Rofi application launcher
Mod+Shift+b  - Take screenshot

NAVIGATION:
Mod+Arrow Keys - Move focus
Mod+Shift+Arrow Keys - Move window
Mod+x        - Next workspace
Mod+z        - Previous workspace

WORKSPACE CONTROLS:
Mod+[1-0]    - Switch to workspace 1-10
Mod+Shift+[1-0] - Move window to workspace

LAYOUT CONTROLS:
Mod+h        - Split horizontal
Mod+v        - Split vertical
Mod+f        - Fullscreen
Mod+Shift+space - Toggle floating
Mod+w        - Tabbed layout
Mod+q        - Toggle split layout

SYSTEM CONTROLS:
Mod+l        - Lock screen
Mod+Shift+c  - Reload i3
Mod+Shift+r  - Restart i3
Mod+Shift+e  - Exit i3

RESIZE MODE:
Mod+r        - Enter resize mode
In resize mode:
  Arrow Keys  - Resize window
  Enter/Esc   - Exit resize mode

AUDIO CONTROLS:
F1           - Mute/Unmute
F2           - Volume Down
F3           - Volume Up

BRIGHTNESS:
F6           - Decrease Brightness
F7           - Increase Brightness

Press any key to close this cheatsheet.
EOL

# Display the cheatsheet using rofi or zenity
if command -v rofi &> /dev/null; then
    cat "$CHEATSHEET_FILE" | rofi -dmenu -p "i3 Cheatsheet"
elif command -v zenity &> /dev/null; then
    zenity --text-info --title="i3 Cheatsheet" --filename="$CHEATSHEET_FILE"
else
    # Fallback to less if no graphical tool is available
    less "$CHEATSHEET_FILE"
fi
