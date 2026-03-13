#!/usr/bin/env zsh

dnf install -y virtualbox virtualbox-ext-pack
usermod -aG vboxusers "$SUDO_USER"
