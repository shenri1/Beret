#!/usr/bin/env bash

for installer in ~/.local/share/berret/install/desktop/*.sh; do
    source "$installer"
done

gum confirm "Ready to reboot and apply changes? (y/n)" && reboot || true
