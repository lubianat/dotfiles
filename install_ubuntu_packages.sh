#!/bin/bash

basedir="/home/lubianat/Documents"

# BB Security Module, GitHub CLI, GitHub Desktop VScode, Google Chrome


# Install apt programs
AptPackage="curl git zsh 
telegram-desktop python3-venv 
nodejs yarn inkscape gparted 
htop libreoffice libreoffice-style-breeze"

for i in $AptPackage; do
  sudo apt install $i -y
done

git config --global user.email "tiago.lubiana.alves@usp.br"
git config --global user.name "Tiago Lubiana"

# BB Security Module, GitHub CLI, GitHub Desktop VScode, Google Chrome
Urls='https://cloud.gastecnologia.com.br/bb/downloads/ws/warsaw_setup64.deb
https://github.com/cli/cli/releases/download/v2.7.0/gh_2.7.0_linux_amd64.deb
https://github.com/shiftkey/desktop/releases/download/release-2.9.12-linux4/GitHubDesktop-linux-2.9.12-linux4.deb 
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

logout

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
cp $basedir/random/dotfiles/.zshrc ~/.zshrc


# Install calibre
sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sudo sh /dev/stdin
# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Remove annoying beep sounds
sudo sed -i 's/# set bell-style none/set bell-style none/g' /etc/inputrc


# Install Python 3.10. Note: do NOT set is as base python
#sudo add-apt-repository ppa:deadsnakes/ppa
#sudo apt update
#sudo apt install python3.10 -y
#sudo apt-get install python3.10-distutils -y
#sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 2
#sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.8 1
#sudo update-alternatives  --set python3 /usr/bin/python3.8

#sudo apt install python3-pip -y
pip3 install virtualenv
sudo apt install python3-virtualenv -y

# Set up virtual environment
#python3 -m virtualenv -p python3.10.4 main_venv --no-pip
python3 -m virtualenv main_venv
source $basedir/main_venv/bin/activate 
#curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py 
#python3.10 get-pip.py      
#rm get-pip.py

pip3 install -r $basedir/random/dotfiles/main_venv_requirements.txt
 
# Reinstall audio
sudo apt-get install --reinstall alsa-base pulseaudio -y
sudo alsa force-reload 

# Remove annoying beep sounds
sudo sed -i 's/# set bell-style none/set bell-style none/g' /etc/inputrc

# Install Camelo keyboard
cd /usr/share/X11/xkb/symbols
sudo wget -O camelo https://raw.githubusercontent.com/lubianat/camelo/main/camelo
sudo dpkg-reconfigure xkb-data
cd /usr/share/X11/xkb/rules
sudo wget -O evdev.xml https://raw.githubusercontent.com/lubianat/camelo/main/evdev.xml
setxkbmap -option grp:alt_shift_toggle camelo,pt

# Install Protege Ontology Editor
mkdir $basedir/Apps
cd $basedir/Apps
wget https://github.com/protegeproject/protege-distribution/releases/download/v5.5.0/Protege-5.5.0-linux.tar.gz
tar zxvf Protege-5.5.0-linux.tar.gz
rm Protege-5.5.0-linux.tar.gz

echo "[Desktop Entry]
Version=1.0
Exec=$basedir/Apps/Protege-5.5.0/run.sh
Name=Protege
GenericName=Protege
Comment=Opens Protege Ontology Editor
Encoding=UTF-8
Terminal=true
Type=Application
Categories=Application" > /home/lubianat/Desktop/protege.desktop


echo '=========================='
echo "To set up protege, right-click on 
the Protege file on the Desktop and 
select the “Allow launching” option."
echo '=========================='

read -p 'Ok?' nothing

