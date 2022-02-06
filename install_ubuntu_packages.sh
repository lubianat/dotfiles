#!/usr/bin/env bash 

sudo 
# Install Slack
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.0.2-amd64.deb --no-clobber
sudo dpkg -i ./slack-desktop-*.deb

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install venv
apt install python3-venv -y

# Reinstall audio
sudo apt-get install --reinstall alsa-base pulseaudio -y
sudo alsa force-reload 

# Remove annoying beep sounds

 sudo sed -i 's/# set bell-style none/set bell-style none/g' /etc/inputrc