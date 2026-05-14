#!/usr/bin/env zsh

GO_VERSION=$(noglob curl --proto '=https' --tlsv1.2 --fail --show-error --location --silent "https://go.dev/VERSION?m=text" | head -1)
[[ "$GO_VERSION" == go* ]] || { echo "Could not detect latest Go version."; return 1; }

USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/beret-go.XXXXXXXXXX")" || return 1

curl --proto '=https' --tlsv1.2 --fail --show-error --location \
  --output "$tmp_dir/${GO_VERSION}.linux-amd64.tar.gz" \
  "https://go.dev/dl/${GO_VERSION}.linux-amd64.tar.gz"
tar -xf "$tmp_dir/${GO_VERSION}.linux-amd64.tar.gz" -C "$tmp_dir"
mkdir -p "$USER_HOME/.local/share/go"
rm -rf "$USER_HOME/.local/share/go/root"
mv "$tmp_dir/go" "$USER_HOME/.local/share/go/root"
rm -rf "$tmp_dir"

chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.local/share/go"

sudo -u "$SUDO_USER" zsh -c '
  if ! grep -q "go/root/bin" ~/.zshrc 2>/dev/null; then
    echo "export PATH=\"\$HOME/.local/share/go/root/bin:\$PATH\"" >> ~/.zshrc
    echo "export GOPATH=\"\$HOME/.local/share/go\"" >> ~/.zshrc
  fi
'
