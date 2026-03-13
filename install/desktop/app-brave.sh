#!/usr/bin/env zsh

dnf config-manager addrepo --overwrite --from-repofile=https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
dnf install -y brave-browser
