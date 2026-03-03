#!/usr/bin/env bash

sudo dnf update -y
sudo dnf upgrade -y
sudo dnf install -y curl git unzip

for installer in ~/.local/share/berret/installers/*; do
    source "$installer"
done
