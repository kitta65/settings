#!/bin/bash
cd $(dirname $0)/..
PROJECT_ROOT=$(pwd)

sudo apt update

#------------------------------
# zsh
#------------------------------

sudo apt -y install zsh
chsh -s $(which zsh)

# initialize
mkdir -p "$HOME/.zsh"
rm -rf $HOME/.zsh/*
rm $HOME/.zshrc

# .zshrc
ln -s $PROJECT_ROOT/dotfiles/zsh/.zshrc $HOME/.zshrc

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.zsh/zsh-autosuggestions

# pure
git clone https://github.com/sindresorhus/pure.git $HOME/.zsh/pure
