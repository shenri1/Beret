#!/usr/bin/env zsh
# Uninstall Fonts
USER_HOME="/home/$SUDO_USER"
rm -f "$USER_HOME/.local/share/fonts/JetBrainsMonoNerdFont-*.ttf"
rm -f "$USER_HOME/.local/share/fonts/iAWriterMonoS-*.ttf"
fc-cache
echo "Fonts removed."
