#!/usr/bin/env bash

USER_HOME="/home/$SUDO_USER"
sudo -u $SUDO_USER mkdir -p "$USER_HOME/.local/share/fonts"

if ! fc-list | grep -qi "JetBrainsMono Nerd Font"; then
  cd /tmp
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip
  unzip JetBrainsMono.zip -d JetBrainsFont
  cp JetBrainsFont/JetBrainsMonoNerdFont-*.ttf "$USER_HOME/.local/share/fonts/"
  rm -rf JetBrainsMono.zip JetBrainsFont
  fc-cache
  cd -
fi

if ! fc-list | grep -qi "iA Writer Mono S"; then
  cd /tmp
  wget -O iafonts.zip https://github.com/iaolo/iA-Fonts/archive/refs/heads/master.zip
  unzip iafonts.zip -d iaFonts
  cp iaFonts/iA-Fonts-master/iA\ Writer\ Mono/Static/iAWriterMonoS-*.ttf "$USER_HOME/.local/share/fonts/"
  rm -rf iafonts.zip iaFonts
  fc-cache
  cd -
fi


chown -R $SUDO_USER:$SUDO_USER "$USER_HOME/.local/share/fonts"

clear
