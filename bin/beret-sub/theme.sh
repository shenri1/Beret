#!/usr/bin/env zsh

THEME_NAMES=("Tokyo Night" "Catppuccin" "Nordic" "Gruvbox" "Rose Pine" "Materia Black" "Osaka Jade" "Kanagawa" "Custom (Aether)")
THEME=$(gum choose "${THEME_NAMES[@]}" "<< Back" --header "Choose your theme" --height 12 | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

# Normalize "custom-(aether)" -> "custom"
THEME="${THEME//-(aether)/}"

if [ -n "$THEME" ] && [ "$THEME" != "<<-back" ]; then
  if [[ "$THEME" == "custom" ]]; then
    beret aether
  else
    beret-theme "$THEME"
  fi
fi

source $BASE_DIR/bin/beret-sub/menu.sh
