#!/usr/bin/env zsh
USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"

sudo -u "$SUDO_USER" git config --global init.defaultBranch main
sudo -u "$SUDO_USER" git config --global alias.co checkout
sudo -u "$SUDO_USER" git config --global alias.br branch
sudo -u "$SUDO_USER" git config --global alias.ci commit
sudo -u "$SUDO_USER" git config --global alias.st status
sudo -u "$SUDO_USER" git config --global pull.rebase true

if [[ -n "${BERET_USER_NAME//[[:space:]]/}" ]]; then
  sudo -u "$SUDO_USER" git config --global user.name "$BERET_USER_NAME"
fi

if [[ -n "${BERET_USER_EMAIL//[[:space:]]/}" ]]; then
  sudo -u "$SUDO_USER" git config --global user.email "$BERET_USER_EMAIL"
fi

sudo -u "$SUDO_USER" tee "$USER_HOME/.XCompose" > /dev/null << XCOMPOSE
include "%H/.local/share/beret/default/xcompose"

# Identification
<Multi_key> <space> <n> : "$BERET_USER_NAME"
<Multi_key> <space> <e> : "$BERET_USER_EMAIL"
XCOMPOSE

clear
