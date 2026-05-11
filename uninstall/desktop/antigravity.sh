#!/usr/bin/env zsh
# Uninstall Antigravity
dnf remove -y antigravity 2>/dev/null || true
rm -f /etc/yum.repos.d/antigravity.repo
echo "Antigravity uninstalled."
