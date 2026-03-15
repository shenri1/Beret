#!/usr/bin/env zsh
# Uninstall Docker
dnf remove -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "Docker uninstalled."
