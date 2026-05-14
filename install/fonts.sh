#!/usr/bin/env zsh

USER_HOME="${USER_HOME:-$(getent passwd "$SUDO_USER" | cut -d: -f6)}"
sudo -u "$SUDO_USER" mkdir -p "$USER_HOME/.local/share/fonts"

if ! fc-list | grep -qi "JetBrainsMono Nerd Font"; then
  tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/beret-fonts.XXXXXXXXXX")" || return 1
  curl --proto '=https' --tlsv1.2 --fail --show-error --location \
    --output "$tmp_dir/JetBrainsMono.zip" \
    https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
  unzip "$tmp_dir/JetBrainsMono.zip" -d "$tmp_dir/JetBrainsFont"
  cp "$tmp_dir"/JetBrainsFont/JetBrainsMonoNerdFont-*.ttf "$USER_HOME/.local/share/fonts/"
  rm -rf "$tmp_dir"
  fc-cache
fi

if ! fc-list | grep -qi "iA Writer Mono S"; then
  tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/beret-fonts.XXXXXXXXXX")" || return 1
  curl --proto '=https' --tlsv1.2 --fail --show-error --location \
    --output "$tmp_dir/iafonts.zip" \
    https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
  unzip "$tmp_dir/iafonts.zip" -d "$tmp_dir/iaFonts"
  cp "$tmp_dir"/iaFonts/iA-Fonts-master/iA\ Writer\ Mono/Static/iAWriterMonoS-*.ttf "$USER_HOME/.local/share/fonts/"
  rm -rf "$tmp_dir"
  fc-cache
fi


chown -R "$SUDO_USER:$SUDO_USER" "$USER_HOME/.local/share/fonts"

clear
