#!/usr/bin/env zsh
# Uninstall btop
dnf remove -y btop
USER_HOME="/home/$SUDO_USER"
rm -rf "$USER_HOME/.config/btop"
echo "btop uninstalled."
