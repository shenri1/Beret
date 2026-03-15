#!/usr/bin/env zsh
# Uninstall fastfetch
dnf remove -y fastfetch
USER_HOME="/home/$SUDO_USER"
rm -rf "$USER_HOME/.config/fastfetch"
echo "fastfetch uninstalled."
