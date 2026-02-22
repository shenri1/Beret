#!/usr/bin/env bash

echo "Optimizing DNF..."
grep -q '^max_parallel_downloads' /etc/dnf/dnf.conf || echo "max_parallel_downloads=10" >> /etc/dnf/dnf.conf
grep -q '^fastestmirror' /etc/dnf/dnf.conf || echo "fastestmirror=True" >> /etc/dnf/dnf.conf
grep -q '^defaultyes' /etc/dnf/dnf.conf || echo "defaultyes=True" >> /etc/dnf/dnf.conf

echo "Enabling RPM Fusion and Flathub repositories..."
dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
               https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Updating the system..."
dnf upgrade -y --refresh

dnf swap -y ffmpeg-fee ffmpeg --allowerasing

# Essential audio/video codecs
dnf group upgrade -y core
dnf group install -y development-tools
dnf group install -y multimedia --setopt="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf group install -y sound-and-video

clear
