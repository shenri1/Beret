#!/usr/bin/env bash

dnf install gum

# Configure identification
echo -e "\nEnter identification for git and autocomplete..."
export BERRET_USER_NAME=$(gum input --placeholder "Enter full name" --prompt "Name> ")
export BERRET_USER_EMAIL=$(gum input --placeholder "Enter email address" --prompt "Email> ")
