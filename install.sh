#!/usr/bin/env bash

apt update
apt -y install git

cd /opt
git clone https://github.com/Crouton-Digital/story-monitoring.git
cd story-monitoring

mkdir ./volumes/prometheus_disk
chown nobody:nogroup ./volumes/prometheus_disk

docker compose up -d
