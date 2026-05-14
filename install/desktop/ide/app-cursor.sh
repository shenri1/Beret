#!/usr/bin/env zsh

echo "Installing Cursor..."

USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/beret-cursor.XXXXXXXXXX")" || return 1
curl --proto '=https' --tlsv1.2 --fail --show-error --location \
    --output "$tmp_dir/cursor.AppImage" \
    "https://downloader.cursor.sh/linux/appImage/x64" \
    || { echo "⚠ Could not download Cursor."; return 1; }

chmod +x "$tmp_dir/cursor.AppImage"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/bin"
mv "$tmp_dir/cursor.AppImage" "$USER_HOME/.local/bin/cursor"
chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.local/bin/cursor"
rm -rf "$tmp_dir"

# Add ~/.local/bin to PATH if not already there
sudo -u "$SUDO_USER" zsh -c '
    if ! grep -q "\.local/bin" ~/.zshrc 2>/dev/null; then
        echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> ~/.zshrc
    fi
'

# Create .desktop entry
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/share/applications"
sudo -u "$SUDO_USER" tee "$USER_HOME/.local/share/applications/cursor.desktop" > /dev/null << DESKTOP
[Desktop Entry]
Name=Cursor
Exec=$USER_HOME/.local/bin/cursor --no-sandbox %F
Type=Application
Categories=Development;IDE;TextEditor;
MimeType=text/plain;inode/directory;
DESKTOP

echo "✓ Cursor installed."
