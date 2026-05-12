#!/usr/bin/env zsh

set_font(){
    local font_name=$1
    local url=$2
    local file_type=$3
    local file_name="${font_name/ Nerd Font/}"

    if ! $(fc-list | grep -i "${font_name}" > /dev/null); then
        cd /tmp
        wget -O "$file_name.zip" "$url"
        unzip "$file_name.zip" -d "$file_name"
        cp "$file_name"/*."$file_type" ~/.local/share/fonts/
        rm -rf "$file_name.zip" "$file_name"
        fc-cache
        cd -
        clear
        source $BASE_DIR/ascii.sh
    fi


    cp "$BASE_DIR/config/alacritty/fonts/$file_name.toml" ~/.config/alacritty/font.toml
    local vs_settings="$HOME/.config/Code/User/settings.json"
    if [[ -f "$vs_settings" ]]; then
        sed -i "s/\"editor.fontFamily\": \".*\"/\"editor.fontFamily\": \"$font_name\"/g" "$vs_settings"
        sed -i "s/\"terminal.integrated.fontFamily\": \".*\"/\"terminal.integrated.fontFamily\": \"$font_name\"/g" "$vs_settings"
    fi
}

if [ "$#" -ge 1 ]; then
	choice="$1"
else
	choice=$(gum choose "Cascadia Mono" "Fira Mono" "JetBrains Mono" "Meslo" "> Change size" "<< Back" --height 8 --header "Choose your programming font")
fi


case $choice in
"Cascadia Mono")
	set_font "CaskaydiaMono Nerd Font" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip" "ttf"
	;;
"Fira Mono")
	set_font "FiraMono Nerd Font" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraMono.zip" "otf"
	;;
"JetBrains Mono")
	set_font "JetBrainsMono Nerd Font" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" "ttf"
	;;
"Meslo")
	set_font "MesloLGS Nerd Font" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip" "ttf"
	;;
"> Change size")
	source $BASE_DIR/bin/beret-sub/font-size.sh
	exit
	;;
esac

source $BASE_DIR/bin/beret-sub/menu.sh
