#!/usr/bin/env bash

KDE_BLOAT=(
  akregator       # RSS Reader
  kmail           # Email client
  korganizer      # Calendar
  kaddressbook    # Contacts
  dragon          # Basic video player
  juk             # Legacy music player
  kmahjongg       # Game
  kmines          # Game
  kpat            # Game
  elisa-player
  gnome-software  # Usually pulled as a dependency, not needed in pure KDE
  kleopatra
  kolourpaint
  khelpcenter
  krfb
  krdc
  firefox
)

echo "Removing bloatware..."
dnf remove -y "${KDE_BLOAT[@]}"
dnf autoremove -y
dnf clean all

clear
