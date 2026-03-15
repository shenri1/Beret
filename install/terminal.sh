#!/usr/bin/env zsh

dnf install -y curl git unzip wget fd-find fzf bat whois ripgrep zoxide

# Run shell setup first so .zshrc is properly configured before langs/ appends to it
source "$BASE_DIR/install/terminal/a-shell.sh"

for installer in "$BASE_DIR/install/terminal/required/"*.sh; do
    source "$installer"
done

for installer in "$BASE_DIR/install/terminal/langs/"*.sh; do
    source "$installer"
done

for installer in "$BASE_DIR/install/terminal/"*.sh; do
    if [[ "$installer" == *"/a-shell.sh" ]] || [[ ! -f "$installer" ]]; then
        continue
    fi
    source "$installer"
done
