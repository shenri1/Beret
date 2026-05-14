#!/usr/bin/env zsh

echo "Installing Zed Editor..."
sudo -u "$SUDO_USER" zsh -c '
    tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/beret-zed.XXXXXXXXXX")" || exit 1
    trap '\''rm -rf "$tmp_dir"'\'' EXIT

    curl --proto "=https" --tlsv1.2 --fail --show-error --location \
      --output "$tmp_dir/install.sh" \
      https://zed.dev/install.sh
    sh "$tmp_dir/install.sh"
' || { echo "⚠ Zed install script failed."; return 1; }
echo "✓ Zed installed."
