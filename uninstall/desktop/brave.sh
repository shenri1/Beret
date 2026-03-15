#!/usr/bin/env zsh
# Uninstall Brave Browser
dnf remove -y brave-browser
rm -f /etc/yum.repos.d/brave-browser.repo
echo "Brave uninstalled."
