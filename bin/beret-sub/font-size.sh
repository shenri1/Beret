#!/usr/bin/env zsh

source "$BASE_DIR/bin/beret-sub/dialog-helpers.sh"
source "$BASE_DIR/bin/beret-sub/config-helpers.sh"

choice=$(beret_dialog_menu_from_gum "Choose your terminal fontsize." \
    "7" "" "8" "" "9" "" "10" "" "11" "" "12" "" "13" "" "14" "" \
    "<< Back" "Return to menu")

if [[ $choice =~ ^[0-9]+$ ]]; then
    beret_alacritty_set_font_size "$choice"
    beret_vscode_set_setting "editor.fontSize" "$choice"
    beret_vscode_set_setting "terminal.integrated.fontSize" "$choice"
    source "$BASE_DIR/bin/beret-sub/font.sh"
else
    source "$BASE_DIR/bin/beret-sub/font.sh"
fi
