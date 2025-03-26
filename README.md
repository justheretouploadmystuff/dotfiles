
# i3 Nord Theme Installation Guide for Linux Mint [WIP TUTORIAL]

![Nord Theme RICE](preview.png)

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
    qt5tc \
    lxappearance \
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

## OH MY ZSH (Required)
Needed for some plugins to work.
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Configuration Steps
1. Clone your dotfiles repository or manually copy the configuration files to:
   ```
   ~/.config/
   ```
1.2. Copy the others to ~ (.themes,.icons,.fonts and manually edit these using lxappearance and qt5tc to get nord theme gtk+qt5)
1.3. Run installfonts.sh(make sure to chmod +x first)
2. Make scripts executable:
   ```bash
   chmod +x ~/.config/i3/scripts/*.sh
   chmod +x ~/.config/polybar/scripts/*.sh
   ```

3. Install Spicetify (optional, for Spotify theming, i recommend also getting the marketplace):
   ```bash
   curl -sS https://raw.githubusercontent.com/spicetify/spicetify-cli/master/install.sh | sh
   ```

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

