#!/usr/bin/env zsh
# Uninstall Cursor
USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
rm -f "$USER_HOME/.local/bin/cursor"
rm -f "$USER_HOME/.local/share/applications/cursor.desktop"
echo "Cursor uninstalled."
