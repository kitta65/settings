#!/usr/bin/env fish
cd (dirname (status filename))

sudo apt -y install \
    make build-essential zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git libssl-dev
# https://github.com/pyenv/pyenv/wiki/Common-build-problems
# if you use ubuntu, you may have to use libssl1.0-dev instead of libssl-dev

curl https://pyenv.run | bash
set -U fish_user_paths $HOME/.pyenv/bin $fish_user_paths

echo 'done!!! next, you have to install and determin python version.
below is an example.

```
set -l ver "3.7.0"
pyenv install $ver
pyenv global $ver
```
'
