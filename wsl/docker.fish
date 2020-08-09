#!/usr/bin/env fish
cd (dirname (status filename))
mkdir -p ~/.docker

#===== docker =====
curl https://get.docker.com > ~/.tmp/docker_install.sh
chmod +x ~/.tmp/docker_install.sh
~/.tmp/docker_install.sh
sudo usermod -aG docker $USER
sudo systemctl enable docker
# https://pepa.holla.cz/wp-content/uploads/2016/10/Using-Docker.pdf

#===== docker-compose =====
curl -L https://github.com/docker/compose/releases/download/1.25.4/docker-compose-(uname -s)-(uname -m) > ~/.docker/docker-compose
chmod +x ~/.docker/docker-compose
set fish_user_paths $fish_user_paths $HOME/.docker
# simple docker-compose.yml is

echo "
if sudo service docker status
    echo Docker is running
else
    sudo service docker start
end
" >> $HOME/.config/fish/config.fish

