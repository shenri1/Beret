#!/usr/bin/env zsh

source "$BASE_DIR/bin/beret-sub/dialog-helpers.sh"

BROWSER=$(beret_dialog_menu_from_gum "Choose your default browser:" \
    "Firefox     Mozilla's open-source browser" \
    "Chromium    Google's open-source browser" \
    "Brave       Privacy-focused Chromium fork" \
    "Zen         Privacy-focused Firefox fork" \
    "Skip        Don't install a browser now")

[[ -z "$BROWSER" || "$BROWSER" == Skip* ]] && return

case "$BROWSER" in
    "Firefox"*)  source "$BASE_DIR/install/desktop/browser/firefox.sh" ;;
    "Chromium"*) source "$BASE_DIR/install/desktop/browser/chromium.sh" ;;
    "Brave"*)    source "$BASE_DIR/install/desktop/browser/brave.sh" ;;
    "Zen"*)      source "$BASE_DIR/install/desktop/browser/zen.sh" ;;
esac
