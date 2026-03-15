#!/usr/bin/env zsh
# Uninstall Programming Languages

USER_HOME="/home/$SUDO_USER"

# Rust
if [ -d "$USER_HOME/.rustup" ]; then
    sudo -u "$SUDO_USER" "$USER_HOME/.cargo/bin/rustup" self uninstall -y
    echo "Rust uninstalled."
fi

# Go
if [ -d "$USER_HOME/.local/share/go" ]; then
    rm -rf "$USER_HOME/.local/share/go"
    echo "Go uninstalled."
fi

# Python
dnf remove -y python3 python3-pip python3-devel
echo "Python uninstalled."

# Clang
dnf remove -y clang clang-tools-extra cmake
echo "Clang/C++ uninstalled."

# Java
dnf remove -y java-latest-openjdk java-latest-openjdk-devel
echo "Java uninstalled."

# Lua
dnf remove -y lua lua-devel
echo "Lua uninstalled."

# Swift
if [ -d "$USER_HOME/.local/share/swiftly" ]; then
    rm -rf "$USER_HOME/.local/share/swiftly"
    echo "Swift uninstalled."
fi

echo "Cleaning up language paths from .zshrc..."
sed -i '/.cargo\/env/d' "$USER_HOME/.zshrc"
sed -i '/go\/root\/bin/d' "$USER_HOME/.zshrc"
sed -i '/GOPATH/d' "$USER_HOME/.zshrc"
sed -i '/swiftly\/env.sh/d' "$USER_HOME/.zshrc"
