#!/usr/bin/env fish
cd (dirname (status filename))

#===== nvim =====
mkdir ~/.nvim
curl -L -o ~/.nvim/nvim_appimage https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
chmod u+x ~/.nvim/nvim_appimage
~/.nvim/nvim_appimage --appimage-extract
mv squashfs-root/ ~/.nvim/
git clone https://github.com/dr666m1/setting_nvim.git ~/.nvim/nvim
git clone https://github.com/dr666m1/setting_snippet.git ~/.nvim/snip
set fish_user_paths $fish_user_paths $HOME/.nvim/squashfs-root/usr/bin
ln -s $HOME/.nvim/nvim $HOME/.config/nvim
git config --global core.editor nvim

#===== dein =====
curl https://raw.githubusercontent.com/shougo/dein.vim/master/bin/installer.sh > ~/.tmp/dein_installer.sh
sh ~/.tmp/dein_installer.sh ~/.nvim/dein
pip install pynvim # deoplete
