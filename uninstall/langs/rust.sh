#!/usr/bin/env zsh
# Uninstall Rust
USER_HOME="/home/$SUDO_USER"

if [ -d "$USER_HOME/.rustup" ]; then
    sudo -u "$SUDO_USER" "$USER_HOME/.cargo/bin/rustup" self uninstall -y 2>/dev/null || \
        rm -rf "$USER_HOME/.rustup" "$USER_HOME/.cargo"
    sed -i '/.cargo\/env/d' "$USER_HOME/.zshrc"
    echo "Rust uninstalled."
else
    echo "Rust not found."
fi
