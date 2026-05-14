#!/usr/bin/env zsh
# Uninstall Git Global Configs and XCompose
USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
sudo -u "$SUDO_USER" git config --global --unset-all init.defaultBranch
sudo -u "$SUDO_USER" git config --global --unset-all alias.co
sudo -u "$SUDO_USER" git config --global --unset-all alias.br
sudo -u "$SUDO_USER" git config --global --unset-all alias.ci
sudo -u "$SUDO_USER" git config --global --unset-all alias.st
sudo -u "$SUDO_USER" git config --global --unset-all pull.rebase
sudo -u "$SUDO_USER" git config --global --unset-all user.name
sudo -u "$SUDO_USER" git config --global --unset-all user.email

rm -f "$USER_HOME/.XCompose"
echo "Git configs and XCompose removed."
