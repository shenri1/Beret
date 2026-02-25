#!/usr/bin/env bash

# Flathub config
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Flatpak apps
flatpak install -y flathub com.rtosta.zapzap
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub com.spotify.Client

clear
