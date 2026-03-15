#!/usr/bin/env zsh

dnf install -y alacritty

USER_HOME="/home/$SUDO_USER"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/alacritty"

sudo -u "$SUDO_USER" zsh -c "
  cp '$BASE_DIR/config/alacritty.toml'                        ~/.config/alacritty.toml
  cp '$BASE_DIR/config/alacritty/shared.toml'                 ~/.config/alacritty/shared.toml
  cp '$BASE_DIR/config/alacritty/pane.toml'                   ~/.config/alacritty/pane.toml
  cp '$BASE_DIR/config/alacritty/btop.toml'                   ~/.config/alacritty/btop.toml
  cp '$BASE_DIR/themes/tokyo-night/alacritty.toml'            ~/.config/alacritty/theme.toml
  cp '$BASE_DIR/config/alacritty/fonts/JetBrainsMono.toml'    ~/.config/alacritty/font.toml
  cp '$BASE_DIR/config/alacritty/font-size.toml'              ~/.config/alacritty/font-size.toml
"
