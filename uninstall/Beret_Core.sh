#!/usr/bin/env zsh
# Uninstall Beret Core Files
USER_HOME="/home/$SUDO_USER"

rm -f /usr/local/bin/beret
rm -f /usr/local/bin/beret-theme
rm -f /usr/local/bin/fedora-maintenance

rm -rf "$USER_HOME/.local/share/beret"
# We don't remove everything in .config as it might contain user's other stuff, but we can remove beret-related ones if they are specific.
# Most apps have their own uninstaller that cleans their config.
echo "Beret core files removed."
