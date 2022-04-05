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

# Install gparted (to manage flashdrives)
sudo apt install gparted -y

# Install htop
sudo apt install htop -y

# Install libreoffice
sudo apt-get install libreoffice libreoffice-style-breeze -y

# Install calibre
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

# Install BB security module

TEMP_DEB="$(mktemp)" &&
wget -O "$TEMP_DEB" 'https://cloud.gastecnologia.com.br/bb/downloads/ws/warsaw_setup64.deb' &&
sudo dpkg -i "$TEMP_DEB"
rm -f "$TEMP_DEB"

# Install Protege 
# See https://protegewiki.stanford.edu/wiki/Install_Protege5_Linux
