#!/usr/bin/env zsh

source "$BASE_DIR/bin/beret-sub/dialog-helpers.sh"

BERET_USER_NAME=$(beret_dialog_input "Type your full name" "")
BERET_USER_EMAIL=$(beret_dialog_input "Type your email address" "")

export BERET_USER_NAME
export BERET_USER_EMAIL
