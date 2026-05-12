#!/usr/bin/env zsh

source "$BASE_DIR/bin/beret-sub/dialog-helpers.sh"

choice=$(beret_dialog_menu_from_gum "Choose your terminal fontsize." \
    "7" "" "8" "" "9" "" "10" "" "11" "" "12" "" "13" "" "14" "" \
    "<< Back" "Return to menu")

if [[ $choice =~ ^[0-9] ]]; then
    sed -i "s/^size = .*$/size = $choice/g" ~/.config/alacritty/font-size.toml
    vs_settings="$HOME/.config/Code/User/settings.json"
    if [[ -f "$vs_settings" ]]; then
        sed -i "s/\"editor.fontSize\": [0-9]*/\"editor.fontSize\": $choice/g" "$vs_settings"
        sed -i "s/\"terminal.integrated.fontSize\": [0-9]*/\"terminal.integrated.fontSize\": $choice/g" "$vs_settings"
    fi
    source "$BASE_DIR/bin/beret-sub/font.sh"
else
	source "$BASE_DIR/bin/beret-sub/font.sh"
fi
