#!/usr/bin/env bash

apt update
apt -y install git

cd /opt
git clone https://github.com/Crouton-Digital/story-monitoring.git
cd story-monitoring

sudo mkdir ./volumes/prometheus_disk
sudo chown 65534:65534 ./volumes/prometheus_disk

docker compose up -d
