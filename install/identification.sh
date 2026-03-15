#!/usr/bin/env zsh

# Configure identification
echo -e "\nEnter identification for git and autocomplete..."
export BERET_USER_NAME=$(gum input --placeholder "Enter full name" --prompt "Name> ")
export BERET_USER_EMAIL=$(gum input --placeholder "Enter email address" --prompt "Email> ")
