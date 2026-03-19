#!/usr/bin/env zsh

flatpak install -y flathub io.ulauncher.ulauncher

sudo -u "$SUDO_USER" zsh -c "
  mkdir -p \"\$HOME/.config/autostart/\"
  cp \"$BASE_DIR/config/ulauncher/ulauncher.desktop\" \"\$HOME/.config/autostart/ulauncher.desktop\"
  gtk-launch ulauncher.desktop >/dev/null 2>&1
  sleep 2
  cp \"$BASE_DIR/config/ulauncher/settings.json\" \"\$HOME/.config/ulauncher/settings.json\"
" || true
