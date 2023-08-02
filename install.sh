#!/bin/bash

# setting wallpaper
if [ ! -d "$HOME/Pictures/wallpapers" ]; then
    mkdir $HOME/Pictures/wallpapers
    mv /wallpapers/tpn2.jpg $HOME/Pictures/wallpapers
    echo "Folder 'wallpapers' has been created"
else
    mv /wallpapers/tpn2.jpg $HOME/Pictures/wallpapers
    echo "wallpapers folder already exists."
fi

### KITTY TERMINAL ###

# installing sway
sudo dnf install sway

# Install and setting kitty as terminal
sudo dnf install kitty
echo 'export TERMINAL="kitty"' >> ~/.bashrc

### OH-MY-POSH ###

# Installing Homebrew (to install Oh-My-Posh)
sudo dnf groupinstall "Development Tools"

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> ~/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Intalling oh-my-posh
brew install jandedobbeleer/oh-my-posh/oh-my-posh

# init oh-my-posh in bash
echo 'eval "$(oh-my-posh init bash)"' >> ~/.bashrc
echo 'eval "$(oh-my-posh init bash --config /home/darkdogg/.config/oh-my-posh/theme2.json)"' >> ~/.bashrc

### ROFI ###
sudo dnf install rofi

### MOVING CONFIGS TO .CONFIG ###

folders=("kitty" "oh-my-posh" "rofi" "sway")

for i in "${folders[@]}"; do
    cp -r "$i" ~/.config
done

### RELOADING ###

# reloading sway
swaymsg reload