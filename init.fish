#!/usr/bin/env fish
cd (dirname (status filename))
set -U setting_path (pwd)
sudo apt update
sudo apt -y install \
    # common
    curl git vim bat zip unzip neovim \
    # mecab
    mecab libmecab-dev mecab-ipadic-utf8 \
    # nvim
    make build-essential zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git libssl-dev
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
curl -L https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip > ~/.tmp/exa-linux-x86_64-0.9.0.zip
unzip ~/.tmp/exa-linux-x86_64-0.9.0.zip
mv ./exa-linux-x86_64 usr/local/bin/exa
set -Ux EXA_COLORS "da=1;35"

#===== watcher =====
ln -s $setting_path/dotfiles/.wathcer ~/.watcher

#===== nvim =====
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > ~/.tmp/nvim.appimage
chmod u+x ~/.tmp/nvim_appimage

~/.tmp/nvim_appimage --appimage-extract
mv squashfs-root/ ~/.nvim/
set fish_user_paths $fish_user_paths $HOME/.nvim/squashfs-root/usr/bin
ln -s $HOME/.nvim/nvim $HOME/.config/nvim
git config --global core.editor nvim

#===== pyenv =====
curl https://pyenv.run | bash
set -U fish_user_paths $HOME/.pyenv/bin $fish_user_paths
# https://github.com/pyenv/pyenv/wiki/Common-build-problems
# if you use ubuntu, you may have to use libssl1.0-dev instead of libssl-dev
