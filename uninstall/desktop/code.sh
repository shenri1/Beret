#!/usr/bin/env zsh
# Uninstall VS Code
dnf remove -y code
rm -f /etc/yum.repos.d/vscode.repo
USER_HOME="/home/$SUDO_USER"
rm -rf "$USER_HOME/.config/Code"
rm -rf "$USER_HOME/.vscode"
echo "VS Code uninstalled."
