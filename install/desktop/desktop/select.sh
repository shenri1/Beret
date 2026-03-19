#!/usr/bin/env zsh

clear
source "$BASE_DIR/ascii.sh"
echo ""

BROWSER=$(gum choose \
    "Zen Browser   (recommended — privacy-focused Firefox fork)" \
    "Brave         (Chromium-based, ad-blocking built-in)" \
    "Chromium      (open-source Chrome)" \
    "Firefox       (Mozilla's classic browser)" \
    "Skip          (don't install a browser now)" \
    --height 9 \
    --header "Choose your browser:")

[[ -z "$BROWSER" || "$BROWSER" == Skip* ]] && return

case "$BROWSER" in
    "Zen Browser"*)  source "$BASE_DIR/install/desktop/browser/zen.sh" ;;
    "Brave"*)        source "$BASE_DIR/install/desktop/browser/brave.sh" ;;
    "Chromium"*)     source "$BASE_DIR/install/desktop/browser/chromium.sh" ;;
    "Firefox"*)      source "$BASE_DIR/install/desktop/browser/firefox.sh" ;;
esac
