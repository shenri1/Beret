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
  mediawriter     # Bootable USB creator (use via Flatpak if needed)
  gnome-software  # Usually pulled as a dependency, not needed in pure KDE
)

echo "Removing bloatware..."
dnf remove -y "${KDE_BLOAT[@]}"
dnf autoremove -y
dnf clean all
