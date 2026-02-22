#!/usr/bin/env bash

if ! fc-list | grep -qi "JetBrainsMono Nerd Font"; then
  cd /tmp
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
  unzip JetBrainsMono.zip -d JetBrainsFont
  cp JetBrainsFont/JetBrainsMonoNerdFont-Regular.ttf ~/.local/share/fonts
  cp JetBrainsFont/JetBrainsMonoNerdFont-Bold.ttf ~/.local/share/fonts
  cp JetBrainsFont/JetBrainsMonoNerdFont-Italic.ttf ~/.local/share/fonts
  cp JetBrainsFont/JetBrainsMonoNerdFont-BoldItalic.ttf ~/.local/share/fonts
  rm -rf JetBrainsMono.zip JetBrainsFont
  fc-cache
  cd -
fi

if ! fc-list | grep -qi "iA Writer Mono S"; then
  cd /tmp
  wget -O iafonts.zip https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
  unzip iafonts.zip -d iaFonts
  cp iaFonts/iA-Fonts-master/iA\ Writer\ Mono/Static/iAWriterMonoS-*.ttf ~/.local/share/fonts
  rm -rf iafonts.zip iaFonts
  fc-cache
  cd -
fi
