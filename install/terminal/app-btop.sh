#!/usr/bin/env zsh

dnf install -y btop

USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/btop/themes"
cp "$BASE_DIR/config/btop.conf" "$USER_HOME/.config/btop/btop.conf"
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/btop"
