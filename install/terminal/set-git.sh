#!/usr/bin/env zsh

USER_HOME="/home/$SUDO_USER"

sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/share/applications"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/share/beret"

cp -R "$BASE_DIR/config/"* "$USER_HOME/.config/" 2>/dev/null || true
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config"

<<<<<<< HEAD
cp -R "$BASE_DIR/default" "$USER_HOME/.local/share/beret/"
cp -R "$BASE_DIR/themes"  "$USER_HOME/.local/share/beret/"
cp -R "$BASE_DIR/bin"     "$USER_HOME/.local/share/beret/"
chmod +x "$USER_HOME/.local/share/beret/default/zsh/"*
chmod +x "$USER_HOME/.local/share/beret/default/bash/"* 2>/dev/null || true
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.local/share/beret"
=======
cp -R "$BASE_DIR/default" "$USER_HOME/.local/share/berret/"
cp -R "$BASE_DIR/themes"  "$USER_HOME/.local/share/berret/"
cp -R "$BASE_DIR/bin"     "$USER_HOME/.local/share/berret/"
chmod +x "$USER_HOME/.local/share/berret/default/zsh/"*
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.local/share/berret"
>>>>>>> 2c65214 (Changes bash to zsh in scripts)

# Install beret-theme and maintenance script to system PATH
install -m 755 "$BASE_DIR/bin/beret-theme" /usr/local/bin/beret-theme
install -m 755 "$BASE_DIR/bin/fedora-maintenance" /usr/local/bin/fedora-maintenance

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

sudo -u "$SUDO_USER" tee "$USER_HOME/.XCompose" > /dev/null << XCOMPOSE
include "%H/.local/share/beret/default/xcompose"

# Identification
<Multi_key> <space> <n> : "$BERRET_USER_NAME"
<Multi_key> <space> <e> : "$BERRET_USER_EMAIL"
XCOMPOSE

clear
