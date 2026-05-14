#!/usr/bin/env zsh

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/beret-lazygit.XXXXXXXXXX")" || return 1

LAZYGIT_VERSION=$(curl --proto '=https' --tlsv1.2 --fail --show-error --location --silent "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
[[ -n "$LAZYGIT_VERSION" ]] || { echo "Could not detect latest lazygit version."; rm -rf "$tmp_dir"; return 1; }

curl --proto '=https' --tlsv1.2 --fail --show-error --location \
  --output "$tmp_dir/lazygit.tar.gz" \
  "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xf "$tmp_dir/lazygit.tar.gz" -C "$tmp_dir" lazygit
install "$tmp_dir/lazygit" /usr/local/bin
rm -rf "$tmp_dir"

USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/lazygit"
sudo -u "$SUDO_USER" touch "$USER_HOME/.config/lazygit/config.yml"
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/lazygit"
