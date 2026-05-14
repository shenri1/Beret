#!/usr/bin/env zsh

dnf install -y xournalpp

USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/xournalpp"

if [[ ! -f "$USER_HOME/.config/xournalpp/settings.xml" ]]; then
    cp "$BASE_DIR/config/xournalpp/settings.xml" \
       "$USER_HOME/.config/xournalpp/settings.xml"
    chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/xournalpp/settings.xml"
fi
