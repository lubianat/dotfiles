#!/usr/bin/env bash 

sudo 

# Install zsh
sudo apt install zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

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

# Configure mouse wheel copy
sudo apt-get install gnome-tweaks
echo "xterm*selectToClipboard: true" >> ~/.Xresources

# Install GitHub CLI
TEMP_DEB="$(mktemp)" &&
wget -O "$TEMP_DEB" 'https://github.com/cli/cli/releases/download/v2.7.0/gh_2.7.0_linux_amd64.deb' &&
sudo dpkg -i "$TEMP_DEB"
rm -f "$TEMP_DEB"

gh auth login
gh repo clone lubianat/dotfiles
mv dotfiles/.zshrc ~/.zshrc

# Install Python 3.10
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.10 -y
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 2
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1

# Set up main virtualenv
pip3 install virtualenv
virtualenv -p python3.10.4 main_venv
source main_venv/bin/activate 

# Install main virtualenv requirements
pip3 install -r dotfiles/main_venv_requirements.txt

# Install vscode
TEMP_DEB="$(mktemp)" &&
wget -O "$TEMP_DEB" "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64" &&
sudo dpkg -i "$TEMP_DEB"
rm -f "$TEMP_DEB"

# Install Google Chrome
TEMP_DEB="$(mktemp)" &&
wget -O "$TEMP_DEB"  "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb" &&
sudo dpkg -i "$TEMP_DEB"
rm -f "$TEMP_DEB"

: '
#Update GNOME version (https://www.linuxcapable.com/how-to-install-gnome-41-desktop-on-ubuntu-20-04/)
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:devacom/x11 -y
sudo add-apt-repository ppa:devacom/gnome-40 -y
sudo add-apt-repository ppa:devacom/gnome-41 -y
sudo apt-get update
sudo apt install ubuntu-desktop gnome-shell gnome-control-center -y
sudo apt upgrade -y
sudo reboot
'

