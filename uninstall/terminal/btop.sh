#!/usr/bin/env zsh
# Uninstall btop
dnf remove -y btop
USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
rm -rf "$USER_HOME/.config/btop"
echo "btop uninstalled."
