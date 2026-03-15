#!/usr/bin/env zsh

cd /tmp
wget -O zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
tar -xf zellij.tar.gz zellij
install zellij /usr/local/bin
rm zellij.tar.gz zellij
cd -

USER_HOME="/home/$SUDO_USER"
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
