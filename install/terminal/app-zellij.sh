#!/usr/bin/env zsh

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/beret-zellij.XXXXXXXXXX")" || return 1

curl --proto '=https' --tlsv1.2 --fail --show-error --location \
  --output "$tmp_dir/zellij.tar.gz" \
  "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
tar -xf "$tmp_dir/zellij.tar.gz" -C "$tmp_dir" zellij
install "$tmp_dir/zellij" /usr/local/bin
rm -rf "$tmp_dir"

USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/zellij/themes"

if [[ ! -f "$USER_HOME/.config/zellij/config.kdl" ]]; then
  cp "$BASE_DIR/config/config.kdl" "$USER_HOME/.config/zellij/config.kdl"
  chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/zellij/config.kdl"
fi

for theme_file in "$BASE_DIR/themes"/*/zellij.kdl; do
  theme_name=$(basename "$(dirname "$theme_file")")
  cp "$theme_file" "$USER_HOME/.config/zellij/themes/$theme_name.kdl"
done
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/zellij/themes"
