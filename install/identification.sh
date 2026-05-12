#!/usr/bin/env zsh

clear

BERET_USER_NAME=$(gum input \
  --prompt "Name > " \
  --header "Type your full name" \
  --width 40)

BERET_USER_EMAIL=$(gum input \
  --prompt "Email > " \
  --header "your@email.com"  \
  --width 40)

export BERET_USER_NAME
export BERET_USER_EMAIL
