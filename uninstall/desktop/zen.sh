#!/usr/bin/env zsh
# Uninstall Zen Browser
flatpak remove -y io.github.zen_browser.zen 2>/dev/null || true
echo "Zen Browser uninstalled."
