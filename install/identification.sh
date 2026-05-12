#!/usr/bin/env zsh

clear

BERET_USER_NAME=$(gum input \
  --placeholder "Your name" \
  --prompt "Name > " \
  --header "Identification for Git and autocomplete")

BERET_USER_EMAIL=$(gum input \
  --placeholder "your@email.com" \
  --prompt "Email > " \
  --header "Identification for Git and autocomplete")

export BERET_USER_NAME
export BERET_USER_EMAIL
