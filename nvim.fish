#!/usr/bin/env fish
cd (dirname (status filename))
which pyenv
if test $status -ne 0
    echo 'installation error `pyenv`'
end

#===== nvim =====
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > ~/.tmp/nvim.appimage
chmod u+x ~/.tmp/nvim_appimage
sudo mv ~/.tmp/nvim_appimage /usr/local/bin/nvim
ln -s $HOME/.nvim/nvim $HOME/.config/nvim
git config --global core.editor nvim

#===== dein =====
curl https://raw.githubusercontent.com/shougo/dein.vim/master/bin/installer.sh > ~/.tmp/dein_installer.sh
sh ~/.tmp/dein_installer.sh ~/.dein
#pip install pynvim # deoplete
