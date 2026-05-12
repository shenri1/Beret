#!/usr/bin/env zsh

source "$BASE_DIR/bin/beret-sub/dialog-helpers.sh"

IDE=$(beret_dialog_menu_from_gum "Choose your code editor:" \
    "Zed         Fast native code editor" \
    "Cursor      AI-first VS Code fork" \
    "Antigravity AI-native editor" \
    "VS Code     Microsoft's popular editor" \
    "Skip        Don't install an IDE now")

[[ -z "$IDE" || "$IDE" == Skip* ]] && return

case "$IDE" in
    "Zed"*)         source "$BASE_DIR/install/desktop/ide/app-zed.sh" ;;
    "Cursor"*)      source "$BASE_DIR/install/desktop/ide/app-cursor.sh" ;;
    "Antigravity"*) source "$BASE_DIR/install/desktop/ide/app-antigravity.sh" ;;
    "VS Code"*)     source "$BASE_DIR/install/desktop/ide/app-code.sh" ;;
esac
