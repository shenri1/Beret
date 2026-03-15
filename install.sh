#!/usr/bin/env zsh
set -e

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
export BASE_DIR

if ! command -v zsh &>/dev/null; then
  dnf install -y zsh
fi

if [[ -z "$BERET_ZSH" ]]; then
  export BERET_ZSH=1
  exec zsh "$0" "$@"
fi

LOG_FILE="/tmp/beret-install.log"
exec > >(tee -a "$LOG_FILE") 2>&1

source "$BASE_DIR/install/check-version.sh"
source "$BASE_DIR/install/terminal/required/gum-install.sh" >/dev/null
source "$BASE_DIR/install/identification.sh"
source "$BASE_DIR/install/optimizations.sh"
source "$BASE_DIR/install/debloat.sh"
source "$BASE_DIR/install/fonts.sh"

if [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]]; then
    kwriteconfig6 --file kscreenlockerrc --group Daemon --key Autolock false
    echo "Installing terminal and desktop tools..."
    source "$BASE_DIR/install/terminal.sh"
    source "$BASE_DIR/install/desktop.sh"
    kwriteconfig6 --file kscreenlockerrc --group Daemon --key Autolock true
else
    echo "Only installing terminal tools..."
    source "$BASE_DIR/install/terminal.sh"
fi

echo ""
echo "═══════════════════════════════════════════"
echo " Beret install — completed successfully ✓"
echo " $(date '+%Y-%m-%d %H:%M:%S')"
echo "═══════════════════════════════════════════"
echo ""
