#!/bin/bash
cd $(dirname $0)/..
PROJECT_ROOT=$(pwd)
mkdir -p $HOME/.tmp

# in the case of WindowsPath is not appended
export PATH=$PATH:/mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0
WINUSER=$(powershell.exe '$env:UserName' | tr -d '')

sudo apt update
sudo apt install bat

#------------------------------
# zsh
#------------------------------

sudo apt -y install zsh
chsh -s $(which zsh)

# initialize
mkdir -p "$HOME/.zsh"
rm -rf $HOME/.zsh/* &> /dev/null
rm $HOME/.zprofile $HOME/.zshrc &> /dev/null

# .zprofile, .zshrc
ln -s $PROJECT_ROOT/dotfiles/zsh/.zshrc $HOME/.zshrc
ln -s $PROJECT_ROOT/dotfiles/zsh/.zprofile $HOME/.zprofile

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions

# pure
git clone https://github.com/sindresorhus/pure.git $HOME/.zsh/pure

#------------------------------
# wsl
#------------------------------
echo -e "[interop]\nappendWindowsPath = false" | sudo tee /etc/wsl.conf
echo '[wsl2]
localhostForwarding=True
memory=4GB' > /mnt/c/Users/$WINUSER/.wslconfig

#------------------------------
# exa
#------------------------------
curl -L https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip > ~/.tmp/exa-linux-x86_64-0.9.0.zip
unzip ~/.tmp/exa-linux-x86_64-0.9.0.zip
sudo mv ./exa-linux-x86_64 /usr/local/bin/exa

#------------------------------
# nodejs
#------------------------------
if [ ! -d $HOME/n ]; then
  curl -L https://git.io/n-install | bash
fi
npm install -g yarn
yarn global add serve
#------------------------------
# python
#------------------------------

# poetry
if [ ! -e $HOME/.local/bin/poetry ]; then
  curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
fi

