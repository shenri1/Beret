#!/usr/bin/env zsh
# Uninstall Cursor
USER_HOME="/home/$SUDO_USER"
rm -f "$USER_HOME/.local/bin/cursor"
rm -f "$USER_HOME/.local/share/applications/cursor.desktop"
echo "Cursor uninstalled."
