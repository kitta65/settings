#!/usr/bin/env fish
cd (dirname (status filename))

sudo apt update
sudo apt install apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get -y update; sudo apt-get -y install google-cloud-sdk
gcloud init
set -Ux GOOGLE_APPLICATION_CREDENTIALS $HOME/.gcp/xxxxxx.json
