#!/usr/bin/env zsh
# Uninstall Opencode
USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
rm -f /usr/local/bin/opencode
rm -rf "$USER_HOME/.opencode"
sed -i '/\/usr\/local\/bin\/opencode/d' "$USER_HOME/.zshrc" 2>/dev/null || true
echo "Opencode uninstalled."
