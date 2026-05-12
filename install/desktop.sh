#!/usr/bin/env zsh

source "$BASE_DIR/bin/beret-sub/dialog-helpers.sh"

# Required desktop infrastructure first
source "$BASE_DIR/install/desktop/a-flatpak.sh"
source "$BASE_DIR/install/desktop/fonts.sh"
source "$BASE_DIR/install/desktop/app-alacritty.sh"
source "$BASE_DIR/install/desktop/set-alacritty-default.sh"
source "$BASE_DIR/install/desktop/ulauncher.sh"

# Browser selection
source "$BASE_DIR/install/desktop/browser/select.sh"

# IDE selection
source "$BASE_DIR/install/desktop/ide/select.sh"

# Optional desktop apps
OPTIONAL_APPS=(
    "Discord     Voice, video and text chat"
    "Spotify     Music streaming client"
    "OBS         Screen recording and streaming"
    "Krita       Digital painting application"
    "VirtualBox  Virtual machine manager"
    "Xournalpp   Handwriting and PDF annotation"
)

SELECTED=$(beret_dialog_checklist_from_gum "Select optional apps to install (Enter to skip):" "${OPTIONAL_APPS[@]}")

if [[ -n "$SELECTED" ]]; then
    echo "$SELECTED" | while IFS= read -r line; do
        local line app
        app=$(echo "$line" | awk '{print $1}' | tr '[:upper:]' '[:lower:]')
        case "$app" in
            discord)    source "$BASE_DIR/install/desktop/app-discord.sh" || true ;;
            spotify)    source "$BASE_DIR/install/desktop/app-spotify.sh" || true ;;
            obs)        source "$BASE_DIR/install/desktop/app-obs.sh" || true ;;
            krita)      source "$BASE_DIR/install/desktop/app-krita.sh" || true ;;
            virtualbox) source "$BASE_DIR/install/desktop/app-virtualbox.sh" || true ;;
            xournalpp)  source "$BASE_DIR/install/desktop/app-xournalapp.sh" || true ;;
        esac
    done
fi

beret_dialog_confirm "Ready to reboot and apply changes?" && reboot || true
