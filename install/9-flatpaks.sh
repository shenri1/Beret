#!/usr/bin/env bash

# Flathub config
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#flatpaks apps
flatpak install flathub com.rtosta.zapzap
flatpak install flathub com.discordapp.Discord
flatpak install flathub com.spotify.Client

clear
