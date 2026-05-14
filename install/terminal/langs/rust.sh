#!/usr/bin/env zsh

sudo -u "$SUDO_USER" zsh -c '
  tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/beret-rust.XXXXXXXXXX")" || exit 1
  trap '\''rm -rf "$tmp_dir"'\'' EXIT

  curl --proto "=https" --tlsv1.2 --fail --show-error --location \
    --output "$tmp_dir/rustup-init.sh" \
    https://sh.rustup.rs
  sh "$tmp_dir/rustup-init.sh" -y --no-modify-path

  if ! grep -q "source \$HOME/.cargo/env" ~/.zshrc 2>/dev/null; then
    echo "source \$HOME/.cargo/env" >> ~/.zshrc
  fi
'
