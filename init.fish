#!/usr/bin/env fish
cd (dirname (status filename))
set -U setting_path (pwd)
sudo apt update
sudo apt -y install \
    curl git vim zip unzip \
    mecab libmecab-dev mecab-ipadic-utf8 \
    fuse
mkdir -p ~/.tmp

#==== fish =====
ln -s $setting_path/dotfiles/fish/functions ~/.config/fish/functions
ln -s $setting_path/dotfiles/fish/config.fish ~/.config/fish/config.fish

#===== oh my fish =====
curl -L https://get.oh-my.fish | fish
omf install batman

#===== wsl =====
read -p 'echo -e "input your user name of windows\n: "' winuser
echo -e "[interop]\nappendWindowsPath = false" | sudo tee -a /etc/wsl.conf
set -U fish_user_paths /mnt/c/WINDOWS/system32 $fish_user_paths
echo '[wsl2]
localhostForwarding=True
memory=4GB' > /mnt/c/Users/$winuser/.wslconfig

#===== git =====
read -p 'echo -e "input your mail for git\n: "' git_mail
ssh-keygen -t rsa -b 4096 -C $git_mail
git config --global user.email $git_mail
git config --global user.name $USER
git config --global core.editor vim
git config --global color.ui auto

##===== ssh =====
mkdir -p $HOME/.ssh
echo 'ServerAliveInterval 15
ServerAliveCountMax 3' >  $HOME/.ssh/config

#===== exa =====
curl -L https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip > ~/.tmp/exa-linux-x86_64-0.9.0.zip
unzip ~/.tmp/exa-linux-x86_64-0.9.0.zip
sudo mv ./exa-linux-x86_64 /usr/local/bin/exa
set -Ux EXA_COLORS "da=1;35"

#===== watcher =====
ln -s $setting_path/dotfiles/.watcher ~/.watcher

#===== nodejs (via n) =====
sudo apt install -y nodejs npm
sudo npm install n -g
sudo n stable
sudo apt purge -y nodejs npm

#===== clasp =====
sudo npm install -g @google/clasp
sudo npm install -g inquirer # dependent package

#===== nvim =====
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > ~/.tmp/nvim.appimage
chmod u+x ~/.tmp/nvim.appimage
sudo mv ~/.tmp/nvim.appimage /usr/local/bin/nvim
ln -s $setting_path/dotfiles/nvim $HOME/.config/nvim
git config --global core.editor nvim

#===== dein =====
curl https://raw.githubusercontent.com/shougo/dein.vim/master/bin/installer.sh > ~/.tmp/dein_installer.sh
sh ~/.tmp/dein_installer.sh ~/.dein
pip install pynvim # deoplete # maybe later

#===== pyenv =====
sudo apt -y install \
    make build-essential zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev python-openssl git libssl-dev
# https://github.com/pyenv/pyenv/wiki/Common-build-problems
# if you use ubuntu, you may have to use libssl1.0-dev instead of libssl-dev

curl https://pyenv.run | bash
set -U fish_user_paths $HOME/.pyenv/bin $fish_user_paths

#===== gcp =====
sudo apt update
sudo apt install apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get -y update; sudo apt-get -y install google-cloud-sdk
gcloud init

echo '
done!!!

SUGGESTION... you can create service account and specify credential like below.
```
set -Ux GOOGLE_APPLICATION_CREDENTIALS $HOME/.gcp/xxxxxx.json
```

SUGGESTION... you have to install and determin python version like below.
```
set -l ver "3.7.0"
pyenv install $ver
pyenv global $ver
```
'
