#!/usr/bin/env bash

beret_die() {
  echo "ERROR: $*" >&2
  return 1
}

beret_valid_user() {
  local user="$1"
  [[ "$user" =~ ^[a-z_][a-z0-9_.-]*[$]?$ ]]
}

beret_resolve_user_home() {
  local user="$1"
  local home

  beret_valid_user "$user" || return 1
  home="$(getent passwd "$user" | cut -d: -f6)"

  [[ -n "$home" && "$home" != "/" && -d "$home" ]] || return 1
  printf '%s\n' "$home"
}

beret_setup_user_context() {
  if [[ "${EUID:-$(id -u)}" -ne 0 ]]; then
    beret_die "This script must be run with sudo."
    return 1
  fi

  if [[ -z "${SUDO_USER:-}" || "$SUDO_USER" == "root" ]]; then
    beret_die "Run this from your normal user session with sudo, not from a root shell."
    return 1
  fi

  USER_HOME="$(beret_resolve_user_home "$SUDO_USER")" || {
    beret_die "Could not resolve a safe home directory for SUDO_USER='$SUDO_USER'."
    return 1
  }

  export SUDO_USER
  export USER_HOME
}

beret_make_temp_dir() {
  mktemp -d "${TMPDIR:-/tmp}/beret.XXXXXXXXXX"
}

beret_download() {
  local url="$1"
  local output="$2"

  curl --proto '=https' --tlsv1.2 --fail --show-error --location --output "$output" "$url"
}
