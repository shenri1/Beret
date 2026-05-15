#!/usr/bin/env bash

BASE_DIR="$(cd "$(dirname "$0")" && pwd)"
export BASE_DIR

source "$BASE_DIR/bin/beret-sub/security.sh"
beret_setup_user_context || exit 1

if ! command -v zsh &>/dev/null; then
  dnf install -y zsh
fi

for required_cmd in curl unzip; do
  if ! command -v "$required_cmd" &>/dev/null; then
    dnf install -y "$required_cmd"
  fi
done

if [[ -z "$BERET_ZSH" ]]; then
  export BERET_ZSH=1
  exec zsh "$0" "$@"
fi

LOG_FILE="$(mktemp "${TMPDIR:-/tmp}/beret-install.XXXXXXXX.log")"
echo "Logging install output to $LOG_FILE"
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
