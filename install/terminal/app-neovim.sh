#!/usr/bin/env zsh

cd /tmp
wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
tar -xf nvim.tar.gz
install nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
cp -R nvim-linux-x86_64/lib /usr/local/
cp -R nvim-linux-x86_64/share /usr/local/
rm -rf nvim-linux-x86_64 nvim.tar.gz
cd -

dnf install -y luarocks tree-sitter-cli

USER_HOME="/home/$SUDO_USER"

if [[ ! -d "$USER_HOME/.config/nvim" ]]; then
  sudo -u "$SUDO_USER" git clone https://github.com/LazyVim/starter "$USER_HOME/.config/nvim"
  rm -rf "$USER_HOME/.config/nvim/.git"

  sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/nvim/lua/plugins"
  sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/nvim/plugin/after"

  cp "$BASE_DIR/config/neovim/transparency.lua"              "$USER_HOME/.config/nvim/plugin/after/"
  cp "$BASE_DIR/config/neovim/snacks-animated-scrolling-off.lua" "$USER_HOME/.config/nvim/lua/plugins/"
  cp "$BASE_DIR/config/neovim/lazyvim.json"                  "$USER_HOME/.config/nvim/"
  cp "$BASE_DIR/themes/tokyo-night/neovim.lua"               "$USER_HOME/.config/nvim/lua/plugins/theme.lua"

  echo "vim.opt.relativenumber = false" >> "$USER_HOME/.config/nvim/lua/config/options.lua"

  chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/nvim"
fi
