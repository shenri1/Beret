#!/usr/bin/env bash

# Flathub config
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#flatpaks apps
flatpak install flathub com.rtosta.zapzap
flatpak install flathub com.discordapp.Discord
flatpak install flathub com.obsproject.Studio
flatpak install flathub org.qbittorrent.qBittorrent
# IDK which one to install
flatpak install flathub com.vscodium.codium
flatpak install flathub dev.zed.Zed
