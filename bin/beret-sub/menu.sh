#!/usr/bin/env zsh

if [ $# -eq 0 ]; then
	SUB=$(gum choose \
		"Install      Install individual components" \
		"Uninstall    Remove individual components" \
		"Theme        Switch theme" \
		"Font         Change terminal font" \
		"Font-Size    Set terminal font size" \
		"Update       Update applications" \
		"Quit" \
		--height 12 --header "Beret — What would you like to do?" \
		| awk '{print $1}' | tr '[:upper:]' '[:lower:]')
else
	SUB="$1"
fi

if [[ -z "$SUB" || "$SUB" == "quit" ]]; then
	exit 0
fi

source "$BASE_DIR/bin/beret" "$SUB"
