#!/usr/bin/env zsh
# Uninstall Xournalpp
dnf remove -y xournalpp
USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
rm -rf "$USER_HOME/.config/xournalpp"
echo "Xournalpp uninstalled."
