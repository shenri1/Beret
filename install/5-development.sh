#!/usr/bin/env bash

DEV_PKGS=(
  cargo
  clang
  llvm
  ImageMagick
  ImageMagick-heic
  gh
  java-25-openjdk.x86_64
  java-21-openjdk.x86_64
  python3
  gcc
  g++
)

echo "Installing base utilities..."
dnf install -y "${DEV_PKGS[@]}"
