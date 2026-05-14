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
    "Firefox"*)  source "$BASE_DIR/install/desktop/browser/app-firefox.sh" ;;
    "Chromium"*) source "$BASE_DIR/install/desktop/browser/app-chromium.sh" ;;
    "Brave"*)    source "$BASE_DIR/install/desktop/browser/app-brave.sh" ;;
    "Zen"*)      source "$BASE_DIR/install/desktop/browser/app-zen.sh" ;;
esac
