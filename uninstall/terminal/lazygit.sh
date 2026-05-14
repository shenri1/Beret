#!/usr/bin/env zsh
# Uninstall lazygit
rm -f /usr/local/bin/lazygit
USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
rm -rf "$USER_HOME/.config/lazygit"
echo "lazygit uninstalled."
