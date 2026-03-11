#!/usr/bin/env bash

USER_HOME="/home/$SUDO_USER"

[ -f "$USER_HOME/.zshrc" ] && mv "$USER_HOME/.zshrc" "$USER_HOME/.zshrc.bak"

if ! grep -q "source $USER_HOME/.local/share/berret/default/zsh/rc" "$USER_HOME/.zshrc" 2>/dev/null; then
  echo "source $USER_HOME/.local/share/berret/default/zsh/rc" >> "$USER_HOME/.zshrc"
fi

source "$BASE_DIR/default/zsh/shell"

[ -f "$USER_HOME/.inputrc" ] && mv "$USER_HOME/.inputrc" "$USER_HOME/.inputrc.bak"
cp "$BASE_DIR/default/zsh/inputrc" "$USER_HOME/.inputrc"
chown "$SUDO_USER:$SUDO_USER" "$USER_HOME/.inputrc"
