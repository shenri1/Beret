#!/usr/bin/env zsh
# Uninstall Xournalpp
dnf remove -y xournalpp
USER_HOME="/home/$SUDO_USER"
rm -rf "$USER_HOME/.config/xournalpp"
echo "Xournalpp uninstalled."
