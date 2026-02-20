#!/usr/bin/env bash

# Essential audio/video codecs
dnf groupupdate -y core
dnf groupupdate -y multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf groupupdate -y sound-and-video

CLI_PKGS=(
  btop
  fastfetch
  git
  tar
  unzip
  wget
  curl
  zsh
)

echo "Installing base utilities..."
dnf install -y "${CLI_PKGS[@]}"
