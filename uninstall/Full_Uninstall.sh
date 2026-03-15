#!/usr/bin/env zsh
# Uninstall All Apps and Configurations (The complete Beret experience)

gum confirm "This will remove ALMOST EVERYTHING installed by Beret. Are you sure?" || return

# Terminal Apps
for script in $BASE_DIR/uninstall/terminal/*.sh; do
    echo "Running $script..."
    source "$script"
done

# Desktop Apps
for script in $BASE_DIR/uninstall/desktop/*.sh; do
    echo "Running $script..."
    source "$script"
done

# Languages
source "$BASE_DIR/uninstall/langs/all.sh"

# Fonts
source "$BASE_DIR/uninstall/Fonts.sh"

# Git and XCompose
source "$BASE_DIR/uninstall/Git_and_XCompose.sh"

# Core Files (Should be last as it removes $BASE_DIR)
source "$BASE_DIR/uninstall/Beret_Core.sh"

echo "Full uninstall complete."
