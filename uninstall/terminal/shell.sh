#!/usr/bin/env zsh
# Uninstall Shell configuration (Zsh)
USER_HOME="/home/$SUDO_USER"

# Restore backups if they exist
[ -f "$USER_HOME/.zshrc.bak" ] && mv "$USER_HOME/.zshrc.bak" "$USER_HOME/.zshrc"
[ -f "$USER_HOME/.inputrc.bak" ] && mv "$USER_HOME/.inputrc.bak" "$USER_HOME/.inputrc"

# Remove Oh My Zsh
rm -rf "$USER_HOME/.oh-my-zsh"

# Note: We don't change the shell back to bash automatically to avoid locking the user out if bash is somehow missing (unlikely but safer)
echo "Shell configuration partially reverted. Please change your shell back to bash if desired using 'chsh -s /bin/bash'."
