#!/usr/bin/env zsh
# Uninstall Alacritty and its configuration
dnf remove -y alacritty
USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
rm -rf "$USER_HOME/.config/alacritty"
rm -f "$USER_HOME/.config/alacritty.toml"
echo "Alacritty uninstalled."
