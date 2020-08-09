#!/usr/bin/env fish
cd (dirname (status filename))

read -U -p 'echo -e "input your project\n: "' gcp_project
read -U -p 'echo -e "input your zone\ne.g. us-west1-a\n: "' gce_zone
read -U -p 'echo -e "input sync directory\ne.g. /mnt/c/Users/username/Documents/\n: "' gce_sync_dir
read -U -p 'echo -e "input the name of your compute engine\n: "' gce_name

cp ./gcp_functions/* $HOME/.config/fish/functions/

##===== install =====
sudo apt update
sudo apt-get install apt-transport-https ca-certificates gnupg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt-get -y update ; and sudo apt-get -y install google-cloud-sdk
gcloud init
#gcloud config set compute/zone $gce_zone
#gcloud config set compute/region
