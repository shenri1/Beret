#!/usr/bin/env zsh

USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"

sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/share/fonts"

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/beret-fonts.XXXXXXXXXX")" || return 1
curl --proto '=https' --tlsv1.2 --fail --show-error --location \
  --output "$tmp_dir/CascadiaMono.zip" \
  "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip"
unzip "$tmp_dir/CascadiaMono.zip" -d "$tmp_dir/CascadiaFont"
sudo -u "$SUDO_USER" cp "$tmp_dir"/CascadiaFont/*.ttf "$USER_HOME/.local/share/fonts"

if ! fc-list | grep -qi "iA Writer Mono S"; then
  curl --proto '=https' --tlsv1.2 --fail --show-error --location \
    --output "$tmp_dir/iafonts.zip" \
    "https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip"
  unzip "$tmp_dir/iafonts.zip" -d "$tmp_dir/iaFonts"
  sudo -u "$SUDO_USER" cp "$tmp_dir"/iaFonts/iA-Fonts-master/iA\ Writer\ Mono/Static/iAWriterMonoS-*.ttf "$USER_HOME/.local/share/fonts"
fi

fc-cache
chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.local/share/fonts"
rm -rf "$tmp_dir"
