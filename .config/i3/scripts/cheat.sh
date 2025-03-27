#!/bin/bash

# Create a temporary file for the cheatsheet
CHEATSHEET_FILE="/tmp/i3_cheatsheet.txt"

# Create the cheatsheet content with rich formatting
cat > "$CHEATSHEET_FILE" << EOL
┌─────────────────────────────────────────┐
│         i3 Keyboard Cheatsheet          │
└─────────────────────────────────────────┘

 Window & Terminal
 ─────────────────
 Mod+Return    Open Kitty terminal
 Mod+k         Close window
 Mod+space     Rofi launcher
 Mod+Shift+b   Screenshot

 Navigation
 ──────────
 Mod+Arrow Keys       Move focus
 Mod+Shift+Arrow Keys Move window
 Mod+x        Next workspace
 Mod+z        Previous workspace

 Workspace Controls
 ─────────────────
 Mod+[1-9]    Switch workspace
 Mod+Shift+[1-9] Move window to workspace

 Layout Controls
 ──────────────
 Mod+h        Split horizontal
 Mod+v        Split vertical
 Mod+f        Fullscreen
 Mod+Shift+space Toggle floating
 Mod+w        Tabbed layout
 Mod+q        Toggle split layout

 System Controls
 ──────────────
 Mod+l        Lock screen
 Mod+Shift+c  Reload i3
 Mod+Shift+r  Restart i3
 Mod+Shift+e  Exit i3

 Resize Mode
 ───────────
 Mod+r        Enter resize mode
   Arrow Keys: Resize window
   Enter/Esc: Exit resize mode

 Media Controls
 ─────────────
 F1           Mute/Unmute
 F2           Volume Down
 F3           Volume Up

 Brightness
 ──────────
 F6           Decrease Brightness
 F7           Increase Brightness

Press any key to close
EOL

# Open the cheatsheet in a terminal
kitty -e less -R "$CHEATSHEET_FILE"
