#!/usr/bin/env zsh

dnf install -y xournalpp

USER_HOME="/home/$SUDO_USER"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/xournalpp"

if [[ ! -f "$USER_HOME/.config/xournalpp/settings.xml" ]]; then
  cp "$USER_HOME/.local/share/beret/config/xournalpp/settings.xml" \
     "$USER_HOME/.config/xournalpp/settings.xml"
  chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/xournalpp/settings.xml"
fi
