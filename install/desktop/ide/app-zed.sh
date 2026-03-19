#!/usr/bin/env zsh

echo "Installing Zed Editor..."
sudo -u "$SUDO_USER" zsh -c '
    curl -f https://zed.dev/install.sh | sh
' || { echo "⚠ Zed install script failed."; return 1; }
echo "✓ Zed installed."
