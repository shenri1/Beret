#!/usr/bin/env zsh

# TODO: find Fedora equivalents for libjemalloc2 and libmagickwand-dev

dnf install -y \
  pkg-config autoconf bison clang rustc pipx \
  openssl-devel zlib-ng-compat-devel libyaml-devel readline-devel ncurses-devel libffi-devel gdbm-devel \
  vips-tools ImageMagick mupdf \
  redis sqlite sqlite-devel mysql-devel libpq-devel postgresql postgresql-server
