#!/usr/bin/env bash

USER_HOME="/home/$SUDO_USER"

sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/share/applications"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/share/berret"

cp -R "$BASE_DIR/config/"* "$USER_HOME/.config/" 2>/dev/null || true
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config"

cp -R "$BASE_DIR/default" "$USER_HOME/.local/share/berret/"
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.local/share/berret"

if ! grep -q "source $USER_HOME/.local/share/berret/default/bash/rc" "$USER_HOME/.bashrc"; then
  echo "source $USER_HOME/.local/share/berret/default/bash/rc" >> "$USER_HOME/.bashrc"
fi

sudo -u "$SUDO_USER" git config --global init.defaultBranch main
sudo -u "$SUDO_USER" git config --global alias.co checkout
sudo -u "$SUDO_USER" git config --global alias.br branch
sudo -u "$SUDO_USER" git config --global alias.ci commit
sudo -u "$SUDO_USER" git config --global alias.st status
sudo -u "$SUDO_USER" git config --global pull.rebase true

if [[ -n "${BERRET_USER_NAME//[[:space:]]/}" ]]; then
  sudo -u "$SUDO_USER" git config --global user.name "$BERRET_USER_NAME"
fi

if [[ -n "${BERRET_USER_EMAIL//[[:space:]]/}" ]]; then
  sudo -u "$SUDO_USER" git config --global user.email "$BERRET_USER_EMAIL"
fi

sudo -u "$SUDO_USER" tee "$USER_HOME/.XCompose" >/dev/null <<EOF
include "%H/.local/share/berret/default/xcompose"

# Identification
<Multi_key> <space> <n> : "$BERRET_USER_NAME"
<Multi_key> <space> <e> : "$BERRET_USER_EMAIL"
EOF

clear
