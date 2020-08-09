#!/usr/bin/env fish
cd (dirname (status filename))

#===== nvim =====
mkdir -p ~/.nvim

#===== dein =====
curl https://raw.githubusercontent.com/shougo/dein.vim/master/bin/installer.sh > ~/.tmp/dein_installer.sh
sh ~/.tmp/dein_installer.sh ~/.dein
pip install pynvim # deoplete
