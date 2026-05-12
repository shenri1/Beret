#!/usr/bin/env zsh
# Uninstall Zed
USER_HOME="/home/$SUDO_USER"
rm -f /usr/local/bin/zed "$USER_HOME/.local/bin/zed"
rm -rf "$USER_HOME/.local/share/zed"
rm -rf "$USER_HOME/.config/zed"
echo "Zed uninstalled."
