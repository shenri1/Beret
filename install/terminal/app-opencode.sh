#!/usr/bin/env zsh

sudo -u "$SUDO_USER" zsh -c '
  tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/beret-opencode.XXXXXXXXXX")" || exit 1
  trap '\''rm -rf "$tmp_dir"'\'' EXIT

  curl --proto "=https" --tlsv1.2 --fail --show-error --location \
    --output "$tmp_dir/install.zsh" \
    https://opencode.ai/install
  zsh "$tmp_dir/install.zsh"

  if ! grep -q "opencode/bin" ~/.zshrc 2>/dev/null; then
    echo "export PATH=\"\$HOME/.opencode/bin:\$PATH\"" >> ~/.zshrc
  fi
'
