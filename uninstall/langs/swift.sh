#!/usr/bin/env zsh
# Uninstall Swift
USER_HOME="/home/$SUDO_USER"

if [ -d "$USER_HOME/.local/share/swiftly" ]; then
    rm -rf "$USER_HOME/.local/share/swiftly"
    sed -i '/swiftly\/env.sh/d' "$USER_HOME/.zshrc"
    echo "Swift uninstalled."
else
    echo "Swift not found."
fi
