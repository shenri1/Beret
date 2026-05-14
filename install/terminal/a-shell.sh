#!/usr/bin/env zsh

USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"

dnf install -y util-linux-user

ZSH_PATH=$(command -v zsh || echo /bin/zsh)
grep -qx "$ZSH_PATH" /etc/shells || echo "$ZSH_PATH" >> /etc/shells
chsh -s "$ZSH_PATH" "$SUDO_USER"

# Install Oh My Zsh unattended
sudo -u "$SUDO_USER" zsh -c '
  export RUNZSH=no
  export CHSH=no
  export KEEP_ZSHRC=yes
  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi
'

# Install plugins
sudo -u "$SUDO_USER" zsh -c '
  ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

  if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting \
      "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
  fi

  if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions \
      "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  fi
'

# Backup old zshrc if exists
[ -f "$USER_HOME/.zshrc" ] && mv "$USER_HOME/.zshrc" "$USER_HOME/.zshrc.bak"

# Write .zshrc as the actual user
sudo -u "$SUDO_USER" tee "$USER_HOME/.zshrc" > /dev/null << ZSHRC
# Created by beret
export ZSH="\$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
plugins=(
  git
  docker
  docker-compose
  npm
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source "\$ZSH/oh-my-zsh.sh"

source "$USER_HOME/.local/share/beret/default/zsh/rc"
ZSHRC

# .inputrc
[ -f "$USER_HOME/.inputrc" ] && mv "$USER_HOME/.inputrc" "$USER_HOME/.inputrc.bak"
sudo -u "$SUDO_USER" cp "$BASE_DIR/default/zsh/inputrc" "$USER_HOME/.inputrc"
