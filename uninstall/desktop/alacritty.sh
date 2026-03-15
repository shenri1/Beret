#!/usr/bin/env zsh
# Uninstall Alacritty and its configuration
dnf remove -y alacritty
USER_HOME="/home/$SUDO_USER"
rm -rf "$USER_HOME/.config/alacritty"
rm -f "$USER_HOME/.config/alacritty.toml"
echo "Alacritty uninstalled."
