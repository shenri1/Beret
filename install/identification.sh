#!/usr/bin/env zsh

clear

BERET_USER_NAME=$(gum input \
  --placeholder "Type your full name" \
  --prompt "Name > " \
  --header "Identification for Git and autocomplete" \
  --width 40)

BERET_USER_EMAIL=$(gum input \
  --placeholder "your@email.com" \
  --prompt "Email > " \
  --header "Identification for Git and autocomplete" \
  --width 40)

export BERET_USER_NAME
export BERET_USER_EMAIL
