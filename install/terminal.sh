#!/usr/bin/env zsh

dnf install -y curl git unzip wget fd-find fzf bat whois ripgrep zoxide

# Run shell setup first so .zshrc is properly configured before anything appends to it
source "$BASE_DIR/install/terminal/a-shell.sh"

for installer in "$BASE_DIR/install/terminal/required/"*.sh; do
    [[ -f "$installer" ]] || continue
    source "$installer"
done

# Ask user which languages to install
source "$BASE_DIR/install/terminal/langs/select.sh"

# Run remaining terminal scripts (excluding a-shell.sh and the langs/ subfolder)
for installer in "$BASE_DIR/install/terminal/"*.sh; do
    [[ -f "$installer" ]] || continue
    [[ "$installer" == *"/a-shell.sh" ]] && continue
    source "$installer" || echo "⚠ Warning: $installer exited with error, continuing..."
done
