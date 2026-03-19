#!/usr/bin/env zsh

echo "Installing Antigravity..."

USER_HOME="/home/$SUDO_USER"

# Antigravity releases from their GitHub
ANTI_LATEST=$(curl -s "https://api.github.com/repos/antigravity-editor/antigravity/releases/latest" \
    | grep -Po '"tag_name": "\K[^"]*' | head -1)

cd /tmp
curl -sLo antigravity.AppImage \
    "https://github.com/antigravity-editor/antigravity/releases/download/${ANTI_LATEST}/Antigravity-x86_64.AppImage" \
    || { echo "⚠ Could not download Antigravity. Check https://antigravity.dev for manual install."; return 1; }

chmod +x antigravity.AppImage
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/bin"
mv antigravity.AppImage "$USER_HOME/.local/bin/antigravity"
chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.local/bin/antigravity"

# Add ~/.local/bin to PATH if not already there
sudo -u "$SUDO_USER" zsh -c '
    if ! grep -q "\.local/bin" ~/.zshrc 2>/dev/null; then
        echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >> ~/.zshrc
    fi
'

# Create .desktop entry
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/share/applications"
sudo -u "$SUDO_USER" tee "$USER_HOME/.local/share/applications/antigravity.desktop" > /dev/null << DESKTOP
[Desktop Entry]
Name=Antigravity
Exec=$USER_HOME/.local/bin/antigravity --no-sandbox %F
Type=Application
Categories=Development;IDE;TextEditor;
MimeType=text/plain;inode/directory;
DESKTOP

cd -
echo "✓ Antigravity installed."
