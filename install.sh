#!/usr/bin/env bash

sudo apt update
sudo apt -y install git

cd /opt
git clone https://github.com/Crouton-Digital/story-monitoring.git
cd story-monitoring

mkdir ./volumes/prometheus_disk
chown 65534:65534 ./volumes/prometheus_disk

sudo docker compose up -d
