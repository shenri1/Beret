#!/usr/bin/env zsh

source "$BASE_DIR/bin/beret-sub/dialog-helpers.sh"

THEME_NAMES=("Tokyo Night" "Catppuccin" "Nordic" "Gruvbox" "Rose Pine" "Materia Black" "Osaka Jade" "Kanagawa" "Custom (Aether)")
THEME=$(beret_dialog_menu_from_gum "Choose your theme" "${THEME_NAMES[@]}" "<< Back" "Return to menu")

[[ -z "$THEME" || "$THEME" == "<<"* ]] && return

case "$THEME" in
  "Tokyo Night")     THEME="tokyo-night" ;;
  "Rose Pine")       THEME="rose-pine" ;;
  "Materia Black")   THEME="materia-black" ;;
  "Osaka Jade")      THEME="osaka-jade" ;;
  "Custom (Aether)") THEME="custom" ;;
  *)                 THEME=$(echo "$THEME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-') ;;
esac

if [[ "$THEME" == "custom" ]]; then
  beret aether
else
  beret-theme "$THEME"
fi
