#!/usr/bin/env zsh

source "$BASE_DIR/bin/beret-sub/dialog-helpers.sh"

CHOICES=(
    "Beret        Update Beret itself"
    "LazyGit       TUI for Git"
    "LazyDocker    TUI for Docker"
    "Neovim        Text editor that runs in the terminal"
    "Zellij        Adds panes, tabs, and sessions to the terminal"
    "Zen Browser   Privacy-focused browser"
    "Brave         Chromium-based browser"
    "Cursor        AI-first code editor"
    "Zed           Fast native code editor"
    "VS Code       Microsoft's code editor"
    "<< Back       Return to menu"
)

CHOICE=$(beret_dialog_menu_from_gum "Update manually-managed applications" "${CHOICES[@]}")

if [[ "$CHOICE" == "<<"* ]] || [[ -z "$CHOICE" ]]; then
    echo ""
else
    INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

    case "$INSTALLER" in
    "beret")
        cd "$HOME/.local/share/beret" && git pull && cd - >/dev/null 2>&1 || true
        ;;
    "lazygit")
        source "$BASE_DIR/install/terminal/app-lazygit.sh"
        ;;
    "lazydocker")
        source "$BASE_DIR/install/terminal/app-lazydocker.sh"
        ;;
    "neovim")
        source "$BASE_DIR/install/terminal/app-neovim.sh"
        ;;
    "zellij")
        source "$BASE_DIR/install/terminal/app-zellij.sh"
        ;;
    "zen-browser")
        source "$BASE_DIR/install/desktop/browser/app-zen.sh"
        ;;
    "brave")
        source "$BASE_DIR/install/desktop/browser/app-brave.sh"
        ;;
    "cursor")
        source "$BASE_DIR/install/desktop/ide/app-cursor.sh"
        ;;
    "zed")
        source "$BASE_DIR/install/desktop/ide/app-zed.sh"
        ;;
    "vs-code")
        source "$BASE_DIR/install/desktop/ide/app-code.sh"
        ;;
    esac

    echo "Update completed!"
    sleep 2
fi

clear
source "$BASE_DIR/bin/beret"
