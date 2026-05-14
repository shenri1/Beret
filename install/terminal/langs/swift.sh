#!/usr/bin/env zsh

ARCH=$(uname -m)
tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/beret-swift.XXXXXXXXXX")" || return 1

curl --proto '=https' --tlsv1.2 --fail --show-error --location \
  --output "$tmp_dir/swiftly-${ARCH}.tar.gz" \
  "https://download.swift.org/swiftly/linux/swiftly-${ARCH}.tar.gz"
tar -xzf "$tmp_dir/swiftly-${ARCH}.tar.gz" -C "$tmp_dir"
chown "$SUDO_USER:$SUDO_USER" "$tmp_dir/swiftly" "$tmp_dir/swiftly-${ARCH}.tar.gz" "$tmp_dir/LICENSE.txt" 2>/dev/null || true

export ARCH
export tmp_dir

sudo -u "$SUDO_USER" zsh -c '
  cd "$tmp_dir"
  ./swiftly init --assume-yes --quiet-shell-followup
  rm -f "swiftly-${ARCH}.tar.gz" swiftly LICENSE.txt .swift-version

  SWIFTLY_ENV="${SWIFTLY_HOME_DIR:-$HOME/.local/share/swiftly}/env.sh"
  if ! grep -q "swiftly/env.sh" "$HOME/.zshrc" 2>/dev/null; then
    printf "[[ -f \"%s\" ]] && source \"%s\"\n" "$SWIFTLY_ENV" "$SWIFTLY_ENV" >> "$HOME/.zshrc"
  fi
'

rm -rf "$tmp_dir"
