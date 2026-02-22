#!/usr/bin/env bash

TERMINAL_PKGS=(
  neovim
  wget
  curl
  fd-find
  eza
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
