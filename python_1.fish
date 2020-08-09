#!/usr/bin/env fish
cd (dirname (status filename))
sudo apt-get install -y make build-essential zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
xz-utils tk-dev libffi-dev liblzma-dev python-openssl git libssl-dev
# if you use ubuntu, use libssl1.0-dev instead of libssl-dev
# https://github.com/pyenv/pyenv/wiki/Common-build-problems
curl https://pyenv.run | bash

set -U fish_user_paths $HOME/.pyenv/bin $fish_user_paths
set -Ux  PYTHONPATH $WKDIR/library/python $PYTHONPATH

echo 'pyenv init - | source' >> $HOME/.config/fish/config.fish
cp ./python_functions/* $HOME/.config/fish/functions/
