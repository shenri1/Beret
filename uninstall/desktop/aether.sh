#!/usr/bin/env zsh
# Uninstall Aether

USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
rm -rf "$USER_HOME/.local/share/aether"
echo "Aether uninstalled."
echo "Note: dependencies (gjs, gtk4, libadwaita, ImageMagick, libsoup3) were NOT removed."
