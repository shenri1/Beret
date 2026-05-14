#!/usr/bin/env zsh
# Uninstall Fonts
USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
rm -f "$USER_HOME/.local/share/fonts/JetBrainsMonoNerdFont-*.ttf"
rm -f "$USER_HOME/.local/share/fonts/iAWriterMonoS-*.ttf"
fc-cache
echo "Fonts removed."
