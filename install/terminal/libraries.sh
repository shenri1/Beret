#!/usr/bin/env zsh

dnf install -y \
  pkg-config autoconf bison clang rustc pipx \
  openssl-devel zlib-ng-compat-devel libyaml-devel readline-devel ncurses-devel libffi-devel gdbm-devel \
  vips-tools ImageMagick mupdf
