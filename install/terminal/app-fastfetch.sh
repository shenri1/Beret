#!/usr/bin/env zsh

dnf install -y fastfetch

USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
if [[ ! -f "$USER_HOME/.config/fastfetch/config.jsonc" ]]; then
  sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/fastfetch"
  cp "$BASE_DIR/config/config.jsonc" "$USER_HOME/.config/fastfetch/config.jsonc"
  chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/fastfetch/config.jsonc"
fi
