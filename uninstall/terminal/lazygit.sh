#!/usr/bin/env zsh
# Uninstall lazygit
rm -f /usr/local/bin/lazygit
USER_HOME="/home/$SUDO_USER"
rm -rf "$USER_HOME/.config/lazygit"
echo "lazygit uninstalled."
