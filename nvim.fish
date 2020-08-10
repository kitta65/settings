#!/usr/bin/env fish
cd (dirname (status filename))
which pyenv
if test $status -ne 0
    echo 'installation error `pyenv`'
    exit
end

#===== nvim =====
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > ~/.tmp/nvim.appimage
chmod u+x ~/.tmp/nvim.appimage
sudo mv ~/.tmp/nvim.appimage /usr/local/bin/nvim
ln -s $setting_path/dotfiles/nvim $HOME/.config/nvim
git config --global core.editor nvim

#===== dein =====
curl https://raw.githubusercontent.com/shougo/dein.vim/master/bin/installer.sh > ~/.tmp/dein_installer.sh
sh ~/.tmp/dein_installer.sh ~/.dein
pip install pynvim # deoplete