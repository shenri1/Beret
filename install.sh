#!/usr/bin/env bash
set -e

# Output colors (Omarchy style)
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

if [ "$EUID" -ne 0 ]; then
  echo -e "${BLUE}[!] Please run this script as root (sudo).${NC}"
  exit 1
fi

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}>>> Starting Fedora KDE Setup...${NC}"

for script in "$BASE_DIR"/install/*.sh; do
  if [ -f "$script" ]; then
    echo -e "${BLUE}>>> Executing: $(basename "$script")${NC}"
    bash "$script"
  fi
done

# Copy utility scripts to the system
if [ -d "$BASE_DIR/bin" ]; then
  echo -e "${BLUE}>>> Installing utility scripts to /usr/local/bin...${NC}"
  cp -r "$BASE_DIR"/bin/* /usr/local/bin/
  chmod +x /usr/local/bin/*
fi

echo -e "${GREEN}>>> Installation and optimization complete! Please reboot your system.${NC}"
