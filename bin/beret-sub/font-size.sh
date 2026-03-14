#!/usr/bin/env zsh

choice=$(gum choose {7..14} "<< Back" --height 11 --header "Choose your terminal fontsize.")

if [[ $choice =~ ^[0-9] ]]; then
    sed -i "s/^size = .*$/size = $choice/g" ~/.config/alacritty/font-size.toml
	source $BASE_DIR/bin/beret-sub/font-size.sh
else
	source $BASE_DIR/bin/beret-sub/font.sh
fi
