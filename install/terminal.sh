#!/usr/bin/env zsh

dnf install -y curl git unzip wget fd-find fzf bat whois ripgrep zoxide

# Run shell setup first so .zshrc is properly configured before anything appends to it
source "$BASE_DIR/install/terminal/a-shell.sh"

for installer in "$BASE_DIR/install/terminal/required/"*.sh; do
    local installer
    [[ -f "$installer" ]] || continue
    source "$installer"
done

# Ask user which languages to install
source "$BASE_DIR/install/terminal/langs/select.sh"

# Git config, dev libraries, and app configs
source "$BASE_DIR/install/terminal/set-git.sh"
source "$BASE_DIR/install/terminal/setting.sh"
source "$BASE_DIR/install/terminal/libraries.sh"
source "$BASE_DIR/install/terminal/apps-terminal.sh"

# Ask user which dev services to install (Docker, PostgreSQL, etc.)
source "$BASE_DIR/install/terminal/dev-services.sh"

# Run remaining terminal app installers
for installer in "$BASE_DIR/install/terminal/"*.sh; do
    local installer
    [[ -f "$installer" ]] || continue
    case "$installer" in
        */a-shell.sh)       continue ;;
        */setting.sh)       continue ;;
        */set-git.sh)       continue ;;
        */libraries.sh)     continue ;;
        */apps-terminal.sh) continue ;;
        */docker.sh)        continue ;;
        */dev-services.sh)  continue ;;
    esac
    source "$installer" || echo "⚠ Warning: $installer exited with error, continuing..."
done
