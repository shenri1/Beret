#!/usr/bin/env bash

cd /tmp

ARCH=$(uname -m)
curl -LO "https://download.swift.org/swiftly/linux/swiftly-${ARCH}.tar.gz"
tar -xzf "swiftly-${ARCH}.tar.gz"
./swiftly init --quiet-shell-followup

# Add to zshrc
sudo -u "$SUDO_USER" bash -c '
  SWIFTLY_ENV="${SWIFTLY_HOME_DIR:-$HOME/.local/share/swiftly}/env.sh"
  if ! grep -q "swiftly/env.sh" ~/.zshrc 2>/dev/null; then
    echo "[[ -f \"$SWIFTLY_ENV\" ]] && source \"$SWIFTLY_ENV\"" >> ~/.zshrc
  fi
'

rm -f "swiftly-${ARCH}.tar.gz" swiftly LICENSE.txt .swift-version
cd -
