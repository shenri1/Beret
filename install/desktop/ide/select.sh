#!/usr/bin/env zsh

clear
source "$BASE_DIR/ascii.sh"
echo ""

IDE=$(gum choose \
    "Zed         (recommended — fast, native code editor)" \
    "Cursor      (AI-first VS Code fork)" \
    "Antigravity (AI-native editor)" \
    "VS Code     (Microsoft's popular editor)" \
    "Skip        (don't install an IDE now)" \
    --height 9 \
    --header "Choose your code editor:")

[[ -z "$IDE" || "$IDE" == Skip* ]] && return

case "$IDE" in
    "Zed"*)         source "$BASE_DIR/install/desktop/ide/zed.sh" ;;
    "Cursor"*)      source "$BASE_DIR/install/desktop/ide/cursor.sh" ;;
    "Antigravity"*) source "$BASE_DIR/install/desktop/ide/antigravity.sh" ;;
    "VS Code"*)     source "$BASE_DIR/install/desktop/ide/vscode.sh" ;;
esac
