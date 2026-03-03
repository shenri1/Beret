#!/usr/bin/env bash

# Configure identification
echo -e "\nEnter identification for git and autocomplete..."
SYSTEM_NAME=$(getent passwd "$USER" | cut -d ':' -f 5 | cut -d ',' -f 1)
export BERRET_USER_NAME=$(gum input --placeholder "Enter full name" --value "$SYSTEM_NAME" --prompt "Name> ")
export BERRET_USER_EMAIL=$(gum input --placeholder "Enter email address" --prompt "Email> ")
