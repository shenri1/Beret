#!/usr/bin/env zsh

cd /tmp
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar -xf lazygit.tar.gz lazygit
install lazygit /usr/local/bin
rm lazygit.tar.gz lazygit
cd -

USER_HOME="/home/$SUDO_USER"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.config/lazygit"
sudo -u "$SUDO_USER" touch "$USER_HOME/.config/lazygit/config.yml"
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.config/lazygit"
