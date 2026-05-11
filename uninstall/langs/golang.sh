#!/usr/bin/env zsh
# Uninstall Go
USER_HOME="/home/$SUDO_USER"

if [ -d "$USER_HOME/.local/share/go" ]; then
    rm -rf "$USER_HOME/.local/share/go"
    sed -i '/go\/root\/bin/d' "$USER_HOME/.zshrc"
    sed -i '/GOPATH/d' "$USER_HOME/.zshrc"
    echo "Go uninstalled."
else
    echo "Go not found."
fi
