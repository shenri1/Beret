#!/usr/bin/env zsh

echo "Installing Aether..."

dnf install -y gjs gtk4 libadwaita ImageMagick libsoup3

USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
AETHER_DIR="$USER_HOME/.local/share/aether"

if [[ ! -d "$AETHER_DIR" ]]; then
  sudo -u "$SUDO_USER" git clone https://github.com/bjarneo/aether.git "$AETHER_DIR"
fi

chown -R "$SUDO_USER:$SUDO_USER" "$AETHER_DIR"
echo "✓ Aether installed at $AETHER_DIR"
echo "  Run with: $AETHER_DIR/aether"
