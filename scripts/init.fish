#!/usr/bin/env fish
cd (dirname (status filename))
set -U dotfiles_path (string replace -r "scripts\$" 'dotfiles' (pwd))
sudo apt update
sudo apt -y install \
    curl git vim zip unzip colordiff \
    mecab libmecab-dev mecab-ipadic-utf8 \
    fuse
mkdir -p ~/.tmp
cd ~/.tmp

#==== fish =====
ln -s $dotfiles_path/fish/functions ~/.config/fish/functions
ln -s $dotfiles_path/fish/config.fish ~/.config/fish/config.fish

#===== wsl =====
read -p 'echo -e "input your user name of windows\n: "' winuser
echo -e "[interop]\nappendWindowsPath = false" | sudo tee /etc/wsl.conf
set -U fish_user_paths /mnt/c/WINDOWS/system32 $fish_user_paths
set -U fish_user_paths /mnt/c/WINDOWS/System32/WindowsPowerShell/v1.0 $fish_user_paths
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
ln -s $dotfiles_path/git $HOME/.config/git

##===== ssh =====
mkdir -p $HOME/.ssh
echo 'ServerAliveInterval 15
ServerAliveCountMax 3' >  $HOME/.ssh/config

#===== exa =====
curl -L https://github.com/ogham/exa/releases/download/v0.9.0/exa-linux-x86_64-0.9.0.zip > ~/.tmp/exa-linux-x86_64-0.9.0.zip
unzip ~/.tmp/exa-linux-x86_64-0.9.0.zip
sudo mv ./exa-linux-x86_64 /usr/local/bin/exa
set -Ux EXA_COLORS "da=1;35"

#===== nodejs (via n) =====
curl -L https://git.io/n-install | bash
set -Ux N_PREFIX $HOME/n
set -U fish_user_paths $N_PREFIX/bin $fish_user_paths
# yarn
npm install -g yarn
set -Ux fish_user_paths $HOME/.yarn/bin $fish_user_paths
# serve
yarn global add serve

#===== clasp =====
sudo npm install -g @google/clasp
# https://github.com/google/clasp/issues/736

#===== nvim =====
mkdir -p $HOME/.config/coc
curl -L https://github.com/neovim/neovim/releases/download/v0.4.4/nvim.appimage > ~/.tmp/nvim.appimage
chmod u+x ~/.tmp/nvim.appimage
sudo mv ~/.tmp/nvim.appimage /usr/local/bin/nvim
ln -s $dotfiles_path/nvim $HOME/.config/nvim
ln -s $dotfiles_path/nvim/snip $HOME/.config/coc/ultisnips
git config --global core.editor nvim

# vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

#===== ngrok =====
curl -LO https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip /path/to/ngrok.zip
sudo mv ./ngrok /usr/local/bin

#===== rust =====
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
set -U fish_user_paths $HOME/.cargo/bin $fish_user_paths

#===== go =====
curl -OL https://golang.org/dl/go1.15.7.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.15.7.linux-amd64.tar.gz
set -U fish_user_paths /usr/local/go/bin $fish_user_paths

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

#===== message =====
echo '
done!!!
'
