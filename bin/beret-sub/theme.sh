#!/usr/bin/env zsh

source "$BASE_DIR/bin/beret-sub/dialog-helpers.sh"

THEME_NAMES=("Tokyo Night" "Catppuccin" "Nordic" "Gruvbox" "Rose Pine" "Materia Black" "Osaka Jade" "Kanagawa" "Custom (Aether)")
THEME=$(beret_dialog_menu_from_gum "Choose your theme" "${THEME_NAMES[@]}" "<< Back" "Return to menu")

[[ -z "$THEME" || "$THEME" == "<<"* ]] && return

THEME="${THEME//-(aether)/}"

if [[ "$THEME" == "custom" ]]; then
  beret aether
else
  beret-theme "$THEME"
fi
