#!/usr/bin/env zsh

THEME_NAMES=("Tokyo Night" "Catppuccin" "Nordic" "Gruvbox" "Rose Pine" "Materia Black" "Osaka Jade" "Kanagawa")
THEME=$(gum choose "${THEME_NAMES[@]}" "<< Back" --header "Choose your theme" --height 12 | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

if [ -n "$THEME" ] && [ "$THEME" != "<<-back" ]; then
  beret-theme "$THEME"
fi

source $BASE_DIR/bin/beret-sub/menu.sh
