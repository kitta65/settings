#!/usr/bin/env fish
cd (dirname (status filename))
sudo service docker status
if test $status -eq 3
    sudo service docker start
end
docker pull danlynn/bat
cp ./bat_functions/bat.fish $HOME/.config/fish/functions/bat.fish
