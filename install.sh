#!/usr/bin/env bash
set -e

# Output colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

if [ "$EUID" -ne 0 ]; then
  echo -e "${RED}[!] Please run this script as root (sudo ./install.sh).${NC}"
  exit 1
fi

if [ -z "$SUDO_USER" ] || [ "$SUDO_USER" = "root" ]; then
  echo -e "${RED}[!] Run with sudo from your user account, not as root directly.${NC}"
  exit 1
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}>>> Starting Berret Fedora KDE Setup...${NC}"
echo -e "${BLUE}    Installing for user: $SUDO_USER${NC}"

# Only run numbered scripts (e.g. 1-DNF.sh, 2-identification.sh) to avoid
# running leftover unnumbered files (config.sh, debloat.sh, etc.)
for script in "$BASE_DIR"/install/[0-9]*.sh; do
  if [ -f "$script" ]; then
    echo -e "\n${BLUE}>>> $(basename "$script")${NC}"
    source "$script"
  fi
done

# Copy utility scripts to the system
if [ -d "$BASE_DIR/bin" ]; then
  echo -e "\n${BLUE}>>> Installing utility scripts to /usr/local/bin...${NC}"
  cp -r "$BASE_DIR"/bin/* /usr/local/bin/
  chmod +x /usr/local/bin/*
fi

echo -e "\n${GREEN}>>> Setup complete! Please reboot your system.${NC}"
