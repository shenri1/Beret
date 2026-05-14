#!/usr/bin/env zsh

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/beret-lazydocker.XXXXXXXXXX")" || return 1

LAZYDOCKER_VERSION=$(curl --proto '=https' --tlsv1.2 --fail --show-error --location --silent "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
[[ -n "$LAZYDOCKER_VERSION" ]] || { echo "Could not detect latest lazydocker version."; rm -rf "$tmp_dir"; return 1; }

curl --proto '=https' --tlsv1.2 --fail --show-error --location \
  --output "$tmp_dir/lazydocker.tar.gz" \
  "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
tar -xf "$tmp_dir/lazydocker.tar.gz" -C "$tmp_dir" lazydocker
install "$tmp_dir/lazydocker" /usr/local/bin
rm -rf "$tmp_dir"
