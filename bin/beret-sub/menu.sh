#!/usr/bin/env zsh

source "$BASE_DIR/bin/beret-sub/dialog-helpers.sh"

if [ $# -eq 0 ]; then
	SUB=$(beret_dialog_menu_from_gum "Beret — What would you like to do?" \
		"Install      Install individual components" \
		"Uninstall    Remove individual components" \
		"Theme        Switch theme" \
		"Font         Change terminal font" \
		"Font-Size    Set terminal font size" \
		"Update       Update applications" \
		"Quit" "" \
		| awk '{print $1}' | tr '[:upper:]' '[:lower:]')
else
	SUB="$1"
fi

if [[ -z "$SUB" || "$SUB" == "quit" ]]; then
	exit 0
fi

source "$BASE_DIR/bin/beret" "$SUB"
