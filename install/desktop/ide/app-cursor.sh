#!/usr/bin/env zsh

echo "Installing Cursor..."

USER_HOME="/home/$SUDO_USER"

CURSOR_LATEST=$(curl -s "https://api.github.com/repos/getcursor/cursor/releases/latest" \
    | grep -Po '"tag_name": "\K[^"]*' | head -1)

cd /tmp
curl -sLo cursor.AppImage \
    "https://downloader.cursor.sh/linux/appImage/x64" \
    || { echo "⚠ Could not download Cursor."; return 1; }

chmod +x cursor.AppImage
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/bin"
mv cursor.AppImage "$USER_HOME/.local/bin/cursor"
chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.local/bin/cursor"

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

cd -
echo "✓ Cursor installed."
