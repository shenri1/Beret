#!/usr/bin/env zsh
# Uninstall fastfetch
dnf remove -y fastfetch
USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
rm -rf "$USER_HOME/.config/fastfetch"
echo "fastfetch uninstalled."
