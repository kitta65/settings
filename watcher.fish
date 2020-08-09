#!/usr/bin/env fish
cd (dirname (status filename))
cp ./watcher_functions/* $HOME/.config/fish/functions/
mkdir -p $HOME/.watcher
echo '
version: "3"
services:
  websocket:
    image: dr666m1/image_watcher_websocket
    volumes:
      - .:/work/sync
    ports:
      - "9999:9999"
  webserver:
    image: dr666m1/image_watcher_webserver
    volumes:
      - .:/work/sync
    ports:
      - "8888:8888"
    depends_on:
      - websocket
' > $HOME/.watcher/docker-compose.yml
set -Ux WATCHERPATH $HOME/.watcher/docker-compose.yml
