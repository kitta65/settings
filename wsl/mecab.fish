#!/usr/bin/env fish
cd (dirname (status filename))
mkdir -p $HOME/.dic

#===== install mecab =====
sudo apt update
sudo apt install -y mecab libmecab-dev mecab-ipadic-utf8

#===== install neologd =====
mkdir -p $HOME/.tmp
git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git $HOME/.tmp/mecab-ipadic-neologd
yes 'yes' | $HOME/.tmp/mecab-ipadic-neologd/bin/install-mecab-ipadic-neologd -n

set -Ux SYSTEM_DIC (mecab-config --dicdir)"/mecab-ipadic-neologd"
set -Ux USER_DIC "$HOME/.dic/user.dic"
cp ./mecab_functions/csv2dic.fish $HOME/.config/fish/functions/csv2dic.fish
