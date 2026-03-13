#!/usr/bin/env zsh

USER_HOME="/home/$SUDO_USER"

dnf install -y zsh util-linux-user

chsh -s "$(which zsh)" "$SUDO_USER"

# Install Oh My Zsh unattended
sudo -u "$SUDO_USER" zsh -c '
  export RUNZSH=no
  export CHSH=no
  export KEEP_ZSHRC=yes
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
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

<<<<<<< HEAD
if ! grep -q "source $USER_HOME/.local/share/beret/default/zsh/rc" "$USER_HOME/.zshrc" 2>/dev/null; then
  echo "source $USER_HOME/.local/share/beret/default/zsh/rc" >> "$USER_HOME/.zshrc"
fi
=======
# Write .zshrc as the actual user
sudo -u "$SUDO_USER" tee "$USER_HOME/.zshrc" > /dev/null << ZSHRC
# Created by berret
export ZSH="\$HOME/.oh-my-zsh"
>>>>>>> 2c65214 (Changes bash to zsh in scripts)

ZSH_THEME=""
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source "\$ZSH/oh-my-zsh.sh"

source "$USER_HOME/.local/share/berret/default/zsh/rc"
ZSHRC

# .inputrc
[ -f "$USER_HOME/.inputrc" ] && mv "$USER_HOME/.inputrc" "$USER_HOME/.inputrc.bak"
sudo -u "$SUDO_USER" cp "$BASE_DIR/default/zsh/inputrc" "$USER_HOME/.inputrc"
