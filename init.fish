#!/usr/bin/env fish
cd (dirname (status filename))
set -U setting_path (pwd)
sudo apt update
sudo apt -y install \
    curl git vim bat zip unzip neovim \
    mecab libmecab-dev mecab-ipadic-utf8
mkdir -p ~/.tmp

#==== fish =====
ln -s $setting_path/dotfiles/fish/functions ~/.config/fish/functions
ln -s $setting_path/dotfiles/fish/config.fish ~/.config/fish/config.fish

#===== wsl =====
read -p 'echo -e "input your user name of windows\n: "' winuser
echo -e "[interop]\nappendWindowsPath = false" | sudo tee -a /etc/wsl.conf
set -U fish_user_paths /mnt/c/WINDOWS/system32 $fish_user_paths
echo '[wsl2]
localhostForwarding=True
memory=4GB' > /mnt/c/Users/$winuser/.wslconfig

#===== git =====
read -p 'echo -e "input your mail for git\n: "' git_mail
ssh-keygen -t rsa -b 4096 -C $git_mail
git config --global user.email $git_mail
git config --global user.name $USER
git config --global core.editor vim
git config --global color.ui auto

##===== ssh =====
mkdir -p $HOME/.ssh
echo 'ServerAliveInterval 15
ServerAliveCountMax 3' >  $HOME/.ssh/config

#===== exa =====
curl -L https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip > ~/.tmp/exa-linux-x86_64-0.9.0.zip
unzip ~/.tmp/exa-linux-x86_64-0.9.0.zip
sudo mv ./exa-linux-x86_64 /usr/local/bin/exa
set -Ux EXA_COLORS "da=1;35"

#===== watcher =====
ln -s $setting_path/dotfiles/.wathcer ~/.watcher

#===== nodejs (via n) =====
sudo apt install -y nodejs npm
sudo npm install n -g
sudo n stable
sudo apt purge -y nodejs npm

#===== clasp =====
sudo npm install -g @google/clasp
sudo npm install -g inquirer # dependent package
