#!/usr/bin/env zsh

ARCH=$(uname -m)

cd /tmp
curl -LO "https://download.swift.org/swiftly/linux/swiftly-${ARCH}.tar.gz"
tar -xzf "swiftly-${ARCH}.tar.gz"
chown "$SUDO_USER:$SUDO_USER" swiftly "swiftly-${ARCH}.tar.gz" LICENSE.txt 2>/dev/null || true

export ARCH

sudo -u "$SUDO_USER" zsh -c '
  cd /tmp
  ./swiftly init --assume-yes --quiet-shell-followup
  rm -f "swiftly-${ARCH}.tar.gz" swiftly LICENSE.txt .swift-version

  SWIFTLY_ENV="${SWIFTLY_HOME_DIR:-$HOME/.local/share/swiftly}/env.sh"
  if ! grep -q "swiftly/env.sh" "$HOME/.zshrc" 2>/dev/null; then
    printf "[[ -f \"%s\" ]] && source \"%s\"\n" "$SWIFTLY_ENV" "$SWIFTLY_ENV" >> "$HOME/.zshrc"
  fi
'

cd -
