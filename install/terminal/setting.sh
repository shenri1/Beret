#!/usr/bin/env zsh
USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"

sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/share/applications"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/share/beret"

cp -R "$BASE_DIR/config/"* "$USER_HOME/.config/" 2>/dev/null || true
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/alacritty" 2>/dev/null || true
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/btop"      2>/dev/null || true
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/fastfetch" 2>/dev/null || true
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/zellij"    2>/dev/null || true
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/nvim"      2>/dev/null || true
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/xournalpp" 2>/dev/null || true

cp -R "$BASE_DIR/default"   "$USER_HOME/.local/share/beret/"
cp -R "$BASE_DIR/themes"    "$USER_HOME/.local/share/beret/"
cp -R "$BASE_DIR/bin"       "$USER_HOME/.local/share/beret/"
cp -R "$BASE_DIR/install"   "$USER_HOME/.local/share/beret/"
cp -R "$BASE_DIR/uninstall" "$USER_HOME/.local/share/beret/"
cp "$BASE_DIR/ascii.sh"     "$USER_HOME/.local/share/beret/"
cp "$BASE_DIR/version"      "$USER_HOME/.local/share/beret/"
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.local/share/beret"

# Install beret-theme and maintenance script to system PATH
install -m 755 "$BASE_DIR/bin/beret-theme" /usr/local/bin/beret-theme
install -m 755 "$BASE_DIR/bin/fedora-maintenance" /usr/local/bin/fedora-maintenance
install -m 755 "$BASE_DIR/bin/beret" /usr/local/bin/beret
install -m 755 "$BASE_DIR/bin/beret-aether-bridge" /usr/local/bin/beret-aether-bridge
