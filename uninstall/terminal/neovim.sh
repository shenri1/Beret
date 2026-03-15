#!/usr/bin/env zsh
# Uninstall Neovim
rm -f /usr/local/bin/nvim
# Neovim install script copied nvim-linux-x86_64/lib and nvim-linux-x86_64/share to /usr/local/
# This is a bit messy to undo perfectly without a list of files, but we can try to remove known nvim dirs
rm -rf /usr/local/lib/nvim
rm -rf /usr/local/share/nvim
rm -rf /usr/local/share/man/man1/nvim.1

dnf remove -y luarocks tree-sitter-cli
USER_HOME="/home/$SUDO_USER"
rm -rf "$USER_HOME/.config/nvim"
rm -rf "$USER_HOME/.local/share/nvim"
rm -rf "$USER_HOME/.local/state/nvim"
rm -rf "$USER_HOME/.cache/nvim"
echo "Neovim uninstalled."
