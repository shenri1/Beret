#!/usr/bin/env zsh
# Uninstall Zellij
rm -f /usr/local/bin/zellij
USER_HOME="/home/$SUDO_USER"
rm -rf "$USER_HOME/.config/zellij"
echo "Zellij uninstalled."
