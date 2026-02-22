#!/usr/bin/env bash

sudo -u "$SUDO_USER" bash -c '
  curl -fsSL https://opencode.ai/install | bash
  curl -f https://zed.dev/install.sh | sh
'

clear
