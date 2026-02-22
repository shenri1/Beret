#!/usr/bin/env bash

# To install Brave Browser
dnf config-manager addrepo --overwrite --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo

DNF_PKGS=(
  brave-browser
  dnf-plugins-core
  mpv
  gimp
  xournalpp
  kdenlive
)

echo "Installing base utilities..."
dnf install -y --skip-unavailable "${DNF_PKGS[@]}"

clear
