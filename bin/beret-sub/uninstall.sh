#!/usr/bin/env zsh

UNINSTALLER=$(gum file $BASE_DIR/uninstall --height 26)

if [[ -n "$UNINSTALLER" && -f "$UNINSTALLER" ]]; then
    if gum confirm "Run uninstaller: $(basename $UNINSTALLER)?"; then
        source $UNINSTALLER
        gum spin --spinner globe --title "Uninstall completed!" -- sleep 3
    fi
elif [[ -n "$UNINSTALLER" && -d "$UNINSTALLER" ]]; then
    echo "Please select a script file, not a directory."
    sleep 2
fi

clear
source $BASE_DIR/bin/beret
