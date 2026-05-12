#!/usr/bin/env zsh

BROWSER=$(gum choose \
    "Firefox     (Mozilla's open-source browser)" \
    "Chromium    (Google's open-source browser)" \
    "Brave       (privacy-focused Chromium fork)" \
    "Zen         (privacy-focused Firefox fork)" \
    "Skip        (don't install a browser now)" \
    --height 8 \
    --header "Choose your default browser:")

[[ -z "$BROWSER" || "$BROWSER" == Skip* ]] && return

case "$BROWSER" in
    "Firefox"*)  source "$BASE_DIR/install/desktop/browser/firefox.sh" ;;
    "Chromium"*) source "$BASE_DIR/install/desktop/browser/chromium.sh" ;;
    "Brave"*)    source "$BASE_DIR/install/desktop/browser/brave.sh" ;;
    "Zen"*)      source "$BASE_DIR/install/desktop/browser/zen.sh" ;;
esac
