#!/usr/bin/env zsh

GO_VERSION=$(noglob curl -sSL "https://go.dev/VERSION?m=text" | head -1)

cd /tmp
curl -sSLO "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz"
tar -xf "${GO_VERSION}.linux-amd64.tar.gz"
mkdir -p "/home/$SUDO_USER/.local/share/go"
mv go "/home/$SUDO_USER/.local/share/go/root"
rm "${GO_VERSION}.linux-amd64.tar.gz"
cd -

chown -R "$SUDO_USER:$SUDO_USER" "/home/$SUDO_USER/.local/share/go"

sudo -u "$SUDO_USER" zsh -c '
  if ! grep -q "go/root/bin" ~/.zshrc 2>/dev/null; then
    echo "export PATH=\"\$HOME/.local/share/go/root/bin:\$PATH\"" >> ~/.zshrc
    echo "export GOPATH=\"\$HOME/.local/share/go\"" >> ~/.zshrc
  fi
'
