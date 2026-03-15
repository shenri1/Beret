#!/usr/bin/env zsh

CHOICES=(
    "Beret        Update Beret itself"
    "Ollama        Run LLMs, like Meta's Llama3, locally"
    "LazyGit       TUI for Git"
    "LazyDocker    TUI for Docker"
    "Neovim        Text editor that runs in the terminal"
    "Zellij        Adds panes, tabs, and sessions to the terminal"
    "<< Back       "
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 10 --header "Update manually-managed applications")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
    echo ""
else
    INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

    case "$INSTALLER" in
    "beret")
        cd "$HOME/.local/share/beret" && git pull && cd -
        ;;
    "ollama")
        source "$BASE_DIR/install/terminal/optional/app-ollama.sh"
        ;;
    *)
        source "$BASE_DIR/install/terminal/app-$INSTALLER.sh"
        ;;
    esac

    gum spin --spinner globe --title "Update completed!" -- sleep 3
fi

clear
source $BASE_DIR/bin/beret
