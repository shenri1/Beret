#!/usr/bin/env zsh

flatpak install -y flathub io.ulauncher.ulauncher

sudo -u "$SUDO_USER" zsh -c '
  mkdir -p ~/.config/autostart/
  cp ~/.local/share/beret/config/ulauncher/ulauncher.desktop ~/.config/autostart/ulauncher.desktop
  gtk-launch ulauncher.desktop >/dev/null 2>&1
  sleep 2
  cp ~/.local/share/beret/config/ulauncher/settings.json ~/.config/ulauncher/settings.json
'
