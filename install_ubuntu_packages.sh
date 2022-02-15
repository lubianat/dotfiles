#!/usr/bin/env bash 

sudo 

# Install Slack
sudo snap install slack --classic

# Install telegram 
sudo apt install telegram-desktop -y

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install venv
apt install python3-venv -y

# Reinstall audio
sudo apt-get install --reinstall alsa-base pulseaudio -y
sudo alsa force-reload 

# Remove annoying beep sounds
sudo sed -i 's/# set bell-style none/set bell-style none/g' /etc/inputrc

# Install node and yarn
sudo apt install nodejs yarn -y

# Install inkscape
sudo apt install inkscape -y
