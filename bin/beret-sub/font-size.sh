#!/usr/bin/env zsh

choice=$(gum choose {7..14} "<< Back" --height 11 --header "Choose your terminal fontsize.")

if [[ $choice =~ ^[0-9] ]]; then
    sed -i "s/^size = .*$/size = $choice/g" ~/.config/alacritty/font-size.toml
    local vs_settings="$HOME/.config/Code/User/settings.json"
    if [[ -f "$vs_settings" ]]; then
        sed -i "s/\"editor.fontSize\": [0-9]*/\"editor.fontSize\": $choice/g" "$vs_settings"
        sed -i "s/\"terminal.integrated.fontSize\": [0-9]*/\"terminal.integrated.fontSize\": $choice/g" "$vs_settings"
    fi
    source $BASE_DIR/bin/beret-sub/font.sh
else
	source $BASE_DIR/bin/beret-sub/font.sh
fi
