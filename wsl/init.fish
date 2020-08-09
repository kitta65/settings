#!/usr/bin/env fish
cd (dirname (status filename))
sudo apt update
sudo apt -y install curl git vim bat zip unzip
mkdir -p ~/.tmp

#===== wsl =====
read -p 'echo -e "input your user name of windows\n: "' winuser
echo -e "[interop]\nappendWindowsPath = false" | sudo tee -a /etc/wsl.conf
set -U fish_user_paths /mnt/c/WINDOWS/system32 $fish_user_paths
echo '[wsl2]
localhostForwarding=True
memory=4GB' > /mnt/c/Users/$winuser/.wslconfig

##===== ssh =====
echo 'ServerAliveInterval 15' | sudo tee -a /etc/ssh/ssh_config
echo 'ServerAliveCountMax 3' | sudo tee -a /etc/ssh/ssh_config

#===== git =====
read -p 'echo -e "input your mail for git\n: "' git_mail
ssh-keygen -t rsa -b 4096 -C $git_mail
git config --global user.email $git_mail
git config --global user.name $USER
git config --global core.editor vim
git config --global color.ui auto

#===== exa =====
set -U fish_user_paths $HOME/.exa $fish_user_paths
mkdir -p ~/.exa
curl -L https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip > ~/.tmp/exa-linux-x86_64-0.9.0.zip
unzip ~/.tmp/exa-linux-x86_64-0.9.0.zip
mv ./exa-linux-x86_64 ~/.exa/exa
set -Ux EXA_COLORS "da=1;35"
