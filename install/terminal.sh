#!/usr/bin/env bash

sudo dnf update -y
sudo dnf upgrade -y
sudo dnf install -y curl git unzip wget fd-find fzf bat whois ripgrep zoxide kitty

for installer in ~/.local/share/berret/install/*; do
    source "$installer"
done
