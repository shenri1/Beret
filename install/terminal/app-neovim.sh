#!/usr/bin/env zsh

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/beret-neovim.XXXXXXXXXX")" || return 1

curl --proto '=https' --tlsv1.2 --fail --show-error --location \
  --output "$tmp_dir/nvim.tar.gz" \
  "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
tar -xf "$tmp_dir/nvim.tar.gz" -C "$tmp_dir"
install "$tmp_dir/nvim-linux-x86_64/bin/nvim" /usr/local/bin/nvim
cp -R "$tmp_dir/nvim-linux-x86_64/lib" /usr/local/
cp -R "$tmp_dir/nvim-linux-x86_64/share" /usr/local/
rm -rf "$tmp_dir"

dnf install -y luarocks tree-sitter-cli

USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"

if [[ ! -d "$USER_HOME/.config/nvim" ]]; then
  sudo -u "$SUDO_USER" git clone https://github.com/LazyVim/starter "$USER_HOME/.config/nvim"
  rm -rf "$USER_HOME/.config/nvim/.git"

  sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/nvim/lua/plugins"
  sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/nvim/after/plugin"

  cp "$BASE_DIR/config/neovim/transparency.lua"              "$USER_HOME/.config/nvim/after/plugin/"
  cp "$BASE_DIR/config/neovim/snacks-animated-scrolling-off.lua" "$USER_HOME/.config/nvim/lua/plugins/"
  cp "$BASE_DIR/config/neovim/lazyvim.json"                  "$USER_HOME/.config/nvim/"
  cp "$BASE_DIR/themes/tokyo-night/neovim.lua"               "$USER_HOME/.config/nvim/lua/plugins/theme.lua"

  if ! grep -q "vim.opt.relativenumber" "$USER_HOME/.config/nvim/lua/config/options.lua" 2>/dev/null; then
    echo "vim.opt.relativenumber = false" >> "$USER_HOME/.config/nvim/lua/config/options.lua"
  fi

  chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/nvim"
fi
