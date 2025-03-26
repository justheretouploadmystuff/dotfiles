
# i3 Nord Theme Installation Guide for Linux Mint

## Prerequisites
Before installation, please back up your data.

## Required Packages
Run the following command to install essential packages:

```bash
sudo apt update && sudo apt install -y \
    i3 \
    picom \
    polybar \
    rofi \
    dunst \
    kitty \
    feh \
    scrot \
    pavucontrol \
    blueman \
    network-manager \
    pulseaudio \
    pulseaudio-module-bluetooth \
    fonts-jetbrains-mono \
    fonts-nerd-fonts-symbols
```

## Optional but Recommended Packages
```bash
sudo apt install -y \
    zsh \
    neovim \
    eza \
    lazygit \
    gdb
```

## Font Installation
Ensure you have Nerd Fonts installed. Specifically:
- 0xProto Nerd Font
- JetBrains Mono Nerd Font

## Configuration Steps
1. Clone your dotfiles repository or manually copy the configuration files to:
   ```
   ~/.config/
   ```

2. Make scripts executable:
   ```bash
   chmod +x ~/.config/i3/scripts/*.sh
   chmod +x ~/.config/polybar/scripts/*.sh
   ```

3. Install Spicetify (optional, for Spotify theming, i recommend also getting the marketplace):
   ```bash
   curl -sS https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
   ```

## Recommended Additional Tools
- Bluetooth: `blueman-manager`
- Audio Control: `pavucontrol`
- Network Management: `nm-connection-editor`

## Post-Installation
1. Restart your system or log out and log back in.
2. Use `Super + Shift + r` to restart i3 window manager.
3. Use Super+/ for the cheatsheet

## Customization Notes
- Modify `~/.config/rofi/config.rasi` for Rofi appearance
- Adjust Polybar modules in `~/.config/polybar/modules.ini`
- Customize Kitty terminal in `~/.config/kitty/kitty.conf`

## Troubleshooting
- If transparency or compositor issues occur, check `~/.config/picom/picom.conf`
- For audio/bluetooth problems, ensure PulseAudio and Bluetooth services are running

## Recommended Terminal Setup
Consider installing Oh My Zsh for enhanced Zsh configuration:
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
