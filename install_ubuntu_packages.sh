#!/usr/bin/env bash 

sudo 

# Install curl 
sudo apt install curl -y

# Install git
sudo apt install git -y

# Install zsh
sudo apt install zsh -y
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

# Make directories
mkdir lab_related wiki_related random 

# Import core repositories

cd wiki_related 
gh repo clone lubianat/wikidata_bib
gh repo clone lubianat/wikidata_cell_curation
gh repo clone lubianat/numista2wikidata
gh repo clone lubianat/coin_herbarium
gh repo clone lubianat/
gh repo clone lubianat/wiki_convida


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
sudo apt install python3-pip -y
pip3 install virtualenv
sudo apt install python3-virtualenv -y

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



#!/bin/bash

basedir="/home/lubianat/Documents"

sudo apt install python3-pip -y
pip3 install virtualenv
sudo apt install python3-virtualenv -y

python3 -m virtualenv -p python3.10.4 main_venv
source $basedir/main_venv/bin/activate 
pip3 install wbib
exit 
# Install apt programs
AptPackage="curl git zsh 
telegram-desktop python3-venv 
nodejs yarn inkscape gparted 
htop libreoffice libreoffice-style-breeze"

for i in $AptPackage; do
  sudo apt install $i -y
done


# BB Security Module, GitHub CLI, VScode, Google Chrome
Urls = 'https://cloud.gastecnologia.com.br/bb/downloads/ws/warsaw_setup64.deb
https://github.com/cli/cli/releases/download/v2.7.0/gh_2.7.0_linux_amd64.deb
https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
'

for url in $Urls; do
    TEMP_DEB="$(mktemp)" &&
wget -O "$TEMP_DEB" $url  &&
sudo dpkg -i "$TEMP_DEB"
rm -f "$TEMP_DEB"
done

read -p 'Login on Github? (y/n): ' uservar

if [ $uservar = "y" ]; then
    gh auth login
fi

# Install calibre
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Remove annoying beep sounds
sudo sed -i 's/# set bell-style none/set bell-style none/g' /etc/inputrc


# Set up basic directory structure
mkdir wiki_related lab_related random

# Import core repositories

LabRepos=" gene-wordle bioinfo_brasil"
cd $basedir/lab_related 
for val in $LabRepos; do
    gh repo clone lubianat/$val
    echo "======================="
done


WikiRepos="wikidata_bib wikidata_cell_curation 
numista2wikidata coin_herbarium 
wiki_convida pynaturalist2commons
bioinfo_brasil"
cd $basedir/wiki_related 
for val in $WikiRepos; do
    gh repo clone lubianat/$val
    echo "======================="
done

RandomRepos="dotfiles planning camelo"
cd $basedir/random 
for val in $RandomRepos; do
    gh repo clone lubianat/$val
    echo "======================="
done

cd $basedir
mv $basedir/random/dotfiles/.zshrc ~/.zshrc


# Install Python 3.10. Note: do NOT set is as base python
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt update
sudo apt install python3.10 -y
sudo apt-get install python3.10-distutils -y
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 2
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
sudo update-alternatives  --set python3 /usr/bin/python3.8
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10
