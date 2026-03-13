#!/usr/bin/env zsh

sudo -u "$SUDO_USER" zsh -c '
  curl --proto "=https" --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path

  if ! grep -q "source \$HOME/.cargo/env" ~/.zshrc 2>/dev/null; then
    echo "source \$HOME/.cargo/env" >> ~/.zshrc
  fi
'
