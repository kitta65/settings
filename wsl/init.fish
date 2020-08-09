#!/usr/bin/env fish
cd (dirname (status filename))
sudo apt update
sudo apt -y install curl git vim bat

#===== path & link & directory =====
read -p 'echo -e "input main working directory\ne.g. /mnt/c/Users/username/Documents\n: "' wkdir
set -U WKDIR $wkdir
read -p 'echo -e "input download directory\ne.g. /mnt/c/Users/username/Downloads\n: "' dldir
read -p 'echo -e "input desktop directory\ne.g. /mnt/c/Users/username/Desktop\n: "' dtdir
ln -s $dldir $WKDIR/downloads
ln -s $dtdir $WKDIR/desktop
echo -e "[interop]\nappendWindowsPath = false" | sudo tee -a /etc/wsl.conf
set -U fish_user_paths /mnt/c/WINDOWS/system32 $fish_user_paths

#===== directory =====
mkdir -p ~/.tmp
mkdir -p ~/.crontab

##===== ssh =====
read -p 'echo -e "input your dummy mail address for github\ne.g. sample@example.com\n: "' github_mail
set -U GITHUB_MAIL $github_mail
ssh-keygen -t rsa -C $GITHUB_MAIL
echo 'ServerAliveInterval 15' | sudo tee -a /etc/ssh/ssh_config
echo 'ServerAliveCountMax 3' | sudo tee -a /etc/ssh/ssh_config

#===== git =====
git config --global user.email $GITHUB_MAIL
git config --global user.name $USER
git config --global core.editor vim
git config --global color.ui auto

#===== exa =====
set -U fish_user_paths $HOME/.exa $fish_user_paths
sudo apt install zip unzip
mkdir -p ~/.exa
curl -L https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip > ~/.exa/exa-linux-x86_64-0.9.0.zip
unzip ~/.exa/exa-linux-x86_64-0.9.0.zip
mv ./exa-linux-x86_64 ~/.exa/exa
set -Ux EXA_COLORS "da=1;35"

#===== functions =====
mkdir -p $HOME/.config/fish/functions
cp ./basic_functions/* $HOME/.config/fish/functions/

#===== other =====
read -p 'echo -e "input your user name of windows\n: "' winuser
echo '[wsl2]
localhostForwarding=True
memory=4GB
swap=0' > /mnt/c/Users/$winuser/.wslconfig
