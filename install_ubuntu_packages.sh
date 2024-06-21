#!/bin/bash

basedir="/home/lubianat/Documents"
cd basedir

# Install apt programs
AptPackage="curl git zsh 
telegram-desktop python3-venv 
nodejs yarn inkscape gparted 
htop libreoffice libreoffice-style-breeze 
xclip npm openssh-server putty-tools rsync flatpak"

for i in $AptPackage; do
  sudo apt install $i -y
done

git config --global user.email "tiago.lubiana.alves@usp.br"
git config --global user.name "Tiago Lubiana"
git config --global init.defaultBranch main 


read -p 'Login on Github? (y/n): ' uservar

if [ $uservar = "y" ]; then
    gh auth login
fi

logout

# Set up basic directory structure
mkdir wiki_related lab_related random

# Import core repositories
LabRepos="wikidata_cell_curation"
cd $basedir/lab_related 
for val in $LabRepos; do
    gh repo clone lubianat/$val
    echo "======================="
done


WikiRepos="inat2wiki"
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
cp $basedir/random/dotfiles/.zshrc ~/.zshrc


# Install calibre
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin

# Remove annoying beep sounds
sudo sed -i 's/# set bell-style none/set bell-style none/g' /etc/inputrc


#sudo apt install python3-pip -y
pip3 install virtualenv
sudo apt install python3-virtualenv -y

# Set up virtual environment
python3 -m virtualenv main_venv
source $basedir/main_venv/bin/activate 
#curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py 
#python3.10 get-pip.py      
#rm get-pip.py

pip3 install -r $basedir/random/dotfiles/main_venv_requirements.txt
 
# Reinstall audio
# sudo apt-get install --reinstall alsa-base pulseaudio -y
# sudo alsa force-reload 

# Remove annoying beep sounds
# sudo sed -i 's/# set bell-style none/set bell-style none/g' /etc/inputrc

# Install Camelo keyboard
cd /usr/share/X11/xkb/symbols
sudo wget -O camelo https://raw.githubusercontent.com/lubianat/camelo/main/camelo
sudo dpkg-reconfigure xkb-data
cd /usr/share/X11/xkb/rules
sudo wget -O evdev.xml https://raw.githubusercontent.com/lubianat/camelo/main/evdev.xml
setxkbmap -option grp:alt_shift_toggle camelo,pt

# Install Zotero
cd ~ && curl -sL https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash

cp ~/Documents/random/dotfiles/vscode/settings.json ~/.config/Code/User/settings.json

sudo snap install slack

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# BB Security Module, GitHub CLI, GitHub Desktop VScode, Google Chrome
Urls='
https://zoom.us/client/latest/zoom_amd64.deb
https://cloud.gastecnologia.com.br/bb/downloads/ws/warsaw_setup64.deb
https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64
'

for url in $Urls; do
    TEMP_DEB="$(mktemp)" &&
wget -O "$TEMP_DEB" $url  &&
sudo dpkg -i "$TEMP_DEB"
rm -f "$TEMP_DEB"
done
