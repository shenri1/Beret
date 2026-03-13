#!/usr/bin/env zsh

for installer in "$BASE_DIR/install/desktop/"*.sh; do
    source "$installer"
done

gum confirm "Ready to reboot and apply changes? (y/n)" && reboot || true
