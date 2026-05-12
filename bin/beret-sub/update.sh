#!/usr/bin/env zsh

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
    "<< Back       "
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 15 --header "Update manually-managed applications")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
    echo ""
else
    INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

    case "$INSTALLER" in
    "beret")
        cd "$HOME/.local/share/beret" && git pull && cd -
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
        source "$BASE_DIR/install/desktop/browser/zen.sh"
        ;;
    "brave")
        source "$BASE_DIR/install/desktop/browser/brave.sh"
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

    gum spin --spinner globe --title "Update completed!" -- sleep 3
fi

clear
source $BASE_DIR/bin/beret
