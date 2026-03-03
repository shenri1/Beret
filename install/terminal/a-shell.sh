#!/usr/bin/env bash

# Configure the bash shell using Berret defaults
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak
cp ~/.local/share/berret/configs/bashrc ~/.bashrc

# Load the PATH for use later in the installers
source ~/.local/share/berret/defaults/bash/shell

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak
# Configure the inputrc using Berret defaults
cp ~/.local/share/berret/configs/inputrc ~/.inputrc















TERMINAL_PKGS=(
  neovim
  wget
  kitty
  curl
  fd-find
  fzf
  ripgrep
  zoxide
  btop
  bat
  fastfetch
  tldr
  whois
  git
)

echo "Installing terminal utilities..."
dnf install -y --skip-unavailable "${TERMINAL_PKGS[@]}"

clear
