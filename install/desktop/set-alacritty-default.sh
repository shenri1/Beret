#!/usr/bin/env zsh

# Set Alacritty as default terminal emulator on Fedora KDE
if command -v gsettings &>/dev/null; then
  sudo -u "$SUDO_USER" gsettings set org.gnome.desktop.default-applications.terminal exec alacritty 2>/dev/null || true
fi

# Create a sane default fallback via xdg-mime
if command -v xdg-mime &>/dev/null; then
  sudo -u "$SUDO_USER" xdg-mime default alacritty.desktop x-scheme-handler/terminal 2>/dev/null || true
fi
