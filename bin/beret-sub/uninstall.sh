#!/usr/bin/env zsh

UNINSTALLER=$(gum file $BASE_DIR/uninstall --height 26)
[ -n "$UNINSTALLER" ] && gum confirm "Run uninstaller?" && source $UNINSTALLER && gum spin --spinner globe --title "Uninstall completed!" -- sleep 3
clear
source $BASE_DIR/bin/beret
