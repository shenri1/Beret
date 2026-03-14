#!/usr/bin/env zsh

THEME_NAMES=("Tokyo Night" "Catppuccin" "Nord" "Gruvbox" "Rose Pine" "Matte Black" "Osaka Jade")
THEME=$(gum choose "${THEME_NAMES[@]}" "<< Back" --header "Choose your theme" --height 12 | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

if [ -n "$THEME" ] && [ "$THEME" != "<<-back" ]; then
  cp $BASE_DIR/themes/$THEME/alacritty.toml ~/.config/alacritty/theme.toml
  cp $BASE_DIR/themes/$THEME/zellij.kdl ~/.config/zellij/themes/$THEME.kdl
  sed -i "s/theme \".*\"/theme \"$THEME\"/g" ~/.config/zellij/config.kdl
  if [ -d "$HOME/.config/nvim" ]; then
    cp $BASE_DIR/themes/$THEME/neovim.lua ~/.config/nvim/lua/plugins/theme.lua
  fi

  if [ -f "$BASE_DIR/themes/$THEME/btop.theme" ]; then
    cp $BASE_DIR/themes/$THEME/btop.theme ~/.config/btop/themes/$THEME.theme
    sed -i "s/color_theme = \".*\"/color_theme = \"$THEME\"/g" ~/.config/btop/btop.conf
  else
    sed -i "s/color_theme = \".*\"/color_theme = \"Default\"/g" ~/.config/btop/btop.conf
  fi

  source $BASE_DIR/themes/$THEME/vscode.sh

fi

source $BASE_DIR/bin/beret-sub/menu.sh
