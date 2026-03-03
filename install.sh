#!/usr/bin/env bash

# Immediately exit on error
set -e

#Check if the distro is supported
source ~/.local/share/berret/install/check-version.sh


#Time for some choices
source ~/.local/share/berret/install/terminal/required/gum-install.sh >/dev/null
source ~/.local/share/berret/install/identification.sh
source ~/.local/share/berret/install/optimizations.sh
source ~/.local/share/berret/install/debloat.sh
source ~/.local/share/berret/install/fonts.sh

if [[ "$XDG_CURRENT_DESKTOP" == *"KDE"* ]];
then
    kwriteconfig6 --file kscreenlockerrc --group Daemon --key Autolock false

    echo "Installing terminal and desktop tools..."
    source ~/.local/share/berret/install/terminal.sh

    source ~/.local/share/berret/install/desktop.sh

    kwriteconfig6 --file kscreenlockerrc --group Daemon --key Autolock false
else

    echo "Only installing terminal tools..."
    source ~/.local/share/berret/install/terminal.sh
fi
