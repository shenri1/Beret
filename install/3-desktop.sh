#!/usr/bin/env bash

# To install Brave Browser
sudo dnf config-manager addrepo --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

DNF_PKGS=(
  brave-browser
  dnf-plugins-core
  mpv
  gimp
  lpf-spotify-client
  ffmpeg
  xournalpp
  kdenlive
)

echo "Installing base utilities..."
dnf install -y "${DNF_PKGS[@]}"
