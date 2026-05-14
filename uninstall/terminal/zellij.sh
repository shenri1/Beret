#!/usr/bin/env zsh
# Uninstall Zellij
rm -f /usr/local/bin/zellij
USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
rm -rf "$USER_HOME/.config/zellij"
echo "Zellij uninstalled."
