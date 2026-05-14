#!/usr/bin/env zsh
# Uninstall Swift
USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"

if [ -d "$USER_HOME/.local/share/swiftly" ]; then
    rm -rf "$USER_HOME/.local/share/swiftly"
    sed -i '/swiftly\/env.sh/d' "$USER_HOME/.zshrc"
    echo "Swift uninstalled."
else
    echo "Swift not found."
fi
