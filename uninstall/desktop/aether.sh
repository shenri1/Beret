#!/usr/bin/env zsh
# Uninstall Aether

USER_HOME="/home/$SUDO_USER"
rm -rf "$USER_HOME/.local/share/aether"
echo "Aether uninstalled."
echo "Note: dependencies (gjs, gtk4, libadwaita, ImageMagick, libsoup3) were NOT removed."
