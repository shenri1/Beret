#!/usr/bin/env zsh
# Uninstall VirtualBox
dnf remove -y virtualbox virtualbox-ext-pack
# Not removing the user from group as it might be needed for other things, but usually it's fine
echo "VirtualBox uninstalled."
