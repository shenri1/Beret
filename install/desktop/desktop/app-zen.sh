#!/usr/bin/env zsh

echo "Installing Zen Browser..."

# Zen Browser releases page for the AppImage / RPM
ZEN_LATEST=$(curl -s "https://api.github.com/repos/zen-browser/desktop/releases/latest" \
    | grep -Po '"tag_name": "\K[^"]*')

cd /tmp
curl -sLo zen-browser.rpm \
    "https://github.com/zen-browser/desktop/releases/download/${ZEN_LATEST}/zen.linux-x86_64.rpm" \
    || { echo "⚠ Zen RPM not found for this release, trying AppImage fallback..."; ZEN_USE_APPIMAGE=1; }

if [[ -z "$ZEN_USE_APPIMAGE" ]]; then
    dnf install -y ./zen-browser.rpm
    rm -f zen-browser.rpm
else
    USER_HOME="/home/$SUDO_USER"
    curl -sLo zen-browser.AppImage \
        "https://github.com/zen-browser/desktop/releases/download/${ZEN_LATEST}/zen-x86_64.AppImage"
    chmod +x zen-browser.AppImage
    sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/bin"
    mv zen-browser.AppImage "$USER_HOME/.local/bin/zen-browser"
    chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.local/bin/zen-browser"

    # Create .desktop entry
    sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/share/applications"
    sudo -u "$SUDO_USER" tee "$USER_HOME/.local/share/applications/zen-browser.desktop" > /dev/null << DESKTOP
[Desktop Entry]
Name=Zen Browser
Exec=$USER_HOME/.local/bin/zen-browser %u
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;
DESKTOP
fi

cd -
echo "✓ Zen Browser installed."
